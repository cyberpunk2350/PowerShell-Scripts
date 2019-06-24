Function PingTee {
	Param(
		[Parameter(mandatory=$true)]
		[String] $ComputerName,
        [Float] $Delay = 1
		)
	while ($true) { 
		try {
			$thing = 'ResponseTime=' + (test-connection $ComputerName -count 1 -ErrorAction stop).ResponseTime 
		} 
		catch { 
			$thing =  Write-Output 'No Response' } 
		$thing | ForEach {'{0} - {1}' -f (Get-Date),$_}
        Start-Sleep -Seconds $Delay
	}
}
