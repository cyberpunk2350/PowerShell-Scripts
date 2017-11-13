#Requires -Version 5.0
#Requires -Modules DhcpServer
#Requires -RunAsAdministrator

param (
    [parameter(mandatory=$true, ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
    [Alias("IPAddress","Scope")]
    [string[]]$ScopeId 

)

$DHCP1 = @{ 'Hostname' = 'Lab-DHCP-001v'; 'IP' = '172.16.1.14'; }
$DHCP2 = @{ 'Hostname' = 'Lab-DHCP-002v'; 'IP' = '172.16.1.15'; }



Write-Host "Server 1" -ForegroundColor cyan
Write-Host " "
Write-Host "Scope Details" -ForegroundColor cyan
Get-DhcpServerv4Scope -ScopeId $ScopeId -ComputerName $dhcp1.ip | Format-Table
Write-Host "Exclusion Range" -ForegroundColor cyan
Get-DhcpServerv4ExclusionRange -ScopeId $ScopeId -ComputerName $dhcp1.ip | Format-Table
Write-Host "Scope Statistics" -ForegroundColor cyan
Get-DhcpServerv4ScopeStatistics -ScopeId $ScopeId -ComputerName $dhcp1.ip | Format-Table
<#
Write-Host "Scope Policy" -ForegroundColor cyan
Get-DhcpServerv4Policy -ScopeId $ScopeId -ComputerName $dhcp1.ip | Format-Table
Write-Host "Scope Policy IP Range" -ForegroundColor cyan
Get-DhcpServerv4PolicyIPRange -ScopeId $ScopeId -ComputerName $dhcp1.ip | Format-Table
Write-Host "Reservations" -ForegroundColor cyan
Get-DhcpServerv4Reservation -ScopeId $ScopeId -ComputerName $dhcp1.ip | Format-Table
Write-Host "Leases" -ForegroundColor cyan
Get-DhcpServerv4Lease -ScopeId $ScopeId -ComputerName $dhcp1.ip | Format-Table
#>
Write-Host " "
Write-Host "Server 2" -ForegroundColor cyan
Write-Host " "
Write-Host "Scope Details" -ForegroundColor cyan
Get-DhcpServerv4Scope -ScopeId $ScopeId -ComputerName $dhcp2.ip | Format-Table
Write-Host "Exclusion Range" -ForegroundColor cyan
Get-DhcpServerv4ExclusionRange -ScopeId $ScopeId -ComputerName $dhcp2.ip | Format-Table
Write-Host "Scope Statistics" -ForegroundColor cyan
Get-DhcpServerv4ScopeStatistics -ScopeId $ScopeId -ComputerName $dhcp2.ip | Format-Table
<#
Write-Host "Scope Policy" -ForegroundColor cyan
Get-DhcpServerv4Policy -ScopeId $ScopeId -ComputerName $dhcp2.ip | Format-Table
Write-Host "Scope Policy IP Range" -ForegroundColor cyan
Get-DhcpServerv4PolicyIPRange -ScopeId $ScopeId -ComputerName $dhcp2.ip | Format-Table
Write-Host "Reservations" -ForegroundColor cyan
Get-DhcpServerv4Reservation -ScopeId $ScopeId -ComputerName $dhcp2.ip | Format-Table
Write-Host "Leases" -ForegroundColor cyan
Get-DhcpServerv4Lease -ScopeId $ScopeId -ComputerName $dhcp2.ip | Format-Table
#>
