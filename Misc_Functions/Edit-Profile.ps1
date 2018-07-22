function Edit-Profile {
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