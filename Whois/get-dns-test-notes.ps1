
$Name = ("google.com", "henryrice.net")
#$Server = ("8.8.8.8", "8.8.4.4", "9.9.9.9" , "208.67.222.222", "208.67.220.220", "4.2.2.1", "4.2.2.2", "199.85.126.10", "199.85.127.10", "8.26.56.26", "8.20.247.20", "84.200.69.80", "84.200.70.40")
$Server = ("8.8.8.8", "8.8.4.4")

foreach ($svr in $Server){
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