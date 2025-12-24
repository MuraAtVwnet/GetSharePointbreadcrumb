function GetSharePointbreadcrumb([switch]$Debug, [switch]$FileName, [switch]$VertionCheck){

	if( $VertionCheck ){
		$ModuleName = "GetSharePointbreadcrumb"
		$GitHubName = "MuraAtVwnet"

		$HomeDirectory = "~/"
		$Module = $ModuleName + ".psm1"
		$Installer = "Install" + $ModuleName + ".ps1"
		$Uninstaller = "Uninstall" + $ModuleName + ".ps1"
		$Vertion = "Vertion" + $ModuleName + ".txt"
		$GithubCommonURI = "https://raw.githubusercontent.com/$GitHubName/$ModuleName/refs/heads/main/"
		$VertionTemp = "VertionTemp" + $ModuleName + ".tmp"
		$VertionFilePath = Join-Path "~/" $Vertion
		$VertionTempFilePath = Join-Path "~/" $VertionTemp
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
			$ModuleFile = $HomeDirectory + $Module
			Invoke-WebRequest -Uri $URI -OutFile $ModuleFile

			$URI = $GithubCommonURI + "Install.ps1"
			$InstallerFile = $HomeDirectory + $Installer
			Invoke-WebRequest -Uri $URI -OutFile $InstallerFile

			$URI = $GithubCommonURI + "Uninstall.ps1"
			$OutFile = $HomeDirectory + $Uninstaller
			Invoke-WebRequest -Uri $URI -OutFile $OutFile

			$URI = $GithubCommonURI + "Vertion.txt"
			$OutFile = $HomeDirectory + $Vertion
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

	# 以下本来のコード

	$URL = Get-Clipboard

	$RejectString = "^.+AllItems\.aspx\?"
	$SelectStart = "Shared Documents\/"
	$SelectEnd = "&"

	Add-Type -AssemblyName System.Web
	$DecodeURL = [System.Web.HttpUtility]::UrlDecode($URL)

	$ClipbordStrings = @()

	if( $FileName ){
		if( $DecodeURL.Contains('&file=')){
			$Temp = $DecodeURL -replace ".+&file=" , ""
			$ClipbordStrings += $Temp -replace "&.+" , ""
			$ClipbordStrings += $URL
			$ClipbordStrings += ""
			Set-Clipboard -Value $ClipbordStrings
			Write-Output "Done"
		}
		else{
			Write-Output "NG"
		}
	}
	elseif( $Debug ){
		Write-Output $DecodeURL
	}
	else{

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
		}
	}
}

