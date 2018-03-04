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
				  v1.0.1:	Changed function Name to match std convention; 
							Replaced Write-Host with Write-Output
							Added more default Servers: quad9.net, OpenDNS, Level3.net, Symantec, DNSbyComodo.com

.EXAMPLE
  Get-DNS -Name Google.com -Server 8.8.8.8
  Using both the Name and Server Parameters
.EXAMPLE  
  Get-DNS -Name Google.com
  Using Just the Name Parameter
.EXAMPLE
  Get-DNS google.com
  Using Just the Name Parameter, however flag is not required to be included