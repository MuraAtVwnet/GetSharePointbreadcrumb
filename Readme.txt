■ これは何?
SharePoint のパンくずを取ってくるスクリプトです

■ 実行方法
スクリプトをインストールしたら、パンくずを取ってきたい SharePoint を URL をクリップボードにコピーして、以下コマンドを PowerShell プロンプトで実行


GetSharePointbreadcrumb

(getsh[TAB] でコマンド補完される)

■ 動作確認環境

Windows PowerShell 5.1
PowerShell 7.4.2 (Windows)
たぶん Mac Linux でも動くはず

■ スクリプトインストール方法

--- 以下を PowerShell プロンプトにコピペ ---


$ScriptName = "GetSharePointbreadcrumb"
$GitHubName = "MuraAtVwnet"
$Module = $ScriptName + ".psm1"
$Installer = "Install" + $ScriptName + ".ps1"
$UnInstaller = "UnInstall" + $ScriptName + ".ps1"
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/$Module -OutFile ~/$Module
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/install.ps1 -OutFile ~/$Installer
Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/uninstall.ps1 -OutFile ~/$UnInstaller
& ~/$Installer
Remove-Item ~/$Module
Remove-Item ~/$Installer

