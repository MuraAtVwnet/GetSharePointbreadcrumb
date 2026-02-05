■ これは何?
SharePoint のパンくずを取ってくるスクリプトです

■ 実行方法
スクリプトをインストールしたら、パンくずを取ってきたい SharePoint を URL をクリップボードにコピーして、以下コマンドを PowerShell プロンプトで実行


GetSharePointbreadcrumb

(getsh[TAB] でコマンド補完されます)

■ 動作確認環境

Windows PowerShell 5.1
PowerShell 7.4.2 (Windows)
たぶん Mac Linux でも動くはず


■ 使い方
URL をクリップボートにコピー(Windows Edge Chrome なら Ctrl+L → Ctrl+C)して、PowerShell プロンプトで GetSharePointbreadcrumb と入力すると、クリップボードにパンくずと URL がセットされます
あとは必要なところにペーストしてください

gets[TAB] で GetSharePointbreadcrumb に補完されます

■ オプション

GetSharePointbreadcrumb の後に、ハイフンを入力して TAB を叩くと、オプションが補完されるのて、必要オプションを選択してください

GetSharePointbreadcrumb -[TAB]

-FileName
ドキュメントのファイル名抽出

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

$Policy = Get-ExecutionPolicy
if($Policy -notin @('RemoteSigned','Unrestricted','Bypass')){Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force}
$ModuleName = "GetSharePointbreadcrumb"
$GitHubName = "MuraAtVwnet"
$URI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/refs/heads/main/OnlineInstall.ps1"
$OutFile = "~/OnlineInstall.ps1"
Invoke-WebRequest -Uri $URI -OutFile $OutFile
& $OutFile

