(Join-Path $PSScriptRoot gatherClasses.ps1)

clear

function daysTranslator($FullTable){

#Go over the records from the table
for($i=0; $i -lt $FullTable.length; $i++){

    #empty array for days
    $Days = @()

    #Mondays
    if($FullTable[$i].Days -ilike "*M*"){ $Days += "Monday" }
    #Mondays with Thursdays
    if($FullTable[$i].Days -ilike "*M[TH]"){ $Days += "Monday" }

    #T with T, W or F is Tuesday
    if($FullTable[$i].Days -ilike "*T[WF]"){ $Days += "Tuesday" }
    #Just Tuesdays
    if($FullTable[$i].Days -ilike "T"){ $Days += "Tuesday" }

    #Wednesday
    if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }

    #Thursday
    if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }

    #Friday
    if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }
    
    #Make the switch
    $Fulltable[$i].Days = $Days
}
return $FullTable
}
