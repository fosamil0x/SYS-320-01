(Join-Path $PSScriptRoot gatherClasses.ps1)
(Join-Path $PSScriptRoot daysTranslator.ps1)
clear

#Call functions
$FullTable = gatherClasses
$FullTable = daysTranslator -FullTable $FullTable

# List the Class Code and Times of classes from JOYC 310 on Mondays
$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.days -ilike "Monday") } | Select-Object "Time Start", "Time End", "Class Code"