(Join-Path $PSScriptRoot gatherClasses.ps1)
(Join-Path $PSScriptRoot daysTranslator.ps1)
clear

#Call functions
$FullTable = gatherClasses
$FullTable = daysTranslator -FullTable $FullTable

#Define ITS Instructors
$ITSInstructors = $FullTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or 
                                              ($_."Class Code" -ilike "NET*") -or 
                                              ($_."Class Code" -ilike "SEC*") -or
                                              ($_."Class Code" -ilike "FOR*") -or
                                              ($_."Class Code" -ilike "CSI*") -or
                                              ($_."Class Code" -ilike "DAT*")}

# Group the ITS instructors by the number of classes they teach. Sort by number of classes they teach
$FullTable | Where { $_.Instructor -in $ITSInstructors.Instructor } | Group-Object "Instructor" | Select Count,Name | Sort-Object Count -Descending