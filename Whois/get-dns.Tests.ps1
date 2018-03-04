Function Get-DNS {
	<# 

	.SYNOPSIS 
	  This is a quick hack replacement for NSLOOKUP to check mutiple DNS Servers at one time.

	.DESCRIPTION 
	  Quick DNS pull from your choice of DNS Servers
	  Defaults to Google and Open DNS 

	.PARAMETER Name
	  The site or address you are looking up
	  Can also use "CN","ComputerName", and "URL"

	.PARAMETER Server
	  The DNS server(s) you want to query 

	.NOTES
	  Version:        1.0.1.0
	  Author:         Henry Rice
	  Creation Date:  01 Nov 2017
	  Purpose/Change: Initial script development
	  
	.EXAMPLE
	  Get-DNS -Name Google.com -Server 8.8.8.8
	  Using both the Name and Server Parameters
	.EXAMPLE  
	  Get-DNS -Name Google.com
	  Using Just the Name Parameter
	.EXAMPLE
	  Get-DNS google.com
	  Using Just the Name Parameter, however flag is not required to be included

	#> 
	
    [CmdletBinding()]
	param (
        [parameter(mandatory=$true)]
        [Alias("CN","ComputerName","URL")]
        [string[]]$Name,
        [parameter(mandatory=$false)]
        [string[]]$Server = ("8.8.8.8", "8.8.4.4", "9.9.9.9" , "208.67.222.222", "208.67.220.220", "4.2.2.1", "4.2.2.2", "199.85.126.10", "199.85.127.10", "8.26.56.26", "8.20.247.20", "84.200.69.80", "84.200.70.40")

    )
    $whois = New-Object -TypeName psobject
    #$whois | Add-Member -MemberType NoteProperty -Name Server -Value $svr
    $whois | Add-Member -MemberType NoteProperty -Name NameServer -Value "" #$dns
	$whois | Add-Member -MemberType NoteProperty -Name NameServerIP -Value "" #$svr 
    $whois | Add-Member -MemberType NoteProperty -Name ResolveName -Value "" #$results.name
    $whois | Add-Member -MemberType NoteProperty -Name ResolveIP -Value "" #$results.IPAddress

    foreach ($svr in $Server){
    
        try{
            $dns = (Resolve-DnsName -Name $svr -Server $svr -ErrorAction Stop).namehost 
        } catch {
            $dns = ""
        }
        $whois.NameServer = $dns
		$whois.NameServerIP = $svr 
	
        foreach ($nm in $name){
            try { 
                $results = Resolve-DnsName -Name $nm -Server $svr -ErrorAction Stop 
                
            } catch {
                write-error "Exception Message: $($_.Exception.Message)" 
            }
        $whois.ResolveName = $results.name
        $whois.ResolveIP = $results.IPAddress
        }
      #  Write-host " "
    }
        Return $whois
}