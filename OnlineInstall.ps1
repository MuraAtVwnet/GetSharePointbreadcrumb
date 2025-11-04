# Online installer

$ModuleName = "GetSharePointbreadcrumb"
$GitHubName = "MuraAtVwnet"

$Module = $ModuleName + ".psm1"
$Installer = "Install" + $ModuleName + ".ps1"
$UnInstaller = "UnInstall" + $ModuleName + ".ps1"
$Vertion = "Vertion" + $ModuleName + ".txt"
$GithubCommonURI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/"

##### マジックナンバー消す

$URI = $GithubCommonURI + "$Module"
$ModuleFile = "~/$Module"
Invoke-WebRequest -Uri $URI -OutFile $ModuleFile

$URI = $GithubCommonURI + "install.ps1"
$InstallerFile = "~/$Installer"
Invoke-WebRequest -Uri $URI -OutFile $InstallerFile

$URI = $GithubCommonURI + "uninstall.ps1"
$OutFile = "~/$UnInstaller"
Invoke-WebRequest -Uri $URI -OutFile $OutFile

$URI = $GithubCommonURI + "Vertion.txt"
$OutFile = "~/$Vertion"
Invoke-WebRequest -Uri $URI -OutFile $OutFile

& $InstallerFile

Remove-Item $ModuleFile
Remove-Item $InstallerFile

Remove-Item "~/OnlineInstall.ps1"

