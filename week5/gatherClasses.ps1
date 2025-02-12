function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

#get table row elements of the HTML doc
$trs=$page.ParsedHtml.body.getElementsByTagName("tr")


#make an empty array to hold results
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){#go over every table row
    
    #get every table column
    $tds = $trs[$i].getElementsByTagName("td")

    #seperate start time and end time from one field 
    $Times = $tds[5].innerText.Split("-")

    $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                    "Title"      = $tds[1].innerText; `
                                    "Days"       = $tds[4].innerText; `
                                    "Time Start" = $Times[0]; `
                                    "Time End"   = $Times[1]; `
                                    "Instructor" = $tds[6].innerText; `
                                    "Location" = $tds[9]. innerText; `
                                    }
}
return $FullTable
}
