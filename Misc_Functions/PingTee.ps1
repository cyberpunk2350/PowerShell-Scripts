Function PingTee {
	Param(
		[Parameter(mandatory=$true)]
		[String] $ComputerName
		)
	while ($true) { 
		try {
			$thing = 'ResponseTime=' + (test-connection $ComputerName -count 1 -ErrorAction stop).ResponseTime 
		} 
		catch { 
			$thing =  Write-Output 'No Response' } 
		$thing | ForEach {'{0} - {1}' -f (Get-Date),$_}
		$x=0
		while($x -le 500000){
			$x++
		} 
	}
}
