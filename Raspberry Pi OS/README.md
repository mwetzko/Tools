# Kiosk Scripts (Windows)

Powershell scripts to convert Raspberry Pi (and other devices running Raspberry Pi OS) into Kiosk / Single App / Infotainment devices.
- Clone all these files to your Windows device (make sure to keep [CR]LF as they are in these files!)
- Make sure you have Powershell 5 or PWSH
- Make sure you have Putty.exe, Plink.exe and Pscp.exe installed
- Make sure your remote device is running the latest Raspberry Pi OS (with UI)
- Make sure your remote device has SSH enabled
- Prepare a user that has SSH rights and admin rights on your remove device (Default user: pi, default pw: raspberry)

## 🗎 Setup Website Kiosk.ps1

This script displays a generic website, e.g. `https://github.com` as a fullscreen / single app / kiosk app using chromium.

### Arguments

`& '.\Setup Website Kiosk.ps1' <ip address/hostname> <username> <password> <url> [-reboot]`

+ `<ip address/hostname>` Mandatory. The ip address or hostname of the remote device, e.g. `192.168.10.12`
+ `<username>` Mandatory. The username to login to SSH into the remote device, e.g. `pi`
+ `<password>` Mandatory. The password to login to SSH into the remote device, e.g. `raspberry`
+ `<url>` Mandatory. The website url to display when the remote device is running, e.g. `https://github.com`
+ `[-reboot]` Optional. Reboots the remote device if kiosk installation has finished.

### Sample

`& '.\Setup Website Kiosk.ps1' 192.168.1.2 pi raspberry https://github.com -reboot`
