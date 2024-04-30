function GetSharePointbreadcrumb([switch]$Debug, [switch]$VertionCheck){

	if( $VertionCheck ){
		$ScriptName = "GetSharePointbreadcrumb"
		$GitHubName = "MuraAtVwnet"
		$Module = $ScriptName + ".psm1"
		$Installer = "Install" + $ScriptName + ".ps1"
		$UnInstaller = "UnInstall" + $ScriptName + ".ps1"
		$Vertion = "Vertion" + $ScriptName + ".txt"
		$VertionTemp = "VertionTemp" + $ScriptName + ".tmp"

		$Update = $False

		if( -not (Test-Path ~/$Vertion)){
			$Update = $True
		}
		else{
			$LocalVertion = Get-Content -Path ~/$Vertion
			Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/Vertion.txt -OutFile ~/$VertionTemp
			$NowVertion = Get-Content -Path ~/$VertionTemp
			Remove-Item ~/$VertionTemp

			if( $LocalVertion -ne $NowVertion ){
				$Update = $True
			}
		}

		if( $Update ){
			Write-Output "最新版に更新します"
			Write-Output "更新完了後、PowerShell プロンプトを開きなおしてください"
			Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/$Module -OutFile ~/$Module
			Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/install.ps1 -OutFile ~/$Installer
			Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/uninstall.ps1 -OutFile ~/$UnInstaller
			Invoke-WebRequest -Uri https://raw.githubusercontent.com/$GitHubName/$ScriptName/master/Vertion.txt -OutFile ~/$Vertion
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
		$ClipbordStrings += ""
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

