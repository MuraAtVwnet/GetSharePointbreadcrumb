function VertionCheck(){
	$ModuleName = "GetSharePointbreadcrumb"
	$GitHubName = "MuraAtVwnet"
	$Module = $ModuleName + ".psm1"
	$Installer = "Install" + $ModuleName + ".ps1"
	$UnInstaller = "UnInstall" + $ModuleName + ".ps1"
	$Vertion = "Vertion" + $ModuleName + ".txt"
	$VertionTemp = "VertionTemp" + $ModuleName + ".tmp"

	$Update = $False

	if( -not (Test-Path ~/$Vertion)){
		$Update = $True
	}
	else{
		$LocalVertion = Get-Content -Path ~/$Vertion
		Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/Vertion.txt -OutFile ~/$VertionTemp
		$NowVertion = Get-Content -Path ~/$VertionTemp
		Remove-Item ~/$VertionTemp

		if( $LocalVertion -ne $NowVertion ){
			$Update = $True
		}
	}

	if( $Update ){
		Write-Output "最新版に更新します"
		Write-Output "更新完了後、PowerShell プロンプトを開きなおしてください"
		Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/$Module -OutFile ~/$Module
		Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/install.ps1 -OutFile ~/$Installer
		Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/uninstall.ps1 -OutFile ~/$UnInstaller
		Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/Vertion.txt -OutFile ~/$Vertion
		& ~/$Installer
		Remove-Item ~/$Module
		Remove-Item ~/$Installer
		Write-Output "更新完了"
		Write-Output "PowerShell プロンプトを開きなおしてください"
	}
	else{
		Write-Output "更新の必要はありません"
	}
	return
}


function GetSharePointbreadcrumb([switch]$Debug, [switch]$VertionCheck){


	if( $VertionCheck ){
		VertionCheck
		return
	}

	$URL = Get-Clipboard

	$RejectString = "^.+AllItems\.aspx\?"
	$SelectStart = "Shared Documents\/"
	$SelectEnd = "&"

	Add-Type -AssemblyName System.Web
	$DecodeURL = [System.Web.HttpUtility]::UrlDecode($URL)

	if( $RejectString -ne $null ){
		$SelectURL = $DecodeURL -replace $RejectString, ""
	}
	else{
		$SelectURL = $DecodeURL
	}


	$RejectStart = "^.+" + $SelectStart
	$SelectURL2 = $SelectURL -replace $RejectStart, $SelectStart.Replace('\','')

	$RejectEnd = $SelectEnd + ".+"
	$SelectURL3 = $SelectURL2 -replace $RejectEnd, ""

	$ClipbordStrings = @()

	if( $SelectURL3 -match "$SelectStart(?<SPPath>.+?)$" ){
		$SharePointPath = $Matches.SPPath
		$SharePointBreadcrumb = $SharePointPath -replace "\/", " > "
		$ClipbordStrings += $SharePointBreadcrumb
		$ClipbordStrings += $URL
		$ClipbordStrings += ""
		Set-Clipboard -Value $ClipbordStrings
		Write-Output "OK"
	}
	else{
		Write-Output "NG"
		if( $Debug ){
			Write-Output $DecodeURL
		}
	}
}

