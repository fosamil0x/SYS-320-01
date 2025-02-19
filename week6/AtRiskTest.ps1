$Days = 10
$StartDate = (Get-Date).AddDays(-$Days)

Get-EventLog Security -After $StartDate |
    Where-Object {$_.EventID -eq 4625} |
    Group-Object {$_.ReplacementStrings[5]} |
    Where-Object {$_.Count -gt 10} |
    Select-Object @{N='User';E={$_.Name}}, @{N='FailedLogins';E={$_.Count}} |
    Sort-Object FailedLogins -Descending |
    Format-Table -AutoSize