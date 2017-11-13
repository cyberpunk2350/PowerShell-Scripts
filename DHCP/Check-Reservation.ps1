#Requires -Version 5.0
#Requires -Modules DhcpServer
#Requires -RunAsAdministrator

param (
    [parameter(mandatory=$true, ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
    [Alias("CN","__Server","IPAddress","Server")]
    [string[]]$Computername 

)

$DHCP1 = @{ 'Hostname' = 'Lab-DHCP-001v'; 'IP' = '172.16.1.14'; }
$DHCP2 = @{ 'Hostname' = 'Lab-DHCP-002v'; 'IP' = '172.16.1.15'; }


foreach ($computer in $Computername) {
    
    Write-Host " "
    Write-Host "Check for Lease"  -ForegroundColor cyan
    Write-Host "Server: "  $DHCP1.Hostname -NoNewline  -ForegroundColor cyan
    try { 
        Get-DhcpServerv4lease -ComputerName $dhcp1.ip -IPAddress $computer -ErrorAction Stop | Format-Table
    } catch {
        write-host " "
        write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor red
        write-host " "
    }
    Write-Host "Server: "  $DHCP2.Hostname -NoNewline -ForegroundColor cyan
    try { 
        Get-DhcpServerv4lease -ComputerName $dhcp2.ip -IPAddress $computer -ErrorAction Stop | Format-Table
    } catch {
        write-host " "
        write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor red
        write-host " "
    }  

    Write-Host " "
    Write-Host "Check for Reservation" -ForegroundColor cyan
    Write-Host "Server: "  $DHCP1.Hostname -NoNewline -ForegroundColor cyan

    try { 
        Get-DhcpServerv4Reservation -ComputerName $dhcp1.ip -IPAddress $computer -ErrorAction Stop | Format-Table 
    } catch {
        write-host " "
        write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor red
        write-host " "
    }
    Write-Host "Server: "  $DHCP2.Hostname -NoNewline -ForegroundColor cyan
    try { 
       Get-DhcpServerv4Reservation -ComputerName $dhcp2.ip -IPAddress $computer -ErrorAction Stop | Format-Table
    } catch {
        write-host " "
        write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor red
        write-host " "
    } 
}