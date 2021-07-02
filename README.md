# FileWave Multiple install update Script
All-in-One Scritp für Filewave Installationen 

## Voraussetzungen
Für die richtige funktion des Scriptes ist ein Filewave Account voraussetzung!
Da der Download Link im Script nicht ersichtlich ist, diesen muss man einmalig eintragen.
Nach eintragen des Links kann man den installer verweden.

### Pakete installieren
```bash
yum -y install git nano wget unzip
```
### Script Funktionen
```bash
*-----------------------------------*

FilewaveAIO installer for Linux


*-----------------------------------*
1 - Installation Filewave Server
2 - Installation Filewave Booster
3 - Setup Filewave Backup Script
4 - Filewave Update
5 - Filewave Migration to New Server Alpha
6 - Setup Let’s encrypt for Filewave
0 - exit program
Enter selection:
```
### Install Script

```bash
git clone https://github.com/nycon/filewave-installer.git
cd filewave-installer.sh
chmod +x 
./filewaveAIO.sh
```
