Function Get-TimeLeft {
	Param(
	[Parameter(mandatory=$true, HelpMessage="Enter Count Down Date (Format YYYY-MM-DD)") ]
	[String] $Date,
	[Parameter(mandatory=$false, HelpMessage="What Are You Counting Down To?") ][String] $Message
	)
	$days = (New-TimeSpan -Start (get-date) -End $date).Days 
	if ($Message -ne "") {Write-Output "$days Days Until $message ($Date)"}else{$days}
}
