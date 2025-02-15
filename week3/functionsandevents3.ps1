﻿$loginouts = Get-EventLog -LogName System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
#$loginouts

$loginoutsTable =@()
for ($i=0; $i -lt $loginouts.Count; $i++){

$event =""
if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]

$sid = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
$user = $sid.Translate([System.Security.Principal.NTAccount]).Value


$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                     "Id" = $loginouts[$i].InstanceId; `
                                     "Event" = $event; `
                                     "User" = $user; `
                                     }
}

$loginoutsTable
write-host $loginoutsTable | Out-String