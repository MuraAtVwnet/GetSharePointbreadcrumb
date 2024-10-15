# Online installer

$ScriptName = "GetSharePointbreadcrumb"
$GitHubName = "MuraAtVwnet"

$Module = $ScriptName + ".psm1"
$Installer = "Install" + $ScriptName + ".ps1"
$UnInstaller = "UnInstall" + $ScriptName + ".ps1"
$Vertion = "Vertion" + $ScriptName + ".txt"
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/$Module -OutFile ~/$Module
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/install.ps1 -OutFile ~/$Installer
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/uninstall.ps1 -OutFile ~/$UnInstaller
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/Vertion.txt -OutFile ~/$Vertion
& ~/$Installer
Remove-Item ~/$Module
Remove-Item ~/$Installer

Remove-Item ~/OnlineInstall.ps1

