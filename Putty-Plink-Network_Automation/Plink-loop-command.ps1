$ACS_Cred = Get-Credential -Message "Enter ACS Cerdentials"
#$IP_ADD = "192.168.0.1"
$ACS_PASSWORD = $ACS_Cred.GetNetworkCredential().password
$ACS_USERNAME = $ACS_Cred.UserName
#
$DB = Import-Csv ./all-switches.csv
#$pLinkLoc =  .\plink.exe
$OutPutLoc = '.\output.txt'
$InPutLoc = '.\input.txt'
#$cmds = ' < .\input.txt >> '
#
Write-Output "" >> $OutPutLoc
#
foreach ($Data in $DB){
$IP_ADD = $Data.IP
Write-Host $IP_ADD 
Write-Output $IP_ADD >> $OutPutLoc
#
Get-Content input.txt | & .\plink -batch -ssh -pw $ACS_PASSWORD $ACS_USERNAME@$IP_ADD >> $OutPutLoc
Write-Output "" >> $OutPutLoc
}
$ACS_PASSWORD = ""
$ACS_USERNAME = ""
$ACS_Cred = ""

#& ./plink.exe -ssh -pw [password] [username]@[Device IP] < [script] >> output.txt                        # < operater no implimentd
#& ./plink.exe -ssh -batch -pw $ACS_PASSWORD $ACS_USERNAME@$IP_ADD "show version | in .bin" >> $OutPutLoc #works for show commands
#& ./plink -ssh -batch -pw $ACS_PASSWORD $ACS_USERNAME@$IP_ADD "show running-config | include usern"      #works but only for show commands
#Get-Content input.txt | & .\plink -v -ssh -pw $ACS_PASSWORD $ACS_USERNAME@$IP_ADD >> $OutPutLoc          #invalid
#& ./plink -ssh -v -pw $ACS_PASSWORD $ACS_USERNAME@$IP_ADD $cmds $OutPutLoc                               #Line has invalid autocommand
#& ./plink -ssh -v -pw $ACS_PASSWORD $ACS_USERNAME@$IP_ADD '<' $InPutLoc >> $OutPutLoc                    #Line has invalid autocommand
#& .\plink.exe -ssh -v -pw $ACS_PASSWORD $ACS_USERNAME@$IP_ADD -m $InPutLoc >> $OutPutLoc                 #issue
