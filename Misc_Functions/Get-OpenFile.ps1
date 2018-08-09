Function Get-SaveFile{ 
    param(
		[string]$initialDirectory, 
		[string]$Title = "Save As",
		[string]$filter = "All files (*.*)| *.*"
    )
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

	$SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
	$SaveFileDialog.Title = $Title
	$SaveFileDialog.initialDirectory = $initialDirectory
	$SaveFileDialog.filter = $filter
	$SaveFileDialog.ShowDialog() | Out-Null
	$SaveFileDialog.filename
	$SaveFileDialog.ShowHelp = $true
}
