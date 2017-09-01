﻿<#

Get-ItemProperty -path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorUser

Set-ItemProperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorUser -Value 1

0 = Automatically deny elevation requests
1 = Prompt for credentials on the secure desktop
3 (Default) = Prompt for credentials


#>
Param(
[switch] $Quite
)

# Gather the relivent details, username, Admin status, and the "Run As Admin" Registary Setting
$name = [Security.Principal.WindowsIdentity]::GetCurrent().name 
$SecSet = (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
$AdminSet = (Get-ItemProperty -path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).ConsentPromptBehaviorUser

if ($Quite -eq $false) {Write-host "Registry Setting: " -NoNewline}

# Check how Registary is set
if (($AdminSet -eq 0) -or ($AdminSet -eq 3)) {
	# If registary is set to disable or default attempt to change to "Prompt for credentials on the secure desktop"
    if ($Quite -eq $false){ # Status Statements
        if ($AdminSet -eq 0) {Write-Host "Automatically deny elevation requests"}
        if ($AdminSet -eq 3) {Write-Host "(Default) = Prompt for credentials"}
        Write-Host "Atempting to change"
    }

    if($name.EndsWith('.adm')) {
        if ($SecSet){ Set-ItemProperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorUser -Value 1 }
		else{ .\enable_user_Run_as_admin.reg }
        Start-Sleep -Seconds 2
        if ($Quite -eq $false) {If(((Get-ItemProperty -path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).ConsentPromptBehaviorUser) -eq 1) {Write-Host "Change Successfull"}Else{Write-Host "Change Failed" -ForegroundColor Red}}
    } 
}

ElseIf (($AdminSet -eq 1) -and ($Quite -eq $false)) {
    Write-Host "Prompt for credentials on the secure desktop" -ForegroundColor Cyan
} 

Else {
   if ($Quite -eq $false) {Write-host "Something went wrong" -ForegroundColor Red}
}








