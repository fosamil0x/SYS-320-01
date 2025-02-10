# Get logs for 404 errors in $notfound
$notfound = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

# Regex to get IP Addrs
$regex = [regex] "\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"

#get $notfound records that meet regex requirements
$unorganizedips = $regex.Matches($notfound)

#get ips as a pscustom object
$ips = @()
for($i=0; $i -lt $unorganizedips.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $unorganizedips[$i].Value; }
}
# Store IPs in the 10.x.x.x network (this system and the ubuntu system)
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }

# Count the amount of times each of those IPs occur in the logs
$counts = $ipsoftens | Group-Object IP
$counts | Select-Object Count, Name