Function Get-FileDialog{ 
	[CmdletBinding()]
    	param(
		[Parameter(Mandatory=$true, HelpMessage="Select type of File Dialog you require")]
		[ValidateSet("Open","Save")]
		[String]$Dialog,
		[String]$InitialDirectory, 
		[String]$Title,
		[String]$FileName,
		[String]$Filter = "All files (*.*)| *.*"  #"CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
    	)
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    	if ($Dialog -eq "Save"){$FileDialog = New-Object System.Windows.Forms.SaveFileDialog}
    	elseif ($Dialog -eq "Open"){$FileDialog = New-Object System.Windows.Forms.OpenFileDialog}
    	else { throw "Something Went Wrong in Dialog Box Selection"; return}
    
	$FileDialog.Title = $Title
	$FileDialog.InitialDirectory = $InitialDirectory
	$FileDialog.Filter = $Filter
    	#$FileDialog.FileName.FileName.Insert(1,$FileName)
	$FileDialog.FileName.FileName
	$FileDialog.ShowDialog() 
	$FileDialog.ShowHelp = $true
}
