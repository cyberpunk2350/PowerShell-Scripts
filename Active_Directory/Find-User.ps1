Function Find-User {
	[CmdletBinding()]
	param (
	[Parameter(Mandatory = $false, HelpMessage="Enter User Name to find:")]
	[alias("UN")]
	[String] $UserName = $null,
	[Switch] $Name = $false,
	[String] $email = $null,
	[String] $DisplayName = $null,
	[String] $City = $null,
	[Parameter]
	[alias("Org")]
	[String] $Organization = $null
	)
	$dom = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
	$root = $dom.GetDirectoryEntry()
	$search = [System.DirectoryServices.DirectorySearcher]$root
	$Filter = "(&(objectclass=user)(objectcategory=person)"
	if($DisplayName -ne ""){$Filter = "$Filter(displayname=$DisplayName)"}
	if ($email -ne ""){$Filter = "$Filter(mail=$email)"}
	if ($UserName -ne ""){$Filter = "$Filter(samAccountName=$username)"}
	if ($Unit -ne ""){$Filter = "$Filter(o=$Organization)"}
	if ($Base -ne ""){$Filter = "$Filter(l=$City)"}
	$Filter = "$Filter)"
	$search.Filter = $Filter
	$result = $search.FindAll()
	if ($Name) {
		$result.Properties.displayname
	}else{
		$result
	}
}
