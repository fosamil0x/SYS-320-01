<#
Function: getPowerstateLogs w/ Input
Input: days (number of days for taking in logs)
Output: powerstateTable (only for logs within the amount of inputed days)
#>

function getPowerLogs($powerDays){
$powerstate = Get-EventLog System -After (Get-Date).AddDays(-$powerDays)| Where-Object {$_.EventID -in 6005,6006}
#$powerstate

$powerstateTable =@()
for ($i=0; $i -lt $powerstate.Count; $i++){

$event = ""
if($powerstate[$i].EventId -eq 6005) {$event = "Startup"}
if($powerstate[$i].EventId -eq 6006) {$event = "Shutdown"}

$user = $powerstate[$i].ReplacementStrings[1]

$powerstateTable += [pscustomobject]@{"Time" = $powerstate[$i].TimeGenerated; `
                                      "Id" = $powerstate[$i].EventID; `
                                      "Event" = $event; `
                                      "User" = "System";
                                      }
}

return $powerstateTable

}

$powerLogs = getPowerLogs -powerDays 20
$powerLogs