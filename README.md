# Piallatore-seriale

##ENG:

The Piallatore-seriale is a tool, made in shell bash, useful for destroying data on your hard disks. It's designed to work with several drives at the same time and also to install your IMG or ISO file.

There are two possible formatting ways: one "soft" with the combination of BadBlocks and DD for a total of 5 patterns at low level; one more intense, with the Gutmann method for a total of 35 pattern.

There is also an option that allows you to install your ISO or IMG or what you want: you have to set the name of your file and the MD5 checksum file in the tool, at the moment, and the it will compare the local MD5 with the one taken from the server to understand if you have the correct file (it's in testing and I'm not sure it's an universal way, so I recommend you to use with your personal servers or to rewrite the MD5 calculation/check). If not it will download the latest/corerct one and then it will install via DD on all the devices.

At the moment it works with every usb and sata device. It should work also with NVME devices and IDE devices ( i will test some IDE in the future)

Future improving:

- add a config file for server path, file type, and other settings
- add English interface

---------------------------------------------------------------------------------

##ITA:

Il Piallatore-seriale è un tool, fatto in shell bash, utile per distruggere i dati dei tuoi hard disk. Il tool è progettato per lavorare con diversi dischi allo stesso tempo e anche per installare i tuoi file IMG o ISO.

Ci sono due posibili tipi di formattazioni: una più "leggera" che combina BadBlocks e DD per un totale di 5 passaggi a basso livello; una più intensa che sfrutta il metodo Gutmann per un totale di 35 passaggi a basso livello.

C'è anche un'opzione che consente di installare la propria immagine ISO o IMG o qual si voglia: bisogna solo impostare il nome del file che si vuole scaricare e del file MD5 dentro il tool, al momento, e questo confronterà il file MD5 in locale con quello scaricato dal server per capire se si avesse il file corretto ( è ancora in fase di test e non sono sicuro sia un metodo universale, quindi raccomando di usarlo su server personali o di riscrivere la parte di controllo e calcolo del check MD5). Se non fosse il file corretto, il tool scaricherà l'ultima versione, o quella corretta, presente sul server e la installerà con DD su tutti i dispositivi connessi.

Al momento lavora con tutti i dispositivi USB e SATA. Dovrebbe funzionare anche coi dispositivi NVME e IDE (testerò i dispositivi IDE in futuro)

Miglioramenti futuri:

- aggiunta di un file di configurazione per il percorso del server, tipologia di file e altre impostazioni
- aggiunta dell'interfaccia in inglese
