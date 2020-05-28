#!/bin/bash
casa=$HOME
#add current position of the script in order to avoid misunderstanding for the followind IF statement
if [[ $EUID -ne 0 ]];
then
    exec sudo ./formatta_dischi_collegati.sh 
fi
#da fare: mettere la formattazione con gutmann come quarta voce del menù e, soprattutto, usare un IF per verficare che comando dare o che serie di comandi dare per evitare due funzioni


# Find the rows and columns will default to 80x24 is it can not be detected
screen_size=$(stty size 2>/dev/null || echo 24 80) 
rows=$(echo $screen_size | awk '{print $1}')
columns=$(echo $screen_size | awk '{print $2}')

# Definisco le dimensioni dell'interfaccia:
r=$(( rows / 2 ))
c=$(( columns / 2 ))
# e nel caso in cui lo schermo sia piccolo
r=$(( r < 20 ? 20 : r ))
c=$(( c < 70 ? 70 : c ))


declare -a partitions=()
spengo=true
nome_file="dejavu.img"
version="0.0.2 1/2"
titolo="Piallatore seriale"

server="" #it has to be set before starting a download. it could be an IP address or a symbolic address

percorso_server="$server/$nome_file"
percorso_server_md5="$server~/$nome_file.md5"
cartella_di_lavoro="$casa/.iso_dejavu"
percorso_locale="$cartella_di_lavoro/$nome_file"
percorso_locale_md5="$cartella_di_lavoro/$nome_file.md5"
percorso_locale_md5_scaricato="$cartella_di_lavoro/dejavu_nuovo.img.md5"

#testing for removal
#user="server"
#passwd=""

dischi_totali=0


function prepara_file ()
{
    file="$casa/.tmp_part.txt"
    mkdir -p $cartella_di_lavoro
    sudo chmod 777 --recursive $cartella_di_lavoro
    rm -rf .counter
    rm -rf '$file'
    touch '$file'
    
}

function scan_disks ()
{
    clear
    sudo lsblk -io KNAME,TYPE,MOUNTPOINT  >> '$file'  
}



function get_disks ()
{
    indice=0
    indicei=0
    dischi_totali=0
    lista_dischi=()
    prepara_file
    scan_disks

    while read nome tipo punto_di_mount 
    do
        if [ "$punto_di_mount" == "/" ] ;
        then
            da_evitare=$nome
        fi
    done < '$file' 
    tipo_disco="${da_evitare::-5}"
    case "$tipo_disco" in
	    nvme)	da_evitare="${da_evitare::-2}" ;;
	    *) da_evitare="${da_evitare::-1}";;	
    esac

    while read nome tipo punto_di_mount 
    do
        if [ "$tipo" == "disk" -a "$da_evitare" != "$nome" ] ;
        then
            lista_dischi+=("$nome")
        fi
    done < '$file'
    for i in ${lista_dischi[@]}; do
        (( dischi_totali += 1))
        #echo $i #for debub
    done
    echo "ho trovato $dischi_totali"
}


function formatta ()
{
    touch .counter
    for i in ${lista_dischi[@]};
    do
        rm log_"$i" 2>/dev/null
        #touch log_"$i" 
        rm -rf .tmp_"$i" 2>/dev/null
        echo "Avvio il disco /dev/$i"
        echo "echo 'Avvio il disco /dev/$i'" >> .tmp_"$i"
       
        #badblocks part, 4 destructive path
        #echo "sudo badblocks -fwsv /dev/$i >> log_$i" >> .tmp_"$i" 
	
	#DD with another 0 path
        #echo "dd if=/dev/zero of=/dev/$i status=progress" >> .tmp_"$i"
	
	#test part for writing on log file that there were errors
        #&& echo 'no error on /dev/$i at starting time $(date)'>> log_$i || echo 'error on /dev/$i at starting time $(date)'
	
        echo "echo '1' >> .counter" >> .tmp_"$i"
        echo "rm .tmp_$i" >> .tmp_"$i"
        echo "exit 0" >> .tmp_"$i"
        chmod +x .tmp_"$i"
        sudo x-terminal-emulator -e "./.tmp_$i" & #to be tesetd
        #sudo xfce4-terminal -e "./.tmp_$i" &
        #mate-terminal -e "./.tmp_$i" &
        #gnome-terminal --command "./.tmp_$i" &
    done
    rm -rf '$file'
    
    while [ $indice -lt ${#lista_dischi[@]} ];do
        indice=0
        sleep 1 #to be set correctly, usually it has to check every 30 minutes if the formatting is finished
        while read contatore 
        do
          #echo $tipo	#debug
            (( indice += $contatore))
        done < ".counter" 
	echo $(( $indice * 100 / $dischi_totali )) | dialog --title "$titolo" --gauge "Avanzamento formattazione..." $r $c 0
	done
	clear
    
    
    for i in ${lista_dischi[@]};
    do
    
    if [ -s log_"$i" ] 
    then
    	#echo "$_file has some data."	#debug
        smartctl -i /dev/"$i" >> log_"$i" 
    else
    	#echo "$_file is empty."	#debug
        rm log_"$i" 2>/dev/null     
    fi
    
    done
    
    
    rm -rf .counter 2>/dev/null
}
    
    
function formattag ()
{
    for i in ${lista_dischi[@]};
    do
        rm log_"$i" 2>/dev/null
        #touch log_"$i" 
        rm -rf .tmp_"$i"
        echo "Avvio il disco /dev/$i"
        echo "echo 'Avvio il disco /dev/$i'" >> .tmp_"$i"

	#Gutmann method
        #echo "sudo nwipe --autonuke --logfile=log_$i --method=gutmann /dev/$i " >> .tmp_"$i"
	
        echo "echo '1' >> .counter" >> .tmp_"$i"
        echo "rm .tmp_$i" >> .tmp_"$i"
        echo "exit 0" >> .tmp_"$i"
        chmod +x .tmp_"$i"
        sudo x-terminal-emulator -e "./.tmp_$i" &
        #mate-terminal -e "./.tmp_$i" &
        #gnome-terminal --command "./.tmp_$i" &
    done
    rm -rf '$file'
    
    while [ $indice -lt ${#lista_dischi[@]} ];do
        indice=0
        sleep 1
        while read contatore 
        do
          #echo $tipo	#debug
            (( indice += $contatore))
            
        done < ".counter" 
    
    done

    rm -rf .counter
}

function check_img_update ()

{
    sudo rm -rf "$percorso_locale_md5_scaricato"	#to be tested
    wget "{$percorso_server_md5}"
    #curl --user "$user":"$passwd" -o "$percorso_locale_md5_scaricato" "{$percorso_server_md5}"
    
    #computing MD5 checksum
    md5sum "$percorso_locale" | awk '{ print $1}' > "$percorso_locale_md5"

    md5_server=$(sudo head -n 1 "$percorso_locale_md5_scaricato") #md5sum just downloaded
    md5_local=$(sudo head -n 1 "$percorso_locale_md5") #md5sum already on local drive

    if [ "$md5_local" = "$md5_server" ] ; then
            echo "non aggiorno"
            #if I'm here it means that i dont have to update the img file
        else
            echo "aggiorno"
            sudo mv "$percorso_locale_md5_scaricato" "$percorso_locale_md5"
	    wget "{$percorso_server}" #to be tested
            #sudo curl --user "$user":"$passwd" -o "$percorso_locale" "{$percorso_server}"
    fi

}


function installa ()

{
    touch .i_counter
    for i in ${lista_dischi[@]};
    do
        rm log_i_"$i" 2>/dev/null
        #touch log_"$i" 
        rm -rf .tmp_i_"$i" 2>/dev/null
        echo "Avvio il disco /dev/$i"
        echo "echo 'Avvio il disco /dev/$i'" >> .tmp_i_"$i"
	#Installing with DD
        #echo "dd if=percorso_iso of=/dev/$i status=progress" >> .tmp_i_"$i"
        
	echo "echo '1' >> .i_counter" >> .tmp_i_"$i"
        echo "rm .tmp_i_$i" >> .tmp_i_"$i"
        echo "exit 0" >> .tmp_"$i"
        chmod +x .tmp_i_"$i"
        sudo x-terminal-emulator -e "./.tmp_i_$i" &

        #sudo xfce4-terminal -e "./.tmp_i_$i" &
        #mate-terminal -e "./.tmp_i_$i" &
        #gnome-terminal --command "./.tmp_i_$i" &
    done
    rm -rf '$file'

        while [ $indicei -lt ${#lista_dischi[@]} ];do
        indicei=0
        sleep 1 #to be set correctly, usually it has to check every 30 minutes if the formatting is finished
            while read contatore 
            do
                (( indicei += $contatore))
            done < ".i_counter" 
            echo $(( $indicei * 100 / $dischi_totali )) | dialog --title "$titolo" --gauge "Avanzamento installazione..." $r $c 0
            #echo $indicei
        done
        clear

    rm -rf .i_counter 2>/dev/null 


}

function spegnimento ()
{
    if (whiptail  --title "$titolo" --yesno "Spengo il pc alla fine?" $r $c ); then
        spengo=true
    
    else
        spengo=false
    fi
}

function spegni () 
{
if [ "$spengo" = true ]; then
    sudo poweroff
fi 
}

function dipendenze ()

{
    {
        echo "\Installo nwipe.."
        sudo apt install nwipe -y 2>/dev/null
        echo 50
        echo "\Installo wget.."
        sudo apt install wget -y 2>/dev/null
        echo 100

    } |whiptail --title "$titolo" --gauge "Controllo le dipendenze" $r $c 0
}


##inizio prorgamma##

clear



W=$(whiptail --title "Menù $titolo $version" --menu "Elenco delle funzionalità del Piallatore:" $r $c 6 \
	"1" "Piallo i dischi, installo il sistema e me ne esco" \
	"2" "Piallo i dischi" \
	"3" "Installo il sistema"  3>&1 1>&2 2>&3)

case "$W" in 
	1)	spegnimento
	    	dipendenze
		get_disks 
		check_img_update &
		formatta
		get_disks 
		installa 
		spegni ;;
	2)	spegnimento
		get_disks
		formatta
		spegni ;;
	3)	spegnimento
		dipendenze
		get_disks
		check_img_update
		installa
		spegni ;;
				
	*) exit 1 ;;
esac


exit 0
