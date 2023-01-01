# Kiosk Scripts (Windows)

Powershell scripts to convert Raspberry Pi (and other devices running Raspberry Pi OS) into Kiosk / Single App / Infotainment devices.
- Clone all these files to your Windows device
- Make sure you have Powershell 5 or PWSH
- Make sure you have Putty.exe, Plink.exe and Pscp.exe installed
- Make sure your remote device is running the latest Raspberry Pi OS (with UI)
- Make sure your remote device has SSH enabled
- Prepare a user that has SSH rights and admin rights on your remove device (Default user: pi, default pw: raspberry)

## 🗎 Setup Website Kiosk.ps1

This script displays a generic website, e.g. `https://github.com` as a fullscreen / single app / kiosk app using chromium.
