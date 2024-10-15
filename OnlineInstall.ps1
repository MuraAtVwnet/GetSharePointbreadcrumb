# Online installer

$ModuleName = "GetSharePointbreadcrumb"
$GitHubName = "MuraAtVwnet"

$Module = $ModuleName + ".psm1"
$Installer = "Install" + $ModuleName + ".ps1"
$UnInstaller = "UnInstall" + $ModuleName + ".ps1"
$Vertion = "Vertion" + $ModuleName + ".txt"
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/$Module -OutFile ~/$Module
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/install.ps1 -OutFile ~/$Installer
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/uninstall.ps1 -OutFile ~/$UnInstaller
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/Vertion.txt -OutFile ~/$Vertion
& ~/$Installer
Remove-Item ~/$Module
Remove-Item ~/$Installer

Remove-Item ~/OnlineInstall.ps1

