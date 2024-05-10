﻿■ これは何?
SharePoint のパンくずを取ってくるスクリプトです

■ 実行方法
スクリプトをインストールしたら、パンくずを取ってきたい SharePoint を URL をクリップボードにコピーして、以下コマンドを PowerShell プロンプトで実行


GetSharePointbreadcrumb

(getsh[TAB] でコマンド補完されます)

■ 動作確認環境

Windows PowerShell 5.1
PowerShell 7.4.2 (Windows)
たぶん Mac Linux でも動くはず

Windows Powershell の場合、スクリプトの実行許可が必要なので、以下コマンドで許可状態を確認して下さい

Get-ExecutionPolicy

結果が、「RemoteSigned」になっていないかったら、以下コマンドを入力(1回のみ)

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force


■ オプション

GetSharePointbreadcrumb の後に、ハイフンを入力して TAB を叩くと、オプションが補完されるのて、必要オプションを選択してください

GetSharePointbreadcrumb -[TAB]

-Debug

NG となって、うまくパンくずが取れない時は、Debug オプションを使うと、デコード済みの URL を表示します
内容をフィードバックしてもらえれば確認します


-VertionCheck

最新版のスクリプトがあるか確認します
最新版があれば、自動ダウンロード & 更新します


■ GitHub
以下リポジトリで公開しています
https://github.com/MuraAtVwnet/GetSharePointbreadcrumb
git@github.com:MuraAtVwnet/GetSharePointbreadcrumb.git


■ スクリプトインストール方法

--- 以下を PowerShell プロンプトにコピペ ---


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

