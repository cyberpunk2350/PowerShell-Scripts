
Function Open-POSHeditor {
	<# 

	.SYNOPSIS 
	  Opens Scripts in choice of editor

	.DESCRIPTION 
	  Open file in a script editors.
	  Editors include Notepad, Notepad++, ISE, and Visual Studio

	.PARAMETER Editor
	  The Editor of choice:
	  Notepad 
	  Notepad++
	  ISE
	  Visual Studio

	.PARAMETER File
	  Script to edit 
	  If file does not exist, it will be created.
	  
	.INPUTS
	  None

	.OUTPUTS
	  None

	.NOTES
	  Version:        1.0
	  Author:         Henry Rice
	  Creation Date:  27 Jan 2018
	  Purpose/Change: Initial script development
	  
	.EXAMPLE
	  Open-POSHeditor -Editor Notepad -File Test.ps1
	  Using both the Editor and File Parameters
	
	#> 
	
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, HelpMessage="The Editor You want to use (Notepad, Notepad++, VS, or ISE):")]
		[ValidateSet("Notepad", "Notepad++", "ISE", "VS", "Atom")]
        [alias("e")]
        [String] $Editor,
		[Parameter(Mandatory = $true, HelpMessage="Input the file you want to edit here:")]
        [alias("f")]
		[String] $File
	)
	if ($Editor -ne $null){
		if (($Editor -eq "Notepad++") -and (test-path 'C:\Program Files\notepad++\notepad++.exe') ){
			Write-Verbose "Loading Notepad++"
			$np='C:\Program Files\notepad++\notepad++.exe'
		}
		elseif(($Editor -eq "ISE") -and (test-path 'C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell_ise.exe')) {
			Write-Verbose "Loading PowerShell ISE"
			$np='C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell_ise.exe'
		}
		elseif (($Editor -eq "Notepad") -and (test-path 'C:\Windows\notepad.exe')){
			Write-Verbose "Loading Notepad"
			$np='C:\Windows\notepad.exe'
		}
		elseif(($Editor -eq "VS") -and (test-path "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe")){
			Write-Verbose "Loading Visual Studio"
			$np="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
		}		
		elseif(($Editor -eq "Atom") -and (test-path "~\AppData\Local\atom\atom.exe")){
			Write-Verbose "Loading Atom"
			$np="~\AppData\Local\atom\atom.exe"
		}
		else{
			Write-Error "Something is Wrong...Try again"
			Return
		}
	}
	if (-not (test-path $File)){
		Write-Verbose "File does not exist.  Creating File."
		if(([IO.Path]::GetExtension($File)) -eq '.ps1'){
			New-ScriptFileInfo -Description . -path $File
		}else{New-Item $File}
	}
	
	Start-Process $np $file
}
New-Alias oe Open-POSHeditor
New-Alias np -value 'C:\Program Files\notepad++\notepad++.exe'

Function Get-CurrentUser { 
	[Security.Principal.WindowsIdentity]::GetCurrent().name 
} 

Function Edit-Profile {
	<# 
	.SYNOPSIS 
	  Check for and Open the PowerShell Profile in an editor
	  
	.DESCRIPTION 
	  Checks to see if there is a PowerShell Profile, 
      if there isn't one then then one is created and open in the editor 
	 
	.NOTES
	  Version:        1.1.0.0
	  Author:         Henry Rice
	  Creation Date:  24 Nov 2017
	  Purpose/Change: v1.0: Initial script development
                      V1.1: Slight rewrite and clean up  
	.EXAMPLE
	  Edit-Profile
	  	
	#> 
	[CmdletBinding()]
	Param()
	if (test-path 'C:\Program Files\notepad++\notepad++.exe'){
		$np='C:\Program Files\notepad++\notepad++.exe'
	}
	elseif(test-path 'C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell_ise.exe') {
		$np='C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell_ise.exe'
	}
	else{
		$np='C:\Windows\notepad.exe'
	}
	if (test-path $PROFILE.CurrentUserCurrentHost){ 
		Start-Process $np $profile.CurrentUserCurrentHost 
	} 
	elseif (test-path $profile.CurrentUserAllHosts){
		Start-Process $np $profile.CurrentUserAllHosts 
	}
	else { 
		new-item $PROFILE.CurrentUserAllHosts -ItemType file -Force
		Start-Process $np $profile.CurrentUserAllHosts
	}
}
New-Alias pro Edit-Profile

Function Get-IP {
	Get-NetIPConfiguration -all | select ComputerName, InterfaceAlias, IPv4Address
}

Function Get-PSVersion { 
	if (test-path variable:psversiontable) {
		$psversiontable.psversion
		#$Host.Version
	} else {
		[version]"1.0.0.0"
	} 
}
New-Alias ver Get-PSVersion

Function Send-Mail {
	<# 
	.SYNOPSIS 
	  Shortcut to send a mail from the CLI 
	  
	.DESCRIPTION 
	  Sends an email from the CLI
	  This function works best when you pre-designate the SMTP, From, To, and Subject options

	.PARAMETER smtpSvr
	  The server you want to send from
	  *no options supported at this time

	.PARAMETER mailFrom
	  What email address the message is being sent from
	  
	.PARAMETER mailDest
	  Address you are sending the email to
	  
	.PARAMETER mailSub
	   The Subject list of the email

	.PARAMETER mailBody
	  The Message you want to send
	  
	.NOTES
	  Version:        1.0.1.0
	  Author:         Henry Rice
	  Creation Date:  25 Aug 2017
	  Purpose/Change: Initial script development

	.EXAMPLE
	  Send-Mail -smtpSvr mail.example.com -mailFrom me@example.com -mailDest you@example.com -mailSub "Example Eamil" -mailBody "Body of example email"
	  
	.EXAMPLE
	 Send-Mail -Body "Example Email"
	 If you identify everying in the function then all you need to do is include the body and send
	 
	#> 

	[cmdletbinding()]	
	Param(
        [Parameter(Mandatory = $true, HelpMessage="Input the body of the message here:")]
        [alias("Body")]
        [String] $mailBody,
		[String] $smtpSvr = '',
        [alias("Dest")]
        [String] $mailDest = "",
		[alias("Sub")]
        [String] $mailSub = "",
		[alias("From")]
        [String] $mailFrom = ""
		)
		Send-mailmessage -DeliveryNotificationOption OnFailure -SmtpServer $smtpSvr -to $mailDest -from $mailFrom -subject $mailSub -body $mailBody
}

Function Set-CustomConsole {
	<# 

	.SYNOPSIS 
	  Set custom setting for the console

	.DESCRIPTION 
	  Set the console enviroment to custom settings

	.PARAMETER 
	  None...yet

	.NOTES
	  Version:        1.0.5.0
	  Author:         Henry Rice
	  Creation Date:  01 Jun 2017
	  Purpose/Change: Initial script development
	  Update Date:    01 Jan 2018
	  Change:         Combind ISE and Console setting into one function
	  
	.EXAMPLE
	  Set-CustomConsole

	#> 
<#  Console Defaults:
		## Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, DarkGray, 
		## White, Blue, 	Green,     Cyan, 	 Red, 	  Magenta,     Yellow, 	   Gray,
	ForegroundColor       : DarkYellow
	BackgroundColor       : DarkMagenta
	CursorPosition        : 0,28
	WindowPosition        : 0,0
	CursorSize            : 25
	BufferSize            : 120,3000
	WindowSize            : 120,50
	MaxWindowSize         : 120,84
	MaxPhysicalWindowSize : 274,84
	KeyAvailable          : False
	WindowTitle           : Windows PowerShell #>
	
	[cmdletbinding()]
    param  ()	
	if($host.Name -eq 'ConsoleHost'){
		$Shell = $Host.UI.RawUI
		$shell.BackgroundColor = "Black"
		$shell.ForegroundColor = "DarkGreen"
		
		If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){
			$host.ui.rawui.WindowTitle="Admin: PowerShell Console"
		}else{
			$shell.WindowTitle = "PowerShell Console"
		}		
		
		$Wsize = $Shell.WindowSize
		$Wsize.width=130
		$Wsize.height=50
		
		$Bsize = $Shell.BufferSize
		$Bsize.width=130
		$Bsize.height=3000
		
		if($Bsize.width -gt $Shell.WindowSize.width){
			$Shell.WindowSize.width = $Wsize.width
			$Shell.BufferSize.width = $Bsize.width
		}else{
			$Shell.BufferSize.width = $Bsize.width
			$Shell.WindowSize.width = $Wsize.width
		}
		if($Bsize.height -gt $Shell.WindowSize.height){
			$Shell.WindowSize.height = $Wsize.height
			$Shell.BufferSize.height = $Bsize.height
		}else{
			$Shell.BufferSize.height = $Bsize.height
			$Shell.WindowSize.height = $Wsize.height
		}		
		
	}
	elseif($host.Name -eq 'Windows PowerShell ISE Host'){
		$psise.options.ConsolePaneBackgroundColor = "Black"
		$psise.options.ConsolePaneTextBackgroundColor = "Black"
		$psise.options.ConsolePaneForegroundColor = "DarkGreen"
		}
	else {
		Write-Error "Failed to Change Settings"
	}
 }

Function Reset-Console {
	<# 

	.SYNOPSIS 
	  Reset the Console to the defult settings

	.DESCRIPTION 
	  Resets the Console to defualt

	.PARAMETER 
	  None...yet

	.NOTES
	  Version:        1.0.5.0
	  Author:         Henry Rice
	  Creation Date:  01 Jun 2017
	  Purpose/Change: Initial script development
	  Update Date:    01 Jan 2018
	  Change:         Combind ISE and Console setting into one function
	  
	.EXAMPLE
	  Reset-Console

	#> 
	[cmdletbinding()]
    param  ()	
	if($host.Name -eq 'ConsoleHost'){
		<# Console Defaults:
		ForegroundColor       : DarkYellow
		BackgroundColor       : DarkMagenta
		CursorPosition        : 0,13
		WindowPosition        : 0,0
		CursorSize            : 25
		BufferSize            : 120,3000
		WindowSize            : 120,50
		MaxWindowSize         : 120,94
		MaxPhysicalWindowSize : 273,94
		KeyAvailable          : False
		WindowTitle           : Windows PowerShell
		#>
		<# Screen Defaults
		Screen Text
		   Red   238
		   Green 237
		   Blue  240
		Screen Background
		   Red     1
		   Green  36
		   Blue   86
		Popup Text
		   Red     0
		   Green 128
		   Blue  128
		Popup Background
		   Red   255
		   Green 255
		   Blue  255
		Font: 8x12
		Size: 80x25
		#>
		$Shell = $Host.UI.RawUI
		
		$shell.BackgroundColor = "DarkBlue"
		$shell.ForegroundColor = "Gray"
		
		$Wsize = $Shell.WindowSize
		$Wsize.width=120
		$Wsize.height=50
		
		$Bsize = $Shell.BufferSize
		$Bsize.width=120
		$Bsize.height=3000
		
		if($Bsize.width -lt $Shell.WindowSize.width){
			$Shell.WindowSize.width = $Wsize.width
			$Shell.BufferSize.width = $Bsize.width
		}else{
			$Shell.BufferSize.width = $Bsize.width
			$Shell.WindowSize.width = $Wsize.width
		}
		if($Bsize.height -lt $Shell.WindowSize.height){
			$Shell.WindowSize.height = $Wsize.height
			$Shell.BufferSize.height = $Bsize.height
		}else{
			$Shell.BufferSize.height = $Bsize.height
			$Shell.WindowSize.height = $Wsize.height
		}
		
		
		If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){
			$host.ui.rawui.WindowTitle="Administrator: Windows PowerShell"
		}
		else{
			$shell.WindowTitle = "Windows PowerShell"
		}
	}
	elseif($host.Name -eq 'Windows PowerShell ISE Host'){
		$psise.options.ConsolePaneBackgroundColor = "Black"
		$psise.options.ConsolePaneTextBackgroundColor = "Black"
		$psise.options.ConsolePaneForegroundColor = "DarkGreen"
	}
	else {
		Write-Error "Failed to Change Settings"
	}	
}

Function Edit-HostsFile {
    Start-Process -FilePath notepad++ -ArgumentList "$env:windir\system32\drivers\etc\hosts"
}

Function Test-Admin {

	<#PSScriptInfo

	.VERSION 1.0.1.0

	.GUID 6f21fa70-27d6-4cef-8607-a2d96691aa85

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
	  Checks the status of the current administrative environment 
	  
	.DESCRIPTION 
	  Checks the status of the current administrative environment 
	 
	.NOTES
	  Version:        1.0.1.0
	  Author:         Henry Rice
	  Creation Date:  01 Oct 2017
	  Purpose/Change: Initial script development

	.EXAMPLE
	  Test-Admin
	  	
	#> 

	[cmdletbinding()]
    param  ()
    $name = [Security.Principal.WindowsIdentity]::GetCurrent().name 
    $AdminSet = (Get-ItemProperty -path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).ConsentPromptBehaviorUser
    $SecSet = (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

    Write-output "Account Type: "
    if ($name.EndsWith('.adm')) {
        write-output "     Logged in with an '.adm' Account"
    } Else {
        Write-output "     Not Logged in with an '.adm' Account"
    }
    Write-output "Current Admin Status: "
    if ($SecSet) {
        write-output "     Running As an Administrator"
    } Else {
        Write-Output "     Not Running As an Administrator"
    }

    Write-output "Registry Setting: "

    if (($AdminSet -eq 0) -or ($AdminSet -eq 3)) {
        if ($AdminSet -eq 0) {
            Write-output "     Automatically deny elevation requests"
        }
        if ($AdminSet -eq 3) {
            Write-output "     (Default) = Prompt for credentials"
        }
    
    } ElseIf ($AdminSet -eq 1) {

        Write-output "     Prompt for credentials on the secure desktop"

    } Else {
        Write-Error "Something went wrong"
    }
}

Function Get-DNS {
    <#PSScriptInfo

    .VERSION 2.0.0.0

    .GUID 6c21bae0-4ab4-40e2-8a49-3b8a3160f007

    .AUTHOR Henry Rice

    .COMPANYNAME 

    .COPYRIGHT 

    .TAGS 

    .LICENSEURI 

    .PROJECTURI https://github.com/cyberpunk2350/PowerShell/tree/master/Whois

    .ICONURI 

    .EXTERNALMODULEDEPENDENCIES 

    .REQUIREDSCRIPTS 

    .EXTERNALSCRIPTDEPENDENCIES 

    .RELEASENOTES


    .PRIVATEDATA 

    #>

	<# 

	.SYNOPSIS 
      This is (was) a quick hack replacement for NSLOOKUP to check mutiple DNS Servers at one time.
      
	.DESCRIPTION 
      Quick DNS pull from your choice of DNS Servers
      
	.PARAMETER Name
      The site or address you are looking up.
      Wrap the URL or IP Address in quotes for mupliple sites.
      Can also use "CN","ComputerName", and "URL"

	.PARAMETER Server
      The DNS server(s) you want to query (limit 5)
      One server can put inputed without quotes
      Mutiple servers need to be wraped in quotes

    .PARAMETER CloudFlair
      Select to use the CloudFlair DNS Servers
      1.1.1.1     1dot1dot1dot1.cloudflare-dns.com
      1.0.0.1     1dot1dot1dot1.cloudflare-dns.com

    .PARAMETER Google
      Select to use the Google DNS Servers
      8.8.8.8     google-public-dns-a.google.com
      8.8.4.4     google-public-dns-b.google.com

    .PARAMETER Quad9
      Select to use the Quad9 DNS Server
      9.9.9.9     dns.quad9.net 
      
    .PARAMETER OpenDNS
      Select to use the OpenDNS DNS Servers
      208.67.222.222   resolver1.opendns.com
      208.67.220.220   resolver2.opendns.com

    .PARAMETER Level3
      Select to use the Level3 DNS Servers
      4.2.2.1   a.resolvers.level3.net
      4.2.2.2   b.resolvers.Level3.net
      4.2.2.3   c.resolvers.level3.net
      4.2.2.4   d.resolvers.level3.net
      4.2.2.5   e.resolvers.level3.net
      4.2.2.6   f.resolvers.level3.net

    .PARAMETER Symantec
      Select to use the Symantec DNS Servers
      199.85.126.10
      199.85.127.10

    .PARAMETER Comodo
      Select to use the Comodo DNS Servers
      8.26.56.26    ns1.recursive.dnsbycomodo.com
      8.20.247.20   ns2.recursive.dnsbycomodo.com

    .PARAMETER ihgip
      Select to use the ihgip DNS Servers
      84.200.69.80  resolver1.ihgip.net
      84.200.70.40  resolver2.ihgip.net

    .PARAMETER AllSvrs
      Uses to use all of the above servers

	.NOTES
	  Version:        2.0.0.0
	  Author:         Henry Rice
	  Creation Date:  01 Nov 2017
	  Purpose/Change: 
			  v1.0:   Initial script development
			  v1.0.1: Changed function Name to match standard convention
				  Replaced Write-Host with Write-Output
				  Added more default Servers: quad9.net, OpenDNS, Level3.net, Symantec, DNSbyComodo.com, ihgip.net
              v2.0:   Complete rewrite: 
                  Output is now a PS-Object! (need to fix the order the objects are outputed)
                  Split the included DNS server into seprate paramters due to paramter limit argument limit of 5 items. (Need to clean this up)
                  Moved the loops around so make it actully work correctly. (It's all about work flow)
                  Added some debug outputs to track whats going on. (Where did it break this time?)
	  
	.EXAMPLE
	  Get-DNS -Name Google.com -Server 8.8.8.8
	  Using both the Name with a URL and Server Parameters
	.EXAMPLE
	  Get-DNS -Name 1.1.1.1 -Server 8.8.8.8
	  Using both the Name with an IP Address and Server Parameters
	.EXAMPLE
	  Get-DNS google.com -CloudFlair -Google
      Useing one or more of the DNS Server Flags
    .EXAMPLE
      Get-DNS -Server "1.1.1.1","8.8.8.8" -Name "www.google.com","www.yahoo.com"
      Using two dns servers and URLs

	#> 
	
#region Parameters
    [CmdletBinding()]
	param (
        [parameter(mandatory=$true)]
        [Alias("cn","ComputerName","URL")]
        [string[]]$Name,
        [parameter(mandatory=$false)]
        [string[]]$Server,
		[Parameter()]
        [switch] $CloudFlair=$false,
		[Parameter()]
        [switch] $Google=$false,
		[Parameter()]
        [switch] $Quad9=$false,
		[Parameter()]
        [switch] $OpenDNS=$false,
		[Parameter()]
        [switch] $Level3=$false,
		[Parameter()]
        [switch] $Symantec=$false,
		[Parameter()]
        [switch] $Comodo=$false,
		[Parameter()]
        [switch] $ihgip=$false,
		[Parameter()]
        [switch] $AllSvrs=$false
	)
#endregion
#region Server Flags
        Write-Debug "Check Default Server Flags"
    if ($Server -ne ""){$Servers = $Server}
    if ($CloudFlair){$Servers = $Servers + @("1.1.1.1","1.0.0.1") }
    if ($Google){$Servers = $Servers + @("8.8.8.8", "8.8.4.4")}
    if ($Quad9){$Servers = $Servers + @("9.9.9.9")}
    if ($OpenDNS){$Servers = $Servers + @("208.67.222.222","208.67.220.220")}
    if ($Level3){$Servers = $Servers + @("4.2.2.1","4.2.2.2","4.2.2.3","4.2.2.4","4.2.2.5","4.2.2.6")}
    if ($Symantec){$Servers = $Servers + @("199.85.126.10","199.85.127.10")}
    if ($Comodo){$Servers = $Servers + @("8.26.56.26","8.20.247.20")}
    if ($ihgip){$Servers = $Servers + @("84.200.69.80","84.200.70.40")}
    if ($AllSvrs){
                Remove-Variable Servers
                $Servers = $Server + @( "1.1.1.1",			#CloudFlair
			                            "1.0.0.1",			#CloudFlair
			                            "8.8.8.8", 			#Google
			                            "8.8.4.4", 			#Google
			                            "9.9.9.9", 		    #Quad9
			                            "208.67.222.222", 	#OpenDNS
			                            "208.67.220.220", 	#OpenDNS
			                            "4.2.2.1", 			#Level3
			                            "4.2.2.2", 			#Level3
			                            "4.2.2.3", 			#Level3
			                            "4.2.2.4", 			#Level3
			                            "4.2.2.5", 			#Level3
			                            "4.2.2.6", 			#Level3
			                            "199.85.126.10", 	#Symantec
			                            "199.85.127.10", 	#Symantec
			                            "8.26.56.26", 		#DNSbyComodo.com
			                            "8.20.247.20", 		#DNSbyComodo.com
			                            "84.200.69.80", 	#ihgip.net
			                            "84.200.70.40"		#ihgip.net 
                                        )
        }
           
    if($Servers -eq $null){
        Write-Debug "`$Servers is blank"
        Write-Error "At least DNS Server Must be Identified"
        Break
    }
#endregion    
#region Main Code
    foreach ($nm in $name){
        foreach ($svr in $Servers){
            try{
                    Write-Debug "Resolve Server Hostname: $svr"
                $DNS_Svr_Hostname = (Resolve-DnsName -Name $svr -Server $svr -ErrorAction SilentlyContinue -ErrorVariable Svr_err).NameHost
                if ($Svr_err -ne "") {$DNS_Svr_Hostname = "Error"}
                    Write-Debug "$svr Resolved to: $DNS_Svr_Hostname"
    
                    Write-Debug "Resolveing $nm"
                $results = Resolve-DnsName -Server $Server -DnsOnly -NoHostsFile -ErrorAction stop -ErrorVariable err -Name $nm   #$resolvParams
                   
                    Write-Debug "Everything that is going in the item properties:
                    ServerName: $DNS_Svr_Hostname
                    ServerIP: $svr
                    Query: $nm
                    ResolveHostName: $results.NameHost
                    ResolveIPAddress: $results.IPAddress"

                $properties = [ordered]@{
                    DNSServerHostName =  $DNS_Svr_Hostname
                    DNSServerIPAddress = $svr
                    Query = $nm
                    ResolveHostName = $results.NameHost
                    ResolveIPAddress = $results.IPAddress
                }
            }
            catch{
				$properties = [ordered]@{
					DNSServerHostName = $DNS_Svr_Hostname
                    DNSServerIPAddress = $svr
                    Query = $nm
                    ResolveHostName = "Error"
                    ResolveIPAddress = "Error"
				}
                    Write-Debug "$properties.DNSServerHostName
                $properties.DNSServerIPAddress
                $properties.Query
                $properties.ResolveHostName
                $properties.ResolveIPAddress"
            }
            finally {

                    Write-Debug "Buiding the new PSPbject"               
                $obj = New-Object -TypeName PSObject -Property $properties

                    Write-Debug "The Results of the new object"
                Write-Output $obj 
   
            }
        } 
    }
 Write-Debug "End of Tool"
#endregion 
}
New-Alias whois Get-DNS

Function Test-Hash {
	<#
	.SYNOPSIS 
      Compare two files hash values.  Returns True/False

	.DESCRIPTION 
	  Compare two files hash values.  Returns True/False

	.NOTES
	  Version:        1.0.0.0
	  Author:         Henry Rice
	  Creation Date:  06 Mar 2018
	  Purpose/Change: Initial script development

	.EXAMPLE
	  Test-Hash -File1 .\TestFile1.txt -File2 .\TestFile2.txt
	  False
	.EXAMPLE
	  Test-Hash .\TestFile1.txt .\TestFile2.txt
	  True
	 
	 
	#>
    [CmdletBinding()]
	param (
        [Parameter(Mandatory=$true, Position=0, HelpMessage="Identify the first file you wish to compare")]
        [ValidateScript({Test-Path -IsValid $_ })] 
		[String[]]$File1,
        [Parameter(Mandatory=$true, Position=1, HelpMessage="Identify the second file you wish to compare")]
		[ValidateScript({Test-Path -IsValid $_ })] 
        [String[]]$File2
    )
	
    (Get-FileHash $File1).hash -eq (Get-FileHash $File2).hash

}
New-Alias Get-Hash Get-FileHash
New-Alias Hash Get-FileHash

Function Search-File {
<#PSScriptInfo

.VERSION 1.0

.GUID 46ce9ab2-c2e2-4d57-9c59-875563b6133b

.AUTHOR 1168414184A

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


#>

<# 

.DESCRIPTION 
 Like Grep...but not

#> 
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, HelpMessage="Input search string here")]
		[alias("s")]
        [String] $String,
		[Parameter(Mandatory = $true, HelpMessage="Input the file you want to search here:")]
        [alias("f")]
		[String] $File,
		[Parameter(Mandatory = $false, HelpMessage="Exclude document info in output")]
		[alias("e")]
		[switch] $NoLine = $false
	)

    Write-Debug "String = $String"
    Write-Debug "File = $File"
    Write-Debug "NoLine = $NoLine"

	if ($NoLine){
        Write-Debug "NoLine Flag set to True"
		select-string -pattern $String -path $file | select -exp line 
	}else{
	    Write-Debug "NoLine Flag set to False"	
        select-string -pattern $String -path $file 
	}
}
New-Alias grep Search-File