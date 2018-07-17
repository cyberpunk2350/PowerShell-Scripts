#region top
Function Get-DNS-test {
    [CmdletBinding()]
	param (
        [parameter(mandatory=$true)]
        [Alias("cn","ComputerName","URL")]
        [string[]]$Name,
        [parameter(mandatory=$false)]
        [string[]]$Server = @(
			"1.1.1.1",			#CloudFlair
			"1.0.0.1",			#CloudFlair
			"8.8.8.8", 			#Google
			"8.8.4.4", 			#Google
			"9.9.9.9" #, 		#Quad9
			<#"208.67.222.222", 	#OpenDNS
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
			"84.200.70.40"		#ihgip.net#>
        ),
		[Parameter()]
        [string]$ErrorLogFilePath = ".\errors.txt"
	)
#endregion


    foreach ($nm in $name){  Write-Debug "top of Name Loop"
        foreach ($svr in $Server){ Write-Debug "Top of Server Loop"

#            BEGIN {
#                Write-Debug "Begin Top"
#                Write-Debug "Begin Bottom"
#            }
#region Main Code
#            PROCESS {
#                Write-Debug "PROCESS Top"

                try{
                        Write-Debug "Try Top"
                    
                        Write-Debug "Resolve Server Hostname: $svr"
                    $DNS_Svr_Hostname = (Resolve-DnsName -Name $svr -Server $svr -ErrorAction SilentlyContinue -ErrorVariable Svr_err).NameHost
                    if ($Svr_err -ne "") {$DNS_Svr_Hostname = "Error"}
                        Write-Debug "$svr Resolved to: $DNS_Svr_Hostname"
    
                        Write-Debug "Resolveing $nm"
                    $results = Resolve-DnsName -Server $Server -DnsOnly -NoHostsFile -ErrorAction stop -ErrorVariable err -Name $nm   #$resolvParams
                   
                        Write-Debug "results = $results"

                        Write-Debug "Everything that is going in the item properties:"
                        Write-Debug "ServerName: $DNS_Svr_Hostname"
                        Write-Debug "ServerIP: $svr"
                        Write-Debug "Query: $nm"
                        Write-Debug "ResolveHostName: $results.NameHost"
                        Write-Debug "ResolveIPAddress: $results.IPAddress"

    
                    $properties = @{
                        DNSServerHostName =  $DNS_Svr_Hostname
                        DNSServerIPAddress = $svr
                        Query = $nm
                        ResolveHostName = $results.NameHost
                        ResolveIPAddress = $results.IPAddress
                    }

                        Write-Debug "Try Bottom"
                }
                catch{
                        Write-Debug "catch Top"

                    $properties = @{
                        DNSServerHostName = $DNS_Svr_Hostname
                        DNSServerIPAddress = $svr
                        Query = $nm
                        ResolveHostName = "Error"
                        ResolveIPAddress = "Error"
                    }
                        Write-Debug $properties.DNSServerHostName
                        Write-Debug $properties.DNSServerIPAddress
                        Write-Debug $properties.Query
                        Write-Debug $properties.ResolveHostName
                        Write-Debug $properties.ResolveIPAddress

                        Write-Debug "catch Bottom"
                }
                finally {
                        Write-Debug "finally Top"

                        Write-Debug "Buiding the new PSPbject"               
                    $obj = New-Object -TypeName PSObject -Property $properties

                        Write-Debug "The Results of the new object"
                    Write-Output $obj 
    
                        Write-Debug "finally Bottom"                
                }

#                Write-Debug "PROCESS Bottom"
#            }
#endregion
#            END {
#                Write-Debug "END Top"
#                Write-Debug "END Bottom"                
#            }  
            Write-Debug "Bottom of Server loop"
        } Write-Debug "End of Server loop"    
        Write-Debug "Bottom of Name loop"
    } Write-Debug "End of Name loop"
 Write-Debug "End of Tool"
}

