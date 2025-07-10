#!/bin/bash
#=========================================================================================
#title          :filewaveAIO.sh
#description    :Install and Update Script for Filewave on Debian 12
#author         :Marco Stoeckle
#date           :2025-07-10
#version        :0.4-debian12
#usage          :./filewaveAIO.sh
#==========================================================================================
GREEN='\033[0;32m'
NC='\033[0m'
fwversion='fwcontrol server version'

function download {
	wget "https://xx.xxxxxxx/${version}/FileWave_Linux_${version}.zip"
}

function install1 {
	clear
	echo -e "${GREEN}Install Filewave Server${NC}"
	read -p 'Filewave Server Version: ' version
    echo -e "${GREEN}Installing packages${NC}"
    apt update && apt install -y wget unzip
    echo -e "${GREEN}Download Filewave Server${NC}"
	download
	unzip FileWave_Linux_${version}.zip
	sleep 2
	echo -e "${GREEN}Install Filewave Server${NC}"
	apt install -y ./fwxserver-${version}-1.0.amd64.deb
	echo -e "${GREEN}Filewave Server installed${NC}"
	rm -rf fwxserver-${version}-1.0.amd64.deb fwbooster-${version}-1.0.amd64.deb FileWave_Linux_${version}.zip
	exit 0
}

function install2 {
	clear
	echo -e "${GREEN}Install Filewave Booster${NC}"
	read -p 'Filewave Booster Version: ' version
    echo -e "${GREEN}Installing packages${NC}"
    apt update && apt install -y wget unzip
    echo -e "${GREEN}Download Filewave Booster${NC}"
	download
	unzip FileWave_Linux_${version}.zip
	sleep 2
	echo -e "${GREEN}Install Filewave Booster${NC}"
	apt install -y ./fwbooster-${version}-1.0.amd64.deb
	echo -e "${GREEN}Filewave Booster installed${NC}"
	rm -rf fwbooster-${version}-1.0.amd64.deb fwxserver-${version}-1.0.amd64.deb FileWave_Linux_${version}.zip
	exit 0
}

function install3 {
	clear
	echo -e "${GREEN}Install Filewave Backup Script${NC}"
	wget https://kb.filewave.com/download/attachments/920198/backup_server_osx_linux.sh.zip
	unzip backup_server_osx_linux.sh.zip
	chmod +x backup_server_osx_linux.sh
	./backup_server_osx_linux.sh
	exit 0
}

function install4 {
	clear
	echo -e "${GREEN}Filewave Update${NC}"
	echo "Your Filewave Server version is:"
	$fwversion
	read -p 'Filewave Server Version: ' version
    echo -e "${GREEN}Installing packages${NC}"
    apt update && apt install -y wget unzip
    echo -e "${GREEN}Download Filewave Server Update${NC}"
	download
	unzip FileWave_Linux_${version}.zip
	sleep 2
	echo -e "${GREEN}Install Filewave Update${NC}"
	apt install -y ./fwbooster-${version}-1.0.amd64.deb
	rm -rf fwbooster-${version}-1.0.amd64.deb fwxserver-${version}-1.0.amd64.deb FileWave_Linux_${version}.zip
	exit 0
}

function install5 {
	clear
	echo -e "${GREEN}Filewave Migration${NC}"
	wget https://kb.filewave.com/download/attachments/920198/backup_server_osx_linux.sh.zip
	unzip backup_server_osx_linux.sh.zip
	chmod +x backup_server_osx_linux.sh
	read -p "Backup Folder: " backup_folder
	./backup_server_osx_linux.sh run $backup_folder manual
	cp /usr/local/filewave/django/filewave/settings_custom.py fw-backups/
	cp /usr/local/filewave/fwcld/FileWaveClient.pkg fw-backups/
	cp /etc/xdg/filewave/fwxserver.conf fw-backups/
	zip -r fw-backups.zip fw-backups
	read -p "IP of the new Server: " IP
	read -p "User of the new Server: " user
	scp -r fw-backups.zip "$user@$IP:"
	exit 0
}

function install6 {
	clear
	echo -e "${GREEN}Setup Let’s Encrypt for Filewave${NC}"
	apt update && apt install -y certbot
	read -p 'Filewave Server Domain: ' domain
	read -p 'Email Address: ' email
	certbot certonly --standalone -d ${domain} --staple-ocsp -m ${email} --agree-tos
	cp /usr/local/filewave/certs/server.key /usr/local/filewave/certs/server.key_bak
	cp /usr/local/filewave/certs/server.crt /usr/local/filewave/certs/server.crt_bak
	cp -uf /etc/letsencrypt/live/${domain}/fullchain.pem /usr/local/filewave/certs/server.crt
    cp -uf /etc/letsencrypt/live/${domain}/privkey.pem /usr/local/filewave/certs/server.key
    fwcontrol server restart
cat <<EOF >/usr/local/bin/fw_renew.sh
#!/bin/bash
certbot renew
cp -uf /etc/letsencrypt/live/${domain}/fullchain.pem /usr/local/filewave/certs/server.crt
cp -uf /etc/letsencrypt/live/${domain}/privkey.pem /usr/local/filewave/certs/server.key
fwcontrol server restart
EOF
    chmod +x /usr/local/bin/fw_renew.sh
    echo "0 5 */10 * * root /usr/local/bin/fw_renew.sh" > /etc/cron.d/fw_renew
	exit 0
}

clear
selection=
until [ "$selection" = "0" ]; do
	echo -e "${GREEN}FilewaveAIO installer for Debian 12${NC}"
	echo -e "1 - Install Filewave Server"
	echo -e "2 - Install Filewave Booster"
	echo -e "3 - Setup Filewave Backup Script"
	echo -e "4 - Filewave Update"
	echo -e "5 - Filewave Migration to New Server"
	echo -e "6 - Setup Let’s Encrypt for Filewave"
	echo -e "0 - Exit program"
	read -p "Enter selection: " selection
	case $selection in
		1 )  install1 ;;
		2 )  install2 ;;
		3 )  install3 ;;
		4 )  install4 ;;
		5 )  install5 ;;
		6 )  install6 ;;
		0 ) echo -e "${GREEN}Exit${NC}"; exit 0 ;;
		* ) echo -e "${GREEN}Please enter a valid option (1-6 or 0)${NC}" ;;
	esac
done
