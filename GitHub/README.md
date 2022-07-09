# GitHub Tools

## GitHubExport.ps1

A Powershell Script to export a given github repository or subfolders/files of it

### Arguments

`& .\GitHubExport.ps1 <user> <repo> [subfolder/file] [outdir]`

+ `<user>` Mandatory. The user of github, e.g. 'mwetzko'
+ `<repo>` Mandatory. The repository of the github user, e.g. 'Tools'
+ `[subfolder/file]` Optional. The subfolder or file to export.
+ `[outdir]` Optional. The path, where to download files to. If you provide a relative path, it's based on the directory, where the script resides!

### Sample

To download GitHub folder and its contents

`& .\GitHubExport.ps1 mwetzko Tools GitHub C:\Export`

To download GitHubExport.ps1

`& .\GitHubExport.ps1 mwetzko Tools GitHub/GitHubExport.ps1 C:\Export`

> Note: The forward slash in the [subfolder/file] parameter is important!
