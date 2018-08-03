Function Set-ADProfilePic {

	[CmdletBinding()]
    Param(
        [String] $Username = $env:UserName,  # Pulls username from the enviromental variable if one is not included
        [String] $Picture = (Get-OpenFile),   # Opens file select dialog box for the JPEG if one is not included
        [Switch] $AdminOverRide
    )

    if(($Username -ne $env:UserName) -and (-not $AdminOverRide)) {
        Write-Error "Users can only set their own profile picture"
        break
    }elseif (($Username -ne $env:UserName) -and $AdminOverRide) {
        Write-Warning "Attempting to change the AD Profile Picture of a Diffrent User"
    }
    
    # Accesses selected user account from Active Directory
    $dom = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
    $root = $dom.GetDirectoryEntry()
    $search = [System.DirectoryServices.DirectorySearcher]$root
    $search.Filter = "(&(objectclass=user)(objectcategory=person)(samAccountName=$Username))"
    $result = $search.FindOne()
    if ($result -ne $null) # Pushes the selcted file to the account of the selected user
    {
        try{
        $user = $result.GetDirectoryEntry() 
        [byte[]]$jpg = Get-Content $Picture -encoding byte 
        $user.put("thumbnailPhoto",  $jpg ) 
        $user.setinfo() 
        Write-Output $user.displayname "Has been updated."
        }catch{
            
        }
        
    }
    else
    {
    Write-Output $struser " Does not exist"
    }

    # This is the function to open the file select dialog box
}

Function Get-OpenFile($initialDirectory) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
    Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "JPEG files (*.jpg)|*.jpg"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
    $OpenFileDialog.ShowHelp = $true
}
