
<#PSScriptInfo

.VERSION 1.0.1.0

.GUID 6c21bae0-4ab4-40e2-8a49-3b8a3160f007

.AUTHOR Henry Rice

.COMPANYNAME 

.COPYRIGHT 

.TAGS 

.LICENSEURI 

.PROJECTURI https://github.com/cyberpunk2350/PowerShell/tree/master/Whois

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


.PRIVATEDATA 

#>

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
	  Purpose/Change: 
					  v1.0:		Initial script development
					  v1.0.1:	Changed function Name to match standard convention
								Replaced Write-Host with Write-Output
								Added more default Servers: quad9.net, OpenDNS, Level3.net, Symantec, DNSbyComodo.com, ihgip.net
	  
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
##							 Google,	Google,		Quad9,		OpenDNS,		  OpenDNS,			Level3,	   Level3,	  Symantec,		   Symantec,		DNSbyComodo.com,			 ihgip.net
    )

    foreach ($svr in $Server){
        try { 
			Write-output (Resolve-DnsName -Name $svr -Server $svr -ErrorAction Stop).namehost 
		} catch { 
			write-output $svr 
		}
        foreach ($nm in $name){
            try { 
                $results = Resolve-DnsName -Name $nm -Server $svr -ErrorAction Stop 
                $results | Format-Table 
                } catch {
                write-output "Exception Message: $($_.Exception.Message)" 
                }
            }
    }
}
New-Alias whois Get-DNS