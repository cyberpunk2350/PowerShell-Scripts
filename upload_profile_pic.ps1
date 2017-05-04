# input user name
$username = "xxxx" 
# absolute path to location of image
$jpgfile = "C:\xxxx.jpg"
$dom = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$root = $dom.GetDirectoryEntry()
$search = [System.DirectoryServices.DirectorySearcher]$root
$search.Filter = "(&(objectclass=user)(objectcategory=person)(samAccountName=$username))"
$result = $search.FindOne()

if ($result -ne $null)
{
 $user = $result.GetDirectoryEntry()
 [byte[]]$jpg = Get-Content $jpgfile -encoding byte
 $user.put("thumbnailPhoto",  $jpg )
 $user.setinfo()
 Write-Host $user.displayname " updated"
}
else {Write-Host $struser " Does not exist"}

