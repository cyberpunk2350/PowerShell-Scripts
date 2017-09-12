$ACS_Cred = Get-Credential -Message "Enter ACS Cerdentials"
$IP_ADD = "192.168.0.1"
$ACS_PASSWORD = $ACS_Cred.GetNetworkCredential().password
$ACS_USERNAME = $ACS_Cred.UserName

& ./plink -ssh -batch -pw $ACS_PASSWORD $ACS_USERNAME@$IP_ADD "show running-config | include usern"


$ACS_PASSWORD = ""
$ACS_USERNAME = ""
$ACS_Cred = ""