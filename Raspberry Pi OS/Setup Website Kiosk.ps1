param(
    [Parameter(Mandatory, Position = 0, HelpMessage = "Hostname")]
    [string] $hostname,
    [Parameter(Mandatory, Position = 1, HelpMessage = "Username")]
    [string] $username,
    [Parameter(Mandatory, Position = 2, HelpMessage = "Password")]
    [string] $password,
    [Parameter(Mandatory, Position = 3, HelpMessage = "Url")]
    [string] $url,    
    [switch] $reboot
)

$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$plink = & ".\EnsurePlink.ps1"

if (!$plink) {
    return
}

function ExecSSH {
    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $commands
    )
    & $plink "$($username)@$($hostname)" -pw $password -batch $commands

    if (!$?) {        
        throw "Last command failed"
    }
}

try {

    $os = ExecSSH "uname -srv"

    Write-Host "Remote machine is: " -NoNewline -ForegroundColor DarkGray
    Write-Host $os -ForegroundColor Green
    
    Write-Host "Update $($os) to latest version..." -ForegroundColor DarkGray

    $null = ExecSSH "sudo apt-get update"

    Write-Host "Installing Chromium..." -ForegroundColor DarkGray

    $null = ExecSSH "sudo apt-get install chromium --yes"

    Write-Host "Installing Window Manager..." -ForegroundColor DarkGray

    $null = ExecSSH "sudo apt-get install matchbox-window-manager xautomation unclutter --yes"

    Write-Host "Create Autorun script..." -ForegroundColor DarkGray

    $kiosk = ExecSSH "test -f ~/kiosk && echo 'EXISTS' || echo ''"

    if ($kiosk -match "EXISTS") {
        Write-Host "Autorun script exists already, make a new one..." -ForegroundColor DarkGray
        $null = ExecSSH "sudo rm -rf ~/kiosk"
    }

    $null = ExecSSH "echo ""#!/bin/sh"" >> ~/kiosk"
    $null = ExecSSH "echo ""if ! xset q &> /dev/null; then"" >> ~/kiosk"
    $null = ExecSSH "echo ""exit 1"" >> ~/kiosk"
    $null = ExecSSH "echo ""fi"" >> ~/kiosk"
    $null = ExecSSH "echo ""xset -dpms     # disable DPMS (Energy Star) features."" >> ~/kiosk"
    $null = ExecSSH "echo ""xset s off     # disable screen saver"" >> ~/kiosk"
    $null = ExecSSH "echo ""xset s noblank # don't blank the video device"" >> ~/kiosk"
    $null = ExecSSH "echo ""matchbox-window-manager -use_titlebar no &"" >> ~/kiosk"
    $null = ExecSSH "echo ""unclutter &    # hide X mouse cursor unless mouse activated"" >> ~/kiosk"
    $null = ExecSSH "echo ""chromium --display=:0 --kiosk --incognito --window-position=0,0 $($url)"" >> ~/kiosk"
    $null = ExecSSH "sudo chmod 755 ~/kiosk"

    Write-Host "Prepare kiosk script for auto start..." -ForegroundColor DarkGray

    $bashrc = ExecSSH "cat ~/.bashrc"

    $cmd = "./kiosk &"

    if ($bashrc -notcontains $cmd) {
        $null = ExecSSH "echo """" >> ~/.bashrc"
        $null = ExecSSH "echo ""$($cmd)"" >> ~/.bashrc"
    }
    
    if ($reboot) {
        Write-Host "Rebooting remote device..." -ForegroundColor DarkGray
        $null = ExecSSH "sudo shutdown -r 0"
    }
    else {
        Write-Host "Kiosk has been setup. You can now reboot the system." -ForegroundColor Green
    }
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}