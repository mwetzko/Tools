param(
    [Parameter(Mandatory, Position = 0)]
    [string] $user,
    [Parameter(Mandatory, Position = 1)]
    [string] $repo,
    [Parameter(Position = 2)]
    [string] $path = "",
    [Parameter(Position = 3)]
    [string] $outdir = "."
)

$ErrorActionPreference = "Stop"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$data = (Invoke-WebRequest "https://api.github.com/repos/$($user)/$($repo)/git/trees/master?recursive=1").Content | ConvertFrom-Json -Depth 999

if (!($data.sha)) {
    throw "Given user and repo combination is not valid!"    
}

if (!($data.tree) -or ($data.tree.length -eq 0)) {
    throw "Repo is empty"    
}

$path = $path.TrimStart("/")

if ($path -eq "") {
    $filter = $data.tree
}
else {
    $match = "^$($path.TrimEnd("/"))/"
    $filter = $data.tree | Where-Object { ($_.path -eq $path) -or ($_.path -match $match) }
}

$outdir = (Get-Item -Path $outdir).FullName

$filter | ForEach-Object {
    if ($_.type -ne "tree") {
        $filename = Join-Path $outdir $_.path

        $filename

        $dir = Split-Path -Path $filename
        
        if (!(Test-Path $dir)) {
            $null = New-Item $dir -ItemType "directory"
        }

        Invoke-WebRequest $_.url -OutFile $filename
    }
}