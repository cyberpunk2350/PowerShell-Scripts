<#PSScriptInfo
.VERSION 1.0
.GUID 6e2d5345-7f63-4df7-b0e5-0253c62b0c86
.AUTHOR Henry Rice
.COMPANYNAME 
.COPYRIGHT 
.TAGS 
.LICENSEURI 
.PROJECTURI 
.ICONURI 
.EXTERNALMODULEDEPENDENCIES 
.REQUIREDSCRIPTS 
.EXTERNALSCRIPTDEPENDENCIES 
.RELEASENOTES
.PRIVATEDATA 
#>

<# 
.DESCRIPTION 
  Quick Hack to compare two files SHA256 hash values.  Returns True if they match and False if they don't 
#> 

Function Test-Hash {
	<#
	.SYNOPSIS 
	  Quick Hack to compare two files SHA256 hash values.  Returns True/False

	.DESCRIPTION 
	  Compare two files SHA256 hash values.  Returns True if they match and False if they don'the
	
	.ToDo
	  Add ability to check other hash algorithms

	.NOTES
	  Version:        1.0.0.0
	  Author:         Henry Rice
	  Creation Date:  06 Mar 2018
	  Purpose/Change: Initial script development

	.EXAMPLE
	  Test-Hash -File1 .\TestFile1.txt -File2 .\TestFile2.txt
	  False
	.EXAMPLE
	  Test-Hash .\TestFile1.txt .\TestFile2.txt
	  True
	#>
    [CmdletBinding()]
	param (
        [Parameter(Mandatory=$true, Position=0, HelpMessage="Identify the first file you wish to compare")]
        [ValidateScript({Test-Path -IsValid $_ })] 
		[String[]]$File1,
        [Parameter(Mandatory=$true, Position=1, HelpMessage="Identify the second file you wish to compare")]
		[ValidateScript({Test-Path -IsValid $_ })] 
        [String[]]$File2
    )
	
    (Get-FileHash $File1).hash -eq (Get-FileHash $File2).hash

}
New-Alias Get-Hash Get-FileHash
New-Alias Hash Get-FileHash
