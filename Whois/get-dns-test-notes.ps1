
$Name = ("google.com", "henryrice.net")
#$Server = ("8.8.8.8", "8.8.4.4", "9.9.9.9" , "208.67.222.222", "208.67.220.220", "4.2.2.1", "4.2.2.2", "199.85.126.10", "199.85.127.10", "8.26.56.26", "8.20.247.20", "84.200.69.80", "84.200.70.40")
$Server = ("8.8.8.8", "8.8.4.4")

function test {
	foreach ($svr in $Server){
	#    $SvrName = (Resolve-DnsName -Name $svr -Server $svr).NameHost
	#    $SvrIP = (Resolve-DnsName -Name (Resolve-DnsName -Name $svr -Server $svr).NameHost -Server $svr).ipaddress
		 $SvrName = (Resolve-DnsName -Name $svr -Server $svr).NameHost
		 $SvrIP = (Resolve-DnsName -Name (Resolve-DnsName -Name $svr -Server $svr).NameHost -Server $svr).ipaddress

		foreach ($nm in $Name){
			$results = Resolve-DnsName -Name $nm -Server $Server
			[PSCustomObject]@{
				NameServerIP = $SvrIP
				ResultsURI = $results.name
				ResultsIP = $results.IPAddress

			}

		}
	}
}

<#
Output
NameServerIP                    ResultsURI               ResultsIP
------------                    ----------               ---------
{2001:4860:4860::8888, 8.8.8.8} {google.com, google.com} {2607:f8b0:4004:806::200e, 172.217.9.206}
{2001:4860:4860::8888, 8.8.8.8} henryrice.net            66.33.213.96
{2001:4860:4860::8844, 8.8.4.4} {google.com, google.com} {2607:f8b0:4004:806::200e, 172.217.9.206}
{2001:4860:4860::8844, 8.8.4.4} henryrice.net            66.33.213.96


#>

#Works
$svr = "8.8.8.8"
(Resolve-DnsName -Name $svr -Server $svr).NameHost
(Resolve-DnsName -Name (Resolve-DnsName -Name $svr -Server $svr).NameHost -Server $svr).ipaddress
Remove-Variable svr

#dosnt
$svr = "google-public-dns-a.google.com"
(Resolve-DnsName -Name $svr -Server $svr).ipaddress
(Resolve-DnsName -Name (Resolve-DnsName -Name $svr -Server $svr).ipaddress -Server $svr).Name
Remove-Variable svr




# Resolve-DnsName -Server (Resolve-DnsName -Name 8.8.8.8 -Server 8.8.4.4).NameHost -Name henryrice.net

<#



    foreach ($svr in $Server){
    
        try{
            $dns = (Resolve-DnsName -Name $svr -Server $svr -ErrorAction Stop).namehost 
        } catch {
            $dns = ""
        }
        $whois.NameServer = $dns
		$whois.NameServerIP = $svr 
	
        foreach ($nm in $name){
            try { 
                $results = Resolve-DnsName -Name $nm -Server $svr -ErrorAction Stop 
                
            } catch {
                write-error "Exception Message: $($_.Exception.Message)" 
            }
        $whois.ResolveName = $results.name
        $whois.ResolveIP = $results.IPAddress
        }
      #  Write-host " "
    }
#>

<#
$Path = "~\OneDrive\Documents\WindowsPowerShell"
$Directory = Get-Acl -Path $Path

ForEach ($Dir in $Directory.Access){
    [PSCustomObject]@{
    Path = $Path
    Owner = $Directory.Owner
    Group = $Dir.IdentityReference
    AccessType = $Dir.AccessControlType
    Rights = $Dir.FileSystemRights
    }#EndPSCustomObject
}#EndForEach
#>