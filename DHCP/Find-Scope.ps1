
#Requires -Version 5.0
#Requires -Modules DhcpServer
#Requires -RunAsAdministrator

param (
    [parameter(mandatory=$false, ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
    [Alias("CN","__Server","IPAddress","Server")]
    [string[]]$Computername,  
    [parameter(mandatory=$true, ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
    [Alias("Bldg","Location","Loc","Site", "Search", "Description")]
    [string[]]$Name
)

$DHCP1 = @{ 'Hostname' = 'Lab-DHCP-001v'; 'IP' = '172.16.1.14'; }
$DHCP2 = @{ 'Hostname' = 'Lab-DHCP-002v'; 'IP' = '172.16.1.15'; }


foreach ($hosts in $Name) {
    $Search = "*" + $hosts + "*"
    Write-Host " "
    Write-Host "Check for Scope"  -ForegroundColor cyan
    Write-Host "Server: "  $DHCP1.Hostname -NoNewline  -ForegroundColor cyan
    try { 
        Get-DhcpServerv4Scope -ComputerName $dhcp1.ip | ?{ $_.Name -like $Search -and $_.State -eq "Active"} | select ScopeId,Name  -ErrorAction Stop | Format-Table
    } catch {
        write-host " "
        write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor red
        write-host " "
    }
    Write-Host "Server: "  $DHCP2.Hostname -NoNewline -ForegroundColor cyan
    try { 
        Get-DhcpServerv4Scope -ComputerName $dhcp2.ip | ?{ $_.Name -like $Search -and $_.State -eq "Active"} | select ScopeId,Name  -ErrorAction Stop | Format-Table
    } catch {
        write-host " "
        write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor red
        write-host " "
    }  

}