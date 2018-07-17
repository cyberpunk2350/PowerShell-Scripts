$LogPreference = ".\errors.txt"
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

Function Get-DNS-test {
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
			  v1.0:   Initial script development
			  v1.0.1: Changed function Name to match standard convention
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
        [Alias("cn","ComputerName","URL")]
        [string[]]$Name,
        [parameter(mandatory=$false)]
        [string[]]$Server = @(
			"1.1.1.1",			#CloudFlair
			"1.0.0.1"<#,			#CloudFlair
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
			"84.200.70.40"		#ihgip.net #>
		),
		[Parameter()]
        [string]$ErrorLogFilePath = $LogPreference
	)
	
    
	
	BEGIN {
        Write-Debug "Begin Top"
        Write-Debug "setting error log"
        Remove-Item -Path $ErrorLogFilePath -Force -ErrorAction SilentlyContinue
        $ErrorsHappened = $False
        Write-Debug "Begin bottom"
    }
    PROCESS {
        Write-debug "process Top"
        Write-Debug "Start of Server Loop"
       # foreach ($svr in $Server) {
          #  Write-Debug "Server Loop Top"
          #  try { 
         #       Write-Debug "try top"
                write-debug "Resolve Server Hostname: $svr"
				$DNS_Svr_Hostname = (Resolve-DnsName -Name $svr -Server $svr -ErrorAction Stop).namehost
                Write-Debug "$svr Resolved to: $DNS_Svr_Hostname"
				<#$resolvParams = @{
					'Server' = $svr
					'DnsOnly' = $true
					'NoHostsFile' = $true
					'ErrorAction' = 'Stop'
					'ErrorVariable' = 'err'
					'Name' = $Name
				}#>
				#foreach ($nm in $name){
                Write-Debug "resolveing $name"
				$results = Resolve-DnsName -Server $svr -DnsOnly -NoHostsFile -ErrorAction Stop -ErrorVariable err -Name $Name   #$resolvParams
                Write-Debug "results = $results"
				Write-Debug "testing $name connectivity"
                Write-Debug $resolvParams.IPAddress
                $conn = Test-NetConnection $resolvParams.IPAddress
                Write-Debug $conn 
				if($conn.PingSucceeded){$p = 'Connected'}else{$p='Disconnected'}
				Write-Debug $DNS_Svr_Hostname
                Write-Debug $Server
                Write-Debug $Name
                Write-Debug $p
                Write-Debug $results.NameHost
                Write-Debug $results.IPAddress
                $properties = @{
					ServerName =  $DNS_Svr_Hostname
                    ServerIP = $Server
					ComputerName = $Name
					Status = $p
					ResolveName = $results.NameHost
					IPAddress = $results.IPAddress
				}	
				#}
		   #     Write-Debug "try botom"
           # } 
			#catch {
           #     Write-Debug "catch top"
          #      Write-Debug "catch botom"

              
           # } 
			#finally {
                Write-Debug "finally top"
                
                $obj = New-Object -TypeName PSObject -Property $properties
                #$obj.psobject.typenames.insert(0,'My.Awesome.Object')
                Write-Output $obj 
                Write-Debug $obj
                Write-Debug "finally botom"
         #   }
        #    Write-Debug "Server Loop Botom"
       # }
        Write-Debug "Progress Bottom"
    }
    END {
        Write-Debug "END Top"
        if ($ErrorsHappened) {
            Write-Warning "OMG, errors. Logged to $ErrorLogFilePath."
        }
        Write-Debug "END Bottom"
    }

	
<#    foreach ($svr in $Server){
		$resolvParams = @{
			'Server' = $svr
			'DnsOnly' = $true
			'NoHostsFile' = $true
			'ErrorAction' = 'Stop'
			'ErrorVariable' = 'err'
			'Name' = $Name
		}
	
        try { 
			Write-output (Resolve-DnsName -Name $svr -Server $svr -ErrorAction Stop).namehost 
		} catch { 
		} finally {
			write-output $svr 
		}
        foreach ($nm in $name){
            try { 
                $results = Resolve-DnsName $resolvParams #-Name $nm -Server $svr -ErrorAction Stop 
                #$results | Format-Table 
                } catch {
                write-output "Exception Message: $($err.Exception.Message)" 
                } finally {}
            }
    }#>
}
#New-Alias whois Get-DNS
