(Join-Path $PSScriptRoot gatherClasses.ps1)
(Join-Path $PSScriptRoot daysTranslator.ps1)
clear

#Call functions
$FullTable = gatherClasses
$FullTable = daysTranslator -FullTable $FullTable

# List the ITS Instructors that teach at least one SYS, NET, SEC, FOR, CSI, or DAT Course. Sort by Name

$ITSInstructors = $FullTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or 
                                              ($_."Class Code" -ilike "NET*") -or 
                                              ($_."Class Code" -ilike "SEC*") -or
                                              ($_."Class Code" -ilike "FOR*") -or
                                              ($_."Class Code" -ilike "CSI*") -or
                                              ($_."Class Code" -ilike "DAT*")} | Select-Object "Instructor" | Sort-Object "Instructor" -Unique
$ITSInstructors
