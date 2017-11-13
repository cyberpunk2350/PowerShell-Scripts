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

.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         Henry Rice
  Creation Date:  01 Nov 2017
  Purpose/Change: Initial script development
  
.EXAMPLE
  WhoIs -Name Google.com -Server 8.8.8.8
  Using both the Name and Server Parameters

.EXAMPLE  
  WhoIs -Name Google.com
  Using Just the Name Parameter

.EXAMPLE
  WhoIs google.com
  Using Just the Name Parameter, however flag is not required to be included
