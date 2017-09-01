param (
[string]$Devices = ".\all-switches.csv",
[string]$pLinkLoc = ".\plink.exe",
[string]$OutPutFile = ".\output.txt",
[string]$InPutFile = ".\input.txt",
[string]$ipAdd,
[switch]$newscan,
[switch]$h,
[switch]$help,
[string]$cmd,
[switch]$debug
)
function plinkcall([string]$pcmd, [switch]$y){
if ($debug -eq $true){
    if($y -eq $true){
        write-host "pLinkLoc = " $pLinkLoc 
        write-host "ACS_PASSWORD = " $ACS_PASSWORD 
        write-host "ACS_USERNAME = " $ACS_USERNAME 
        write-host "ipAdd = " $ipAdd 
        write-host "pcmd = " $pcmd
        Write-Host "=========="}
    elseif($pcmd -eq ""){
        write-host "InPutFile = " $InPutFile 
        write-host "pLinkLoc = " $pLinkLoc 
        write-host "ACS_PASSWORD = " $ACS_PASSWORD 
        write-host "ACS_USERNAME = " $ACS_USERNAME 
        write-host "ipAdd = " $ipAdd 
        write-host "OutPutFile = " $OutPutFile
        Write-Host "=========="}
    else{
        write-host "pLinkLoc = " $pLinkLoc 
        write-host "ACS_PASSWORD = " $ACS_PASSWORD 
        write-host "ACS_USERNAME = " $ACS_USERNAME 
        write-host "ipAdd = " $ipAdd 
        write-host "pcmd = " $pcmd 
        write-host "OutPutFile = " $OutPutFile
        Write-Host "=========="}
    }
else{
    if($y -eq $true){Write-Output "yes" | & $pLinkLoc -ssh -pw $ACS_PASSWORD -l $ACS_USERNAME $ipAdd $pcmd}
    elseif($pcmd -eq ""){Get-Content $InPutFile | & $pLinkLoc -ssh -pw $ACS_PASSWORD -l $ACS_USERNAME $ipAdd >> $OutPutFile}
    else{& $pLinkLoc -ssh -pw $ACS_PASSWORD -l $ACS_USERNAME $ipAdd $pcmd >> $OutPutFile}
    }
}

$ACS_PASSWORD = ""
$ACS_USERNAME = ""
$ACS_Cred = ""

if($h -eq $true -or $help -eq $true){
Write-Host "
-Devices [File Path] 
    Filepath of CSV File with Device addresses
    Default value: .\all-switches.csv

-ipAdd [IP Address] 
    Single ip address to connect to insted of a list from a file (Overrides Devices Flag)

-pLinkLoc [File Path] 
    Filepath of plink exacutable
    Default value: .\plink.exe

-OutputFile [File Path] 
    File you want the output to go to
    Default value: .\output.txt

-InPutFile [File Path] 
    File with the commands to input
    Default value: .\input.txt

-cmd [Command] 
    A single command string you want to run (overrides InPutFile Flag)

-newscan 
    Run a new connection scan
-h 
    This much help
-debug 
    Displays variable values without running Plink
"
exit}

if($h -eq $false -and $help -eq $false){

$ACS_Cred = Get-Credential -Message "Enter Network Device Cerdentials"
$ACS_PASSWORD = $ACS_Cred.GetNetworkCredential().password
$ACS_USERNAME = $ACS_Cred.UserName

if($ipAdd -eq ""){
    $DB = Import-Csv $Devices
    foreach ($Data in $DB){
        $ipAdd = $Data.IP
        Write-Host $ipAdd 
        if($newscan -eq $true){plinkcall -pcmd "exit" -y}
        else{
            Write-Output $ipAdd >> $OutPutFile  
            plinkcall -pcmd $cmd
            Write-Output " " >> $OutPutFile
            }
    }
}

if($ipAdd -ne ""){
    if($newscan -eq $true){plinkcall -pcmd "exit" -y}
    else{
        Write-Host $ipAdd 
        Write-Output $ipAdd >> $OutPutFile  
        plinkcall -pcmd $cmd
        Write-Output "" >> $OutPutFile
    }
}

$ACS_PASSWORD = ""
$ACS_USERNAME = ""
$ACS_Cred = ""
}