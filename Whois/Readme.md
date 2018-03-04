.SYNOPSIS </br>
  This is a quick hack replacement for NSLOOKUP to check mutiple DNS Servers at one time.</br>
  </br>
.DESCRIPTION </br>
  Quick DNS pull from your choice of DNS Servers</br>
  Defaults to Google and Open DNS </br>
  </br>
.PARAMETER Name</br>
  The site or address you are looking up</br>
  Can also use "CN","ComputerName", and "URL"</br>
  </br>
.PARAMETER Server</br>
  The DNS server(s) you want to query </br>
  </br>
.NOTES
  Version:        1.0.1.0</br>
  Author:         Henry Rice</br>
  Creation Date:  01 Nov 2017</br>
  Purpose/Change: </br>
                  v1.0:     Initial script development</br>
                  v1.0.1:   Changed function Name to match std convention; </br>
                            Replaced Write-Host with Write-Output</br>
                            Added more default Servers: quad9.net, OpenDNS, Level3.net, Symantec, DNSbyComodo.com</br>
							</br>
.EXAMPLE</br>
  Get-DNS -Name Google.com -Server 8.8.8.8</br>
  Using both the Name and Server Parameters</br>
.EXAMPLE  </br>
  Get-DNS -Name Google.com</br>
  Using Just the Name Parameter</br>
.EXAMPLE</br>
  Get-DNS google.com</br>
  Using Just the Name Parameter, however flag is not required to be included</br>