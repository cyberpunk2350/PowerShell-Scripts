SYNOPSIS </br>
This is a quick hack replacement for NSLOOKUP to check mutiple DNS Servers at one time.</br>

.DESCRIPTION </br>
  Quick DNS pull from your choice of DNS Servers</br>
  Defaults to Google and Open DNS </br>


.PARAMETER Name</br>
   The site or address you are looking up</br>
   Can also use "CN","ComputerName", and "URL"</br>

.PARAMETER Server</br>
   The DNS server(s) you want to query </br>

.NOTES</br>
  Version:        1.0</br>
  Author:         Henry Rice</br>
  Creation Date:  01 Nov 2017</br>
  Purpose/Change: Initial script development</br>
  
.EXAMPLE</br>
  WhoIs -Name Google.com -Server 8.8.8.8</br>
  Using both the Name and Server Parameters</br>

.EXAMPLE  </br>
  WhoIs -Name Google.com</br>
  Using Just the Name Parameter</br>

.EXAMPLE</br>
  WhoIs google.com</br>
  Using Just the Name Parameter, however flag is not required to be included</br>
</br>
