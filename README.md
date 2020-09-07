# Dejavu Formatting Tool

### Index (English)

 - Introduction
 - Who we are
 - Installation
 - To-do list
 - How to contribure

### Index (Italian)

 - Introduzione
 - Chi siamo
 - Installazione
 - To-do list
 - Come contribuire


# ENG:

## Introduction:

The Dejavu Formatting Tool is a tool, written in shell bash, useful to perform a low level format on several drives regardless if they are HDDs (sata/pata), SSDs or USB devices.

We have implemented two formatting method: the first one is based on the combination of BadBlocks and DD and it's able to perform 4 pattern at low level for testing the device (BadBlocks) and then an extra pattern with only zeroes (DD); the second method is based on Nwipe and it will perform Gutmann algorithm for a total of 35 pattern at low level.
The Tool let you chose the method you prefer before starting or a default one.

The other feature that will be implemented in the near future is the installation of the official Dejavu OS: a remix version of [Linux Mint](https://linuxmint.com/) complete of a set of application useful to cope with disabled people.

## Who we are:

We are an onlus no-profit called [Credere Per Vedere](https://translate.google.com/translate?um=1&ie=UTF-8&hl=it&client=tw-ob&sl=it&tl=en&u=http%3A%2F%2Fwww.crederepervedere.org) based in Reggio Emilia (Italy) that recycle, restore and donate old PCs with the help of disabled people. This is possible thanks to the [Dejavu project](https://translate.google.com/translate?um=1&ie=UTF-8&hl=it&client=tw-ob&sl=it&tl=en&u=http%3A%2F%2Fprogettodejavu.blogspot.com%2F), which is a moment in which people with disabilities come from the structures where they live to work with us.


## Installation:
To install the Dejavu Formatting Tool there are two options:
- Installing from wget
```sh
wget https://raw.githubusercontent.com/94-psy/Dejavu-Formatting-Tool/master/DFTool -O /usr/bin/DFTool
sudo chmod 775 /usr/bin/DFTool
```
- Downloading the Git repository
```sh
git clone https://github.com/94-psy/Dejavu-Formatting-Tool.git
cd Dejavu-Formatting-Tool
sudo chmod 775 DFTool ; ./DFTool
```
Then you can use the menu, after the configuration, to install it in your system.


## To-do list:
-[ ] Finish the README
-[ ] Download and installation of the Dejavu OS
-[ ] Improve translation
-[ ] Look for tester
## How to contribure:
Follow us on social media, come to visit us, give us help and tips with the program or give us a coffee (on our site)
Seguiteci sulle nostre pagine social, venite a trovarci, dateci un parere/consiglio sul programma o fai una donazione sul nostro sito!

------------------------------------------------------------------------------------------------
# ITA:

## Introduzione:

Il Dejavu Formatting Tool è un tool, scritto in shell bash, utile per formattare a basso livello differenti dispositivi, sia che essi siano HDD (sata/pata), SSD o dispositivi USB.

Abbiamo implementato due metodi di formattazioni: il primo è basato sulla combinazione di BadBlocks e DD, capace di fare 4 passaggi a basso livello testando anche il dispositivo (BadBlocks) e uno extra con soli zeri (DD); il secondo metodo è basato su Nwipe ed esegue l'algoritmo di Gutmann, per un totale di 35 passaggi a basso livello.
Il Tool consente di scegliere il metodo che si preferisce prima di iniziare la formattazione o anche uno di default.

L'altra feature che sarà implementata nel prossimo futuro è l'installazione del sistema operativo ufficiale Dejavu: una versione remix di [Linux Mint](https://linuxmint.com/) completa di un set di applicazioni per supportare i ragazzi diversamente abili.

## Chi siamo:
Siamo una onlus no-profit chiamata [Credere Per Vedere](http://www.crederepervedere.org/) con sede a Reggio Emilia (Italia) che ricicla, ripristina e dona, coi ragazzi diversamente abili, PC vecchi. Questo è possibile grazie al [progetto Dejavu](http://progettodejavu.blogspot.com/), che è che un momento in cui i ragazzi diversamente abili escono dalle strutture in cui vivono per venire a lavorare con noi.
## Installazione:
Per installare il Dejavu Formatting Tool ci sono due opzioni:
- Installazione da wget
```sh
wget https://raw.githubusercontent.com/94-psy/Dejavu-Formatting-Tool/master/DFTool -O /usr/bin/DFTool
sudo chmod 775 /usr/bin/DFTool
```
- Download dal repository di Git
```sh
git clone https://github.com/94-psy/Dejavu-Formatting-Tool.git
cd Dejavu-Formatting-Tool
sudo chmod 775 DFTool ; ./DFTool
```
A questo punto si può installare nel sistema dal menù del programma, dopo la configurazione.

## To-do list:
-[ ] Finire il README
-[ ] Download e installazione del Dejavu OS
-[ ] Migliorare le traduzioni
-[ ] Cercare dei tester
## Come contribuire:

Seguiteci sulle nostre pagine social, venite a trovarci, dateci un parere/consiglio sul programma o offrici un caffè sul nostro sito
