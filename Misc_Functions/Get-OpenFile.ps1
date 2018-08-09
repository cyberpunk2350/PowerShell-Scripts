Function Get-OpenFile{
    param(
    [string]$initialDirectory, 
    [string]$Title,
    [string]$filter
    )
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Title = $Title
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = $filter   # EXAMPLE: "JPEG files (*.jpg)|*.jpg"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
    $OpenFileDialog.ShowHelp = $true
}
