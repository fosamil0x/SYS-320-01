<#
Function: EventLog w/ Input
Input: days (number of days for taking in logs)
Output: loginoutsTable (only for logs within the amount of inputed days)
#>

function getDaysForEventLog($days){
$loginouts = Get-EventLog -LogName System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)
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

return $loginoutsTable

}

$logsWithDays = getDaysForEventLog -days 20
$logsWithDays