(Join-Path $PSScriptRoot gatherClasses.ps1)
(Join-Path $PSScriptRoot daysTranslator.ps1)
clear

#Call functions
$FullTable = gatherClasses
$FullTable = daysTranslator -FullTable $FullTable

# List all classes from Furkan
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | Where-Object {$_."Instructor" -ilike "*Paligu"}