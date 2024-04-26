function GetSharePointbreadcrumb([switch]$Debug){
	$URL = Get-Clipboard

	$RejectString = ".+AllItems\.aspx\?"
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

