# input user name
#$username = "xxxx" 
$username = $env:UserName
# absolute path to location of image
#$jpgfile = "xxxx"
$jpgfile = Get-OpenFile
$dom = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$root = $dom.GetDirectoryEntry()
$search = [System.DirectoryServices.DirectorySearcher]
$root$search.Filter = "(&(objectclass=user)(objectcategory=person)(samAccountName=$username))"
$result = $search.FindOne()
if ($result -ne $null)
{
 $user = $result.GetDirectoryEntry() 
 [byte[]]$jpg = Get-Content $jpgfile -encoding byte 
 $user.put("thumbnailPhoto",  $jpg ) 
 $user.setinfo() 
 Write-Host $user.displayname " updated"
}
else 
{
Write-Host $struser " Does not exist"
}

Function Get-OpenFile($initialDirectory)
{
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "JPEG files (*.jpg)|*.jpg"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
 $OpenFileDialog.ShowHelp = $true
}
