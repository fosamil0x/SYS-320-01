<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

<# ******************************************************
   Functions: checkPassword
   Input:   1) $password
   Output:  1) $password (if it meets certain criteria
********************************************************* #>

function checkPassword($myPass){


# Convert from secure string
$btsr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($myPass)
$unsecureString = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($btsr)


$minimum = 6
$upper = $unsecureString -match "[A-Z]"
$lower = $unsecureString -match "[a-z]"
$numbers = $unsecureString -match "[0-9]"
$specials = $unsecureString -match "[^a-zA-Z0-9]"

if($unsecureString.Length -ge $minimum){ Write-Host "Passed length" | Out-String
    if($upper){ Write-Host "Passed upper" | Out-String
        if($lower){ Write-Host "Passed lower" | Out-String
            if($numbers){ Write-Host "Passed numbers" | Out-String
                if($specials){ Write-Host "Passed specials" | Out-String
                    $resecureString = ConvertTo-SecureString $unsecureString -AsPlainText -Force
                    Write-Host $resecureString | Out-String
                    return $true
                }
             }
         }
     }
# close if statements

else{
    Write-host "Password Failed."
    return $false}
} # close else

} # close function