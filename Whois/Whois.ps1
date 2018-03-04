
<#PSScriptInfo

.VERSION 1.0

.GUID 6c21bae0-4ab4-40e2-8a49-3b8a3160f007

.AUTHOR Henry Rice

.COMPANYNAME 

.COPYRIGHT 

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


.PRIVATEDATA 

#>

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
  Get-DNS -Name Google.com -Server 8.8.8.8
  Using both the Name and Server Parameters
.EXAMPLE  
  WhoIs -Name Google.com
  Using Just the Name Parameter
.EXAMPLE
  Get-DNS google.com
  Using Just the Name Parameter, however flag is not required to be included

#> 

Function Get-DNS {
    param (
        [parameter(mandatory=$true)]
        [Alias("CN","ComputerName","URL")]
        [string[]]$Name,
        [parameter(mandatory=$false)]
        [string[]]$Server = ("8.8.8.8", "8.8.4.4", "208.67.222.222", "208.67.220.220")

    )

    foreach ($svr in $Server){
        Write-Host (Resolve-DnsName -Name $svr -Server $svr).namehost -ForegroundColor White
        foreach ($nm in $name){
            try { 
                $results = Resolve-DnsName -Name $nm -Server $svr -ErrorAction Stop 
                $results | Format-Table 
                } catch {
                write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor red
                }
            }
    }
}
