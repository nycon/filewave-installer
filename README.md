
# FileWave All-in-One Installer Script (Debian 12)

Dieses Repository enthält ein **All-in-One Script** für die Installation, Updates, Backup und Migration von FileWave Server und Booster auf **Debian 12** Systemen.

---

## 📥 Download

Du kannst das Script direkt mit **git clone** herunterladen:

```bash
git clone https://github.com/nycon/filewave-installer.git
```

Oder alternativ mit **wget** (falls du nur das Script ohne git laden möchtest):

```bash
wget https://raw.githubusercontent.com/nycon/filewave-installer/main/filewaveAIO.sh
chmod +x filewaveAIO.sh
./filewaveAIO.sh
```

---

## ⚙️ Funktionen des Scripts

Nach dem Start stehen folgende Optionen zur Verfügung:

```text
*-----------------------------------*

FilewaveAIO installer for Debian 12

*-----------------------------------*
1 - Install Filewave Server
2 - Install Filewave Booster
3 - Setup Filewave Backup Script
4 - Filewave Update
5 - Filewave Migration to New Server
6 - Setup Let’s Encrypt for Filewave
0 - Exit program
```

---

## ✅ Voraussetzungen

- **FileWave Account**  
  Du benötigst einen gültigen FileWave Account für den Download der Installationspakete.  
  ➔ **Trage deinen persönlichen Download-Link** direkt in die `download` Funktion des Scripts ein, bevor du es verwendest.

- **Pakete installieren**

```bash
apt update
apt install -y git nano wget unzip
```

---

## 🚀 Installation und Start

```bash
cd filewave-installer
chmod +x filewaveAIO.sh
./filewaveAIO.sh
```

---

## ⚠️ Hinweise

- **Download URL anpassen:**  
  Passe den Download-Link in der Funktion `download` an deine gültigen FileWave URLs an.

- **Testumgebung:**  
  Führe das Script zunächst in einer Testumgebung aus, bevor du es produktiv einsetzt.

- **Root Rechte:**  
  Führe das Script als root oder mit `sudo` aus.

---

© 2025 nycon | FileWave Debian Automation

---
