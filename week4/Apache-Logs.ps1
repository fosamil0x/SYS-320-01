<# 
Function: Get IPs for page visits

Inputs:  1. Page to visit
         2. HTTP Code returned
         3. Web Browser name

Outputs: 1. IP's that match that criteria
#>

function getIPForPageVisit($page, $http, $browser){

#Get content from the access.log file
$content = Get-Content C:\xampp\apache\logs\access.log 

#Specify what content you want with $page, $http, and $browser
$specify = $content | Where-Object { $_ -match $page -and $_ -match $http -and $_ -match $browser }
$specify

# Use code from earlier to get necessary IP information from the $specify variable
# Regex to get IP Addrs
$regex = [regex] "\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"

# Get $specify records that meet regex requirements
$unorganizedips = $regex.Matches($specify)

# Get ips as a pscustom object
$ips = @()
for($i=0; $i -lt $unorganizedips.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $unorganizedips[$i].Value; }
}
# Store IPs in the 10.x.x.x network (this system and the ubuntu system)
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }

# Count the amount of times each of those IPs occur in the logs
$counts = $ipsoftens | Group-Object IP

# Store output in a variable to return
$output = $counts | Select-Object Count, Name

return $output
}
