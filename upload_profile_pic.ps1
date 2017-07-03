# Maunally input user name
#$username = "xxxx"

# Pulls username from the enviromental variable
$username = $env:UserName


# absolute path to location of image
#$jpgfile = "xxxx"


# Opens file select dialog box for the JPEG
$jpgfile = Get-OpenFile

# Pushes the selcted file to the account of the curent user
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

# This is the function to open the file select dialog box
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
