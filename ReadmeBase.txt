■ これは何?

■ オプション

-VertionCheck

最新版のスクリプトがあるか確認します
最新版があれば、自動ダウンロード & 更新します


■ スクリプトインストール方法
--- 以下を PowerShell プロンプトにコピペ ---

$ModuleName = "GetSharePointbreadcrumb"
$GitHubName = "MuraAtVwnet"
$URI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/refs/heads/main/OnlineInstall.ps1"
$OutFile = "~/OnlineInstall.ps1"
Invoke-WebRequest -Uri $URI -OutFile $OutFile
& $OutFile


■ スクリプトアンインストール方法
--- 以下を PowerShell プロンプトにコピペ ---

~/UninstallGetSharePointbreadcrumb.ps1


■ Windows PowerShell を使っている方へ
Windows PowerShell では、スクリプト実行が禁止になっていて、インストールとかうまく動かない場合は以下コマンドを PowerShell  のプロンプトにコピペしてください

if((Get-ExecutionPolicy) -ne 'RemoteSigned'){Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force}


■ GitHub
以下リポジトリで公開しています
https://github.com/MuraAtVwnet/GetSharePointbreadcrumb
git@github.com:MuraAtVwnet/GetSharePointbreadcrumb.git


■ リポジトリ内モジュール説明

AddCode.ps1
	オンラインインストール用組み込みコード
Install.ps1
	インストーラー
GetSharePointbreadcrumb.psm1
	モジュール本体
OnlineInstall.ps1
	オンラインインストーラー
Uninstall.ps1
	アンインストーラー
Vertion.txt
	バージョンチェックファイル
Readme.txt
	このファイル

