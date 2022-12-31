$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

try {

    $plink = Get-Command "PLINK.EXE" -ErrorAction Ignore

    if (!$plink) {
        throw "PLINK.EXE (From Putty) is required to run all SSH operations. Please install Putty package!"
    }

    Write-Host "Using '$($plink.Path)' for SSH tasks"

    $plink
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}