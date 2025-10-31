# Online installer

$ModuleName = "GetSharePointbreadcrumb"
$GitHubName = "MuraAtVwnet"

$Module = $ModuleName + ".psm1"
$Installer = "Install" + $ModuleName + ".ps1"
$UnInstaller = "UnInstall" + $ModuleName + ".ps1"
$Vertion = "Vertion" + $ModuleName + ".txt"
$ModuleURI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/$Module"
Invoke-WebRequest -Uri $ModuleURI -OutFile "~/$Module"
$InstallerURI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/install.ps1"
Invoke-WebRequest -Uri $InstallerURI -OutFile "~/$Installer"
$UnInstallerURI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/uninstall.ps1"
Invoke-WebRequest -Uri $UnInstallerURI -OutFile "~/$UnInstaller"
$VertionURI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/Vertion.txt"
Invoke-WebRequest -Uri $VertionURI -OutFile "~/$Vertion"
& "~/$Installer"
Remove-Item "~/$Module"
Remove-Item "~/$Installer"

Remove-Item "~/OnlineInstall.ps1"

