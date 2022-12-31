$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

try {

    $pscp = Get-Command "PSCP.EXE" -ErrorAction Ignore

    if (!$pscp) {
        throw "PSCP.EXE (From Putty) is required to run all SSH operations. Please install Putty package!"
    }

    Write-Host "Using '$($pscp.Path)' for SSH copy file tasks"

    $pscp
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}