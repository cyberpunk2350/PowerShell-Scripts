#region top
Function Get-DNS-test {
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
            Write-Debug "Check Flags"
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

    foreach ($nm in $name){  Write-Debug "top of Name Loop"
        foreach ($svr in $Servers){ Write-Debug "Top of Server Loop"

#region Main Code

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
#endregion

            Write-Debug "Bottom of Server loop"
        } Write-Debug "End of Server loop"    
        Write-Debug "Bottom of Name loop"
    } Write-Debug "End of Name loop"
 Write-Debug "End of Tool"
}

