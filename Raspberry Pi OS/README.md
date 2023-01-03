# Kiosk Scripts (Windows)

Powershell scripts to convert Raspberry Pi (and other devices running Raspberry Pi OS) into Kiosk / Single App / Infotainment devices.
- Clone all these files to your Windows device (make sure to keep [CR]LF as they are in these files!)
- Make sure you have Powershell 5 or PWSH
- Make sure you have Putty.exe, Plink.exe and Pscp.exe installed
- Make sure your remote device is running the latest Raspberry Pi OS (with UI)
- Make sure your remote device has SSH enabled
- Prepare a user that has SSH rights and admin rights on your remove device (Default user: pi, default pw: raspberry)

<br/>

## 🗎 Setup Website Kiosk.ps1

This script displays a generic website, e.g. `https://github.com` as a fullscreen / single app / kiosk app using chromium.

### Arguments

`& '.\Setup Website Kiosk.ps1' <ip-address/hostname> <username> <password> <url> [-reboot]`

+ `<ip-address/hostname>` Mandatory. The ip address or hostname of the remote device, e.g. `192.168.10.12`
+ `<username>` Mandatory. The username to login to SSH into the remote device, e.g. `pi`
+ `<password>` Mandatory. The password to login to SSH into the remote device, e.g. `raspberry`
+ `<url>` Mandatory. The website url to display when the remote device is running, e.g. `https://github.com`
+ `[-reboot]` Optional. Reboots the remote device if kiosk installation has finished

### Sample

`& '.\Setup Website Kiosk.ps1' 192.168.1.2 pi raspberry https://github.com -reboot`

### Testing

This script has been testet with
- Raspberry Pi OS Desktop (Bullseye i386) on a virtual machine
- Raspberry Pi OS Stretch (bpi m2, Kernel 4.4) on a banana pi m2 zero (Arm H3)

<br/>

## 🗎 Setup Dotnet Console Kiosk.ps1

This script displays a dotnet/mono compatible console app as a fullscreen / single app / kiosk app.

> 📝 This script does not work on x86 releases of Raspberry Pi OS as dotnet install script, which is used for installing dotnet, does not support x86 CPU's (yet).

### Arguments

`& '.\Setup Dotnet Console Kiosk.ps1' <ip-address/hostname> <username> <password> <publish-path> <name-of-dll> [-reboot]`

+ `<ip-address/hostname>` Mandatory. The ip address or hostname of the remote device, e.g. `192.168.10.12`
+ `<username>` Mandatory. The username to login to SSH into the remote device, e.g. `pi`
+ `<password>` Mandatory. The password to login to SSH into the remote device, e.g. `raspberry`
+ `<publish-path>` Mandatory. The path of the published files on the local disk
+ `<name-of-dll>` Mandatory. The name of the dll to load
+ `[-reboot]` Optional. Reboots the remote device if kiosk installation has finished

### Sample

`& '.\Setup Dotnet Console Kiosk.ps1' 192.168.1.2 pi raspberry C:\Dotnet\ConsoleApp1\bin\Release\net6.0\publish ConsoleApp1.dll -reboot`

### Testing

This script has been testet with
- Raspberry Pi OS Stretch (bpi m2, Kernel 4.4) on a banana pi m2 zero (Arm H3)

<br/>

## 🗎 Setup Dotnet Blazor Kiosk.ps1

This script displays a dotnet blazor server app as a fullscreen / single app / kiosk app.

> 📝 This script does not work on x86 releases of Raspberry Pi OS as dotnet install script, which is used for installing dotnet, does not support x86 CPU's (yet).

### Arguments

`& '.\Setup Dotnet Blazor Kiosk.ps1' <ip-address/hostname> <username> <password> <publish-path> <name-of-dll> [url] [-reboot]`

+ `<ip-address/hostname>` Mandatory. The ip address or hostname of the remote device, e.g. `192.168.10.12`
+ `<username>` Mandatory. The username to login to SSH into the remote device, e.g. `pi`
+ `<password>` Mandatory. The password to login to SSH into the remote device, e.g. `raspberry`
+ `<publish-path>` Mandatory. The path of the published files on the local disk. Make sure wwwroot is inside of this folder.
+ `<name-of-dll>` Mandatory. The name of the dll to load
+ `[url]` Optional. If you changed the default hosting url from http://localhost:5000 to any other of you choice, provide the new url here.
+ `[-reboot]` Optional. Reboots the remote device if kiosk installation has finished

### Sample

`& '.\Setup Dotnet Blazor Kiosk.ps1' 192.168.1.2 pi raspberry C:\Dotnet\BlazorServerApp1\bin\Release\net6.0\publish BlazorServerApp1.dll -reboot`

### Testing

This script has been testet with
- Raspberry Pi OS Stretch (bpi m2, Kernel 4.4) on a banana pi m2 zero (Arm H3)
