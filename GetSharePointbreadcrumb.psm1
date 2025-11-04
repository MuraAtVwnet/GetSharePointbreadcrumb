function GetSharePointbreadcrumb([switch]$Debug, [switch]$VertionCheck){

	if( $VertionCheck ){
		$ModuleName = "GetSharePointbreadcrumb"
		$GitHubName = "MuraAtVwnet"
		$Module = $ModuleName + ".psm1"
		$Installer = "Install" + $ModuleName + ".ps1"
		$UnInstaller = "UnInstall" + $ModuleName + ".ps1"
		$Vertion = "Vertion" + $ModuleName + ".txt"
		$VertionTemp = "VertionTemp" + $ModuleName + ".tmp"

		$VertionFilePath = Join-Path "~/" $Vertion
		$VertionTempFilePath = Join-Path "~/" $VertionTemp
		$GithubCommonURI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/master/"
		$VertionFileURI = $GithubCommonURI + "Vertion.txt"


		$Update = $False

		if( -not (Test-Path $VertionFilePath)){
			$Update = $True
		}
		else{
			$LocalVertion = Get-Content -Path $VertionFilePath

			$URI = $VertionFileURI
			$OutFile = $VertionTempFilePath
			Invoke-WebRequest -Uri $URI -OutFile $OutFile
			$NowVertion = Get-Content -Path $VertionTempFilePath
			Remove-Item $VertionTempFilePath

			if( $LocalVertion -ne $NowVertion ){
				$Update = $True
			}
		}

		if( $Update ){
			Write-Output "最新版に更新します"
			Write-Output "更新完了後、PowerShell プロンプトを開きなおしてください"

			$URI = $GithubCommonURI + $Module
			$OutFile = "~/$Module"
			$ModuleFile = $OutFile
			Invoke-WebRequest -Uri $URI -OutFile $OutFile

			$URI = $GithubCommonURI + "install.ps1"
			$OutFile = "~/$Installer"
			$InstallerFile = $OutFile
			Invoke-WebRequest -Uri $URI -OutFile $OutFile

			$URI = $GithubCommonURI + "uninstall.ps1"
			$OutFile = "~/$UnInstaller"
			Invoke-WebRequest -Uri $URI -OutFile $OutFile

			$URI = $VertionFileURI
			$OutFile = $VertionFilePath
			Invoke-WebRequest -Uri $URI -OutFile $OutFile

			& $InstallerFile

			Remove-Item $ModuleFile
			Remove-Item $InstallerFile

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

