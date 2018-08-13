Function Get-FileDialog{ 
    [CmdletBinding()]
    param(
		[ValidateSet("Open","Save")]
        [String]$Dialog,
        [string]$initialDirectory, 
		[string]$Title,
		[string]$filter = "All files (*.*)| *.*"  #"CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
    )
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    if ($Dialog -eq "Open"){$FileDialog = New-Object System.Windows.Forms.SaveFileDialog}
    elesif ($Dialog -eq "Save"){$FileDialog = New-Object System.Windows.Forms.OpenFileDialog}
    else { throw "Something Went Wrong"}
    
    $FileDialog.Title = $Title
	$FileDialog.initialDirectory = $initialDirectory
	$FileDialog.filter = $filter
	$FileDialog.ShowDialog() | Out-Null
	$FileDialog.filename
	$FileDialog.ShowHelp = $true
}
