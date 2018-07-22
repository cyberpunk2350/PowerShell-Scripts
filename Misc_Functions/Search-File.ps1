function Search-File {
<#PSScriptInfo

.VERSION 1.0

.GUID 46ce9ab2-c2e2-4d57-9c59-875563b6133b

.AUTHOR 1168414184A

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


#>

<# 

.DESCRIPTION 
 . Like Grep...but not

#> 
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, HelpMessage="Input search string here")]
		[alias("s")]
        [String] $String,
		[Parameter(Mandatory = $true, HelpMessage="Input the file you want to search here:")]
        [alias("f")]
		[String] $File,
		[Parameter(Mandatory = $false, HelpMessage="Exclude document info in output")]
		[alias("e")]
		[switch] $NoLine = $false
	)

    Write-Debug "String = $String"
    Write-Debug "File = $File"
    Write-Debug "NoLine = $NoLine"

	if ($NoLine){
        Write-Debug "NoLine Flag set to True"
		select-string -pattern $String -path $file | select -exp line 
	}else{
	    Write-Debug "NoLine Flag set to False"	
        select-string -pattern $String -path $file 
	}
}
New-Alias grep Search-File