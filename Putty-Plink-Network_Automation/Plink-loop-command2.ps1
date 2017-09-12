param (
[string]$Devices = "./all-switches.csv",
[string]$pLinkLoc = ".\plink",
[string]$OutPutFile = ".\output.txt",
[string]$InPutFile = ".\input.txt",
[string]$ipAdd
)
$ACS_Cred = Get-Credential -Message "Enter ACS Cerdentials"
#
$ACS_PASSWORD = $ACS_Cred.GetNetworkCredential().password
$ACS_USERNAME = $ACS_Cred.UserName
#

Write-Output "" >> $OutPutFile
#
if($ipAdd -eq ""){
    $DB = Import-Csv $Devices
    foreach ($Data in $DB){
    $ipAdd = $Data.IP
    Write-Host $ipAdd 
    Write-Output $ipAdd >> $OutPutFile
#
    Get-Content $InPutFile | & $pLinkLoc -batch -ssh -pw $ACS_PASSWORD -l $ACS_USERNAME $ipAdd >> $OutPutFile
    Write-Output "" >> $OutPutFile
    }
}
elseif($ipAdd -ne ""){
    Get-Content $InPutFile | & $pLinkLoc -batch -ssh -pw $ACS_PASSWORD -l $ACS_USERNAME $ipAdd >> $OutPutFile
    Write-Output "" >> $OutPutFile
}
$ACS_PASSWORD = ""
$ACS_USERNAME = ""
$ACS_Cred = ""
