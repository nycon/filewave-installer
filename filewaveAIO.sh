#!/bin/bash
#============================================================================
#title          :filewaveAIO.sh
#description    :Install and Update Script for Filewave.
#author         :Marco Stoeckle dq-solutions
#date           :2020-02-04
#version        :0.1
#usage          :./filewaveAIO.sh
#notes          :
#bash_version   :
#============================================================================
#============================================================================
### Revision History:
##
##	Date	      Version			Personnel			Notes
##	----	      -------			----------------	-----
##	2020-02-04	  0.1			    Marco Stoeckle   	Script created
##      2020-10-13	  0.2			    Marco Stoeckle	Script Add Migration
##	
#============================================================================
#
GREEN='\033[0;32m'
NC='\033[0m'
fwversion='fwcontrol server version'

function download {
	# not deposited for licensing reasons
  wget "https://xxx.xxxxxxxx/${version}/FileWave_Linux_${version}.zip"
}


function install1 {
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}Installl Filewave Server${NC}"
	echo -e "${GREEN}Selcet the version${NC}"
	echo -e "${GREEN}Check filwave.com for the latest version${NC} "
	echo -e ""
	echo -e ""
	echo -e "${GREEN}#-----------------------------------#${NC}"

	read -p 'Filewave Server Version: ' version
    echo -e "${GREEN}install packages${NC}"
    yum -y update
    yum -y install wget unzip 
    echo -e "${GREEN}Download Filewave Server${NC}"
	"download"
	unzip FileWave_Linux_${version}.zip
	sleep 2
	echo -e "${GREEN}install Filewave Server${NC}"
	yum install -y --nogpgcheck fwxserver-${version}-1.0.x86_64.rpm
	echo -e "${GREEN}Filewave Server is successfully installed${NC}"
	echo -e ""
	echo -e "${GREEN}Delete Filewave install Package${NC}"
	sleep 2
	rm -rf fwxserver-${version}-1.0.x86_64.rpm
	rm -rf fwbooster-${version}-1.0.x86_64.rpm
	rm -rf FileWave_Linux_${version}.zip
	echo -e ""
	exit 0
}

function install2 {
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}Installl Filewave Booster${NC}"
	echo -e "${GREEN}Selcet the version${NC}"
	echo -e "${GREEN}Check filwave.com for the latest version${NC} "
	echo -e ""
	echo -e ""
	echo -e "${GREEN}#-----------------------------------#${NC}"
    
	read -p 'Filewave Booster Version: ' version
    echo -e "${GREEN}install packages${NC}"
    yum -y update
    yum -y install wget unzip 
    echo -e "${GREEN}Download Filewave Booster${NC}"
	"download"
	unzip FileWave_Linux_${version}.zip
	sleep 2
	echo -e "${GREEN}install Filewave Server${NC}"
	yum install -y --nogpgcheck fwbooster-${version}-1.0.x86_64.rpm
	echo -e "${GREEN}Filewave Server is successfully installed${NC}"
	echo -e ""
	echo -e "${GREEN}Delete Filewave install Package${NC}"
	sleep 2
	rm -rf fwbooster-${version}-1.0.x86_64.rpm
	rm -rf fwxserver-${version}-1.0.x86_64.rpm
	rm -rf FileWave_Linux_${version}.zip
	echo -e ""
	exit 0
}

function install3 {
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}Installl Filewave Backup Script${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}#-----------------------------------#${NC}"
    echo -e "${GREEN}Download Filewave Server Update${NC}"
	sleep 2
	wget https://kb.filewave.com/download/attachments/920198/backup_server_osx_linux.sh.zip
	unzip backup_server_osx_linux.sh.zip
	sleep 2
	echo -e "${GREEN}Move Script to Root Directory${NC}"
	sleep 2
	chmod a+x backup_server_osx_linux.sh
	echo -e "${GREEN}Setup Backup follow the instructions${NC}"
	./backup_server_osx_linux.sh
	echo -e ""
	echo -e ""
	echo -e ""
	exit 0
}

function install4 {
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}Installl Filewave Update${NC}"
	echo -e "${GREEN}Selcet the version${NC}"
	echo -e "${GREEN}Check filewave.com for the latest version${NC} "
	echo "Your Filwave Server version is:"
	$fwversion
	echo -e "${GREEN}#-----------------------------------#${NC}"
	read -p 'Filewave Server Version: ' version
    echo -e "${GREEN}install packages${NC}"
    yum -y update
    yum -y install wget unzip 
    echo -e "${GREEN}Download Filewave Server Update${NC}"
	"download"
	unzip FileWave_Linux_${version}.zip
	sleep 2
	echo -e "${GREEN}install Filewave Server${NC}"
	yum install -y --nogpgcheck fwbooster-${version}-1.0.x86_64.rpm
	echo -e "${GREEN}Filewave Server is successfully installed${NC}"
	echo -e ""
	echo -e "${GREEN}Delete Filewave install Package${NC}"
	sleep 2
	rm -rf fwbooster-${version}-1.0.x86_64.rpm
	rm -rf fwxserver-${version}-1.0.x86_64.rpm
	rm -rf FileWave_Linux_${version}.zip
	echo -e ""
	exit 0
}

function install5 {
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}Filewave Migration${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e "${GREEN}Download Filewave Backup Script${NC}"
	sleep 2
	wget https://kb.filewave.com/download/attachments/920198/backup_server_osx_linux.sh.zip
	unzip backup_server_osx_linux.sh.zip
	sleep 2
	echo -e "${GREEN}Move Script to Root Directory${NC}"
	sleep 2
	chmod a+x backup_server_osx_linux.sh
	echo -e "${GREEN}Enter the Backup Directory${NC}"
	read -p "Backup Folder:" backup_folder
	echo -e "${GREEN}Make Backup${NC}"
	./backup_server_osx_linux.sh run $backup_folder manual
	echo -e ""
	echo -e ""
	echo -e "Copy config Data to Backup"
	cp /usr/local/filewave/django/filewave/settings_custom.py fw-backups/
	cp /usr/local/filewave/fwcld/FileWaveClient.pkg fw-backups/
	cp /etc/xdg/filewave/fwxserver.conf fw-backups/
	echo -e "${GREEN}Create Backup zip${NC}"
	zip -r fw-backups.zip fw-backups
	echo -e "Backup Done"
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e "Move Backup to new Server"
    read -p "Ip from the new Server:" IP
    read -p "User from the new Server:" user
    scp -r  fw-backups.zip "$user"@"$IP":
    exit 0
}

clear
# Selection menu
selection=
until [ "$selection" = "0" ]; do
	 echo -e -e "${GREEN}*-----------------------------------*${NC}"
	 echo -e ""
	 echo -e "${GREEN}FilewaveAIO installer for Linux${NC}"
	 echo -e ""
	 echo -e ""
	 echo -e "${GREEN}*-----------------------------------*${NC}"
	 echo -e "${GREEN}1 - Installation Filewave Server${NC}"
	 echo -e "${GREEN}2 - Installation Filewave Booster${NC}"
	 echo -e "${GREEN}3 - Setup Filewave Backup Script${NC}"
	 echo -e "${GREEN}4 - Filewave Update${NC}"
	 echo -e "${GREEN}5 - Filewave Migration to New Server${NC}"
	 echo -e "${GREEN}0 - exit program${NC}"
	 echo -e "${GREEN}Enter selection:${NC} "
	read selection
	echo -e ""
	case $selection in
		1 )  install1 ;;
		2 )  install2 ;;
		3 )  install3 ;;
		4 )  install4 ;;
		5 )  install5 ;;
		0 ) exit & echo -e "${GREEN}the computer says no :-)${NC}";;
		* ) echo -e "${GREEN}Please enter 1, 2, 3, 4, 5 or 0${NC}"
	esac
done
