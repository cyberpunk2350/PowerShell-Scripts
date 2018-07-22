.SYNOPSIS </br>
    This is (was) a quick hack replacement for NSLOOKUP to check mutiple DNS Servers at one time.</br>
      </br>
.DESCRIPTION </br>
    Quick DNS pull from your choice of DNS Servers</br>
      </br>
.PARAMETER Name</br>
    The site or address you are looking up.</br>
    Wrap the URL or IP Address in quotes for mupliple sites.</br>
    Can also use "CN","ComputerName", and "URL"</br>
</br>
.PARAMETER Server</br>
    The DNS server(s) you want to query (limit 5)</br>
    One server can put inputed without quotes</br>
    Mutiple servers need to be wraped in quotes</br>
</br>
.PARAMETER CloudFlair</br>
    Select to use the CloudFlair DNS Servers</br>
    1.1.1.1     1dot1dot1dot1.cloudflare-dns.com</br>
    1.0.0.1     1dot1dot1dot1.cloudflare-dns.com</br>
</br>
.PARAMETER Google</br>
    Select to use the Google DNS Servers</br>
    8.8.8.8     google-public-dns-a.google.com</br>
    8.8.4.4     google-public-dns-b.google.com</br>
</br>
.PARAMETER Quad9</br>
    Select to use the Quad9 DNS Server</br>
    9.9.9.9     dns.quad9.net </br>
      </br>
.PARAMETER OpenDNS</br>
    Select to use the OpenDNS DNS Servers</br>
    208.67.222.222   resolver1.opendns.com</br>
    208.67.220.220   resolver2.opendns.com</br>
</br>
.PARAMETER Level3</br>
    Select to use the Level3 DNS Servers</br>
    4.2.2.1   a.resolvers.level3.net</br>
    4.2.2.2   b.resolvers.Level3.net</br>
    4.2.2.3   c.resolvers.level3.net</br>
    4.2.2.4   d.resolvers.level3.net</br>
    4.2.2.5   e.resolvers.level3.net</br>
    4.2.2.6   f.resolvers.level3.net</br>
</br>
.PARAMETER Symantec</br>
    Select to use the Symantec DNS Servers</br>
    199.85.126.10</br>
    199.85.127.10</br>
</br>
.PARAMETER Comodo</br>
    Select to use the Comodo DNS Servers</br>
    8.26.56.26    ns1.recursive.dnsbycomodo.com</br>
    8.20.247.20   ns2.recursive.dnsbycomodo.com</br>
</br>
.PARAMETER ihgip</br>
    Select to use the ihgip DNS Servers</br>
    84.200.69.80  resolver1.ihgip.net</br>
    84.200.70.40  resolver2.ihgip.net</br>
</br>
.PARAMETER AllSvrs</br>
    Uses to use all of the above servers</br>
</br>
.NOTES</br>
	Version:        2.0.0.0</br>
	Author:         Henry Rice</br>
	Creation Date:  01 Nov 2017</br>
	Purpose/Change: </br>
			v1.0:   Initial script development</br>
			v1.0.1: Changed function Name to match standard convention</br>
				Replaced Write-Host with Write-Output</br>
				Added more default Servers: quad9.net, OpenDNS, Level3.net, Symantec, DNSbyComodo.com, ihgip.net</br>
            v2.0:   Complete rewrite: </br>
                Output is now a PS-Object! (need to fix the order the objects are outputed)</br>
                Split the included DNS server into seprate paramters due to paramter limit argument limit of 5 items. (Need to clean this up)</br>
                Moved the loops around so make it actully work correctly. (It's all about work flow)</br>
                Added some debug outputs to track whats going on. (Where did it break this time?)</br>
	  </br>
.EXAMPLE</br>
	Get-DNS -Name Google.com -Server 8.8.8.8</br>
	Using both the Name with a URL and Server Parameters</br>
.EXAMPLE</br>
	Get-DNS -Name 1.1.1.1 -Server 8.8.8.8</br>
	Using both the Name with an IP Address and Server Parameters</br>
.EXAMPLE</br>
	Get-DNS google.com -CloudFlair -Google</br>
    Useing one or more of the DNS Server Flags</br>
.EXAMPLE</br>
    Get-DNS -Server "1.1.1.1","8.8.8.8" -Name "www.google.com","www.yahoo.com"</br>
    Using two dns servers and URLs</br>
