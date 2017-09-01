<#

Get-ItemProperty -Path Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorUser
Get-ItemProperty -path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorUser


set-ItemProperty -Path Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorUser -Value 1
Set-ItemProperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorUser -Value 1


if((Get-ItemProperty HKCU:\Software\hsg -Name bogus -ea 0).bogus) {'Propertyalready exists'}
ELSE { Set-ItemProperty -Path HKCU:\Software\hsg -Name bogus -Value'initial value'}

0 = Automatically deny elevation requests
1 = Prompt for credentials on the secure desktop
3 (Default) = Prompt for credentials


#>

$name = [Security.Principal.WindowsIdentity]::GetCurrent().name 
$AdminSet = (Get-ItemProperty -path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).ConsentPromptBehaviorUser
$SecSet = (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

if ($name.EndsWith('.adm')) {write-host "Logged in with an '.adm' Account" -ForegroundColor Cyan} Else {Write-host "Not Logged in with an '.adm' Account" -ForegroundColor Red}
if ($SecSet) {write-host "Running As an Administrator" -ForegroundColor Cyan} Else {Write-host "Not Running As an Administrator"  -ForegroundColor Red}

Write-host "Registry Setting: " -NoNewline

if (($AdminSet -eq 0) -or ($AdminSet -eq 3)) {
    if ($AdminSet -eq 0) {Write-Host "Automatically deny elevation requests" -ForegroundColor Red}
    if ($AdminSet -eq 3) {Write-Host "(Default) = Prompt for credentials" -ForegroundColor DarkCyan}
    
} ElseIf ($AdminSet -eq 1) {

    Write-Host "Prompt for credentials on the secure desktop" -ForegroundColor Cyan 

} Else {
    Write-host "Something went wrong" -ForegroundColor Red
}









