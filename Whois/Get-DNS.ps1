
<#PSScriptInfo

.VERSION 2.0.0.0

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
      This is (was) a quick hack replacement for NSLOOKUP to check mutiple DNS Servers at one time.
      
	.DESCRIPTION 
      Quick DNS pull from your choice of DNS Servers
      
	.PARAMETER Name
      The site or address you are looking up.
      Wrap the URL or IP Address in quotes for mupliple sites.
      Can also use "CN","ComputerName", and "URL"

	.PARAMETER Server
      The DNS server(s) you want to query (limit 5)
      One server can put inputed without quotes
      Mutiple servers need to be wraped in quotes

    .PARAMETER CloudFlair
      Select to use the CloudFlair DNS Servers
      1.1.1.1     1dot1dot1dot1.cloudflare-dns.com
      1.0.0.1     1dot1dot1dot1.cloudflare-dns.com

    .PARAMETER Google
      Select to use the Google DNS Servers
      8.8.8.8     google-public-dns-a.google.com
      8.8.4.4     google-public-dns-b.google.com

    .PARAMETER Quad9
      Select to use the Quad9 DNS Server
      9.9.9.9     dns.quad9.net 
      
    .PARAMETER OpenDNS
      Select to use the OpenDNS DNS Servers
      208.67.222.222   resolver1.opendns.com
      208.67.220.220   resolver2.opendns.com

    .PARAMETER Level3
      Select to use the Level3 DNS Servers
      4.2.2.1   a.resolvers.level3.net
      4.2.2.2   b.resolvers.Level3.net
      4.2.2.3   c.resolvers.level3.net
      4.2.2.4   d.resolvers.level3.net
      4.2.2.5   e.resolvers.level3.net
      4.2.2.6   f.resolvers.level3.net

    .PARAMETER Symantec
      Select to use the Symantec DNS Servers
      199.85.126.10
      199.85.127.10

    .PARAMETER Comodo
      Select to use the Comodo DNS Servers
      8.26.56.26    ns1.recursive.dnsbycomodo.com
      8.20.247.20   ns2.recursive.dnsbycomodo.com

    .PARAMETER ihgip
      Select to use the ihgip DNS Servers
      84.200.69.80  resolver1.ihgip.net
      84.200.70.40  resolver2.ihgip.net

    .PARAMETER AllSvrs
      Uses to use all of the above servers

	.NOTES
	  Version:        2.0.0.0
	  Author:         Henry Rice
	  Creation Date:  01 Nov 2017
	  Purpose/Change: 
			  v1.0:   Initial script development
			  v1.0.1: Changed function Name to match standard convention
				  Replaced Write-Host with Write-Output
				  Added more default Servers: quad9.net, OpenDNS, Level3.net, Symantec, DNSbyComodo.com, ihgip.net
              v2.0:   Complete rewrite: 
                  Output is now a PS-Object! (need to fix the order the objects are outputed)
                  Split the included DNS server into seprate paramters due to paramter limit argument limit of 5 items. (Need to clean this up)
                  Moved the loops around so make it actully work correctly. (It's all about work flow)
                  Added some debug outputs to track whats going on. (Where did it break this time?)
	  
	.EXAMPLE
	  Get-DNS -Name Google.com -Server 8.8.8.8
	  Using both the Name with a URL and Server Parameters
	.EXAMPLE
	  Get-DNS -Name 1.1.1.1 -Server 8.8.8.8
	  Using both the Name with an IP Address and Server Parameters
	.EXAMPLE
	  Get-DNS google.com -CloudFlair -Google
      Useing one or more of the DNS Server Flags
    .EXAMPLE
      Get-DNS -Server "1.1.1.1","8.8.8.8" -Name "www.google.com","www.yahoo.com"
      Using two dns servers and URLs

	#> 
	
#region Parameters
    [CmdletBinding()]
	param (
        [parameter(mandatory=$true)]
        [Alias("cn","ComputerName","URL")]
        [string[]]$Name,
        [parameter(mandatory=$false)]
        [string[]]$Server,
		[Parameter()]
        [switch] $CloudFlair=$false,
		[Parameter()]
        [switch] $Google=$false,
		[Parameter()]
        [switch] $Quad9=$false,
		[Parameter()]
        [switch] $OpenDNS=$false,
		[Parameter()]
        [switch] $Level3=$false,
		[Parameter()]
        [switch] $Symantec=$false,
		[Parameter()]
        [switch] $Comodo=$false,
		[Parameter()]
        [switch] $ihgip=$false,
		[Parameter()]
        [switch] $AllSvrs=$false
	)
#endregion
#region Server Flags
        Write-Debug "Check Default Server Flags"
    if ($Server -ne ""){$Servers = $Server}
    if ($CloudFlair){$Servers = $Servers + @("1.1.1.1","1.0.0.1") }
    if ($Google){$Servers = $Servers + @("8.8.8.8", "8.8.4.4")}
    if ($Quad9){$Servers = $Servers + @("9.9.9.9")}
    if ($OpenDNS){$Servers = $Servers + @("208.67.222.222","208.67.220.220")}
    if ($Level3){$Servers = $Servers + @("4.2.2.1","4.2.2.2","4.2.2.3","4.2.2.4","4.2.2.5","4.2.2.6")}
    if ($Symantec){$Servers = $Servers + @("199.85.126.10","199.85.127.10")}
    if ($Comodo){$Servers = $Servers + @("8.26.56.26","8.20.247.20")}
    if ($ihgip){$Servers = $Servers + @("84.200.69.80","84.200.70.40")}
    if ($AllSvrs){
                Remove-Variable Servers
                $Servers = $Server + @( "1.1.1.1",			#CloudFlair
			                            "1.0.0.1",			#CloudFlair
			                            "8.8.8.8", 			#Google
			                            "8.8.4.4", 			#Google
			                            "9.9.9.9", 		    #Quad9
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
        }
           
    if($Servers -eq $null){
        Write-Debug "`$Servers is blank"
        Write-Error "At least DNS Server Must be Identified"
        Break
    }
#endregion    
#region Main Code
    foreach ($nm in $name){
        foreach ($svr in $Servers){
            try{
                    Write-Debug "Resolve Server Hostname: $svr"
                $DNS_Svr_Hostname = (Resolve-DnsName -Name $svr -Server $svr -ErrorAction SilentlyContinue -ErrorVariable Svr_err).NameHost
                if ($Svr_err -ne "") {$DNS_Svr_Hostname = "Error"}
                    Write-Debug "$svr Resolved to: $DNS_Svr_Hostname"
    
                    Write-Debug "Resolveing $nm"
                $results = Resolve-DnsName -Server $Server -DnsOnly -NoHostsFile -ErrorAction stop -ErrorVariable err -Name $nm   #$resolvParams
                   
                    Write-Debug "Everything that is going in the item properties:
                    ServerName: $DNS_Svr_Hostname
                    ServerIP: $svr
                    Query: $nm
                    ResolveHostName: $results.NameHost
                    ResolveIPAddress: $results.IPAddress"

                $properties = [ordered]@{
                    DNSServerHostName =  $DNS_Svr_Hostname
                    DNSServerIPAddress = $svr
                    Query = $nm
                    ResolveHostName = $results.NameHost
                    ResolveIPAddress = $results.IPAddress
                }
            }
            catch{
				$properties = [ordered]@{
                        DNSServerHostName = $DNS_Svr_Hostname
                        DNSServerIPAddress = $svr
                        Query = $nm
                        ResolveHostName = "Error"
                        ResolveIPAddress = "Error"
                    }
					Write-Debug "$properties.DNSServerHostName
                $properties.DNSServerIPAddress
                $properties.Query
                $properties.ResolveHostName
                $properties.ResolveIPAddress"
            }
            finally {

                    Write-Debug "Buiding the new PSPbject"               
                $obj = New-Object -TypeName PSObject -Property $properties

                    Write-Debug "The Results of the new object"
                Write-Output $obj 
   
            }
        } 
    }
 Write-Debug "End of Tool"
#endregion 
}
#New-Alias whois Get-DNS
