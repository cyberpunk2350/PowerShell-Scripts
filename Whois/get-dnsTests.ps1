Function Get-DNStest {
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
        [string[]]$Server = @(
			"1.1.1.1",			#CloudFlair
			"1.0.0.1",			#CloudFlair
			"8.8.8.8", 			#Google
			"8.8.4.4", 			#Google
			"9.9.9.9" , 		#Quad9
			"208.67.222.222", 	#OpenDNS
			"208.67.220.220", 	#OpenDNS
			"4.2.2.1", 			#Level3
			"4.2.2.2", 			#Level3
			"4.2.2.3", 			#Level3
			"4.2.2.4", 			#Level3
			"4.2.2.5", 			#Level3
			"4.2.2.6", 			#Level3
			"199.85.126.10", 	#Symantec
			"199.85.127.10", 	#Symantec
			"8.26.56.26", 		#DNSbyComodo.com
			"8.20.247.20", 		#DNSbyComodo.com
			"84.200.69.80", 	#ihgip.net
			"84.200.70.40"		#ihgip.net

		)

    )
    Write-Verbose "Function Start"
    Write-debug "Create whois var"
    $whois = New-Object -TypeName psobject
    #$whois | Add-Member -MemberType NoteProperty -Name Server -Value $svr
    $whois | Add-Member -MemberType NoteProperty -Name NameServer -Value "" #$dns
	$whois | Add-Member -MemberType NoteProperty -Name NameServerIP -Value "" #$svr 
    $whois | Add-Member -MemberType NoteProperty -Name ResolveName -Value "" #$results.name
    $whois | Add-Member -MemberType NoteProperty -Name ResolveIP -Value "" #$results.IPAddress
    $target = @('test')
    Write-Debug "Name Var: $Name"
    Write-Debug "Server Var: $Server"
    Write-Debug "whois Ver: $whois"
    

    foreach ($svr in $Server){
    Write-Verbose "Server ForLoop: Start"
        try{
            Write-Verbose "Server Loop Try: Start"
            $dns = (Resolve-DnsName -Name $svr -Server $svr -ErrorAction Stop).namehost 
            Write-Debug "Server: $svr"
            Write-Debug "DNS Server Results: $dns"
            Write-Verbose "Server Loop Try: End"
        } catch {
            Write-Verbose "Server Loop Catch: Start"
            $dns = ""
            Write-Debug "DNS Server IP does not Resolve"
            Write-Verbose "Server Loop Catch: end"
        }
        $whois.NameServer = $dns
		$whois.NameServerIP = $svr

        Write-Debug "Current state of whois var: $whois"

        foreach ($nm in $name){
        Write-Verbose "Start of Name ForLoop"
        Write-Debug "nm Value: $nm"
		$resolvParams = @{
			'Server' = $svr
			'DnsOnly' = $true
			'NoHostsFile' = $true
			'ErrorAction' = 'Stop'
			'ErrorVariable' = 'err'
			'Name' = $nm
		}
		try { 
            Write-Verbose "Name Loop Try: Start"
            Write-Debug "ResolParams Var: $resolvParams"
            #$results = Resolve-DnsName $resolvParams
            $results = Resolve-DnsName -Name $nm -Server $svr -ErrorAction Stop  -ErrorVariable err -DnsOnly -NoHostsFile
            Write-Debug "Contents of results Var $results"
            Write-Verbose "Name Loop Try: End"
        } catch {
            Write-Verbose "Name Loop Catch: Start"
            Write-Debug "Error Var: $err"
            write-error "Exception Message: $($err.Exception.Message)" 
            Write-Verbose "Name Loop Catch: End"
        }
        $whois.ResolveName = $results.Name
        $whois.ResolveIP = $results.IPAddress
        Write-Debug "Current state of whois var: $whois"
        #Return $whois
        Write-Verbose "Server ForLoop: End"
        }
      
      # Write-host " "
      Write-Debug "Current state of whois var: $whois"
      $target = $target + $whois 
      Write-Debug "Target Var: $target"
      Write-Verbose "Server ForLoop: End"
    }
    Write-Debug "Current state of whois var: $whois"
    Write-Verbose "Function: End"
    Return $target
}
