# Construct the path to .ps1's as needed
$apacheLogsScriptPath = Join-Path -Path $PSScriptRoot\..\week4 -ChildPath "ApacheLogs1.ps1"
$chromeRunScriptPath = Join-Path -Path $PSScriptRoot\..\week2 -ChildPath "champlainchromecheck.ps1"


# Load the .ps1's
. $apacheLogsScriptPath
. (Join-Path $PSScriptRoot Event-Logs.ps1)


clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display Last 10 Apache Logs`n"
$Prompt += "2 - Display Last 10 Failed Logins`n"
$Prompt += "3 - Display At Risk Users`n"
$Prompt += "4 - Start Chrome and go to champlain.edu if no instances exist`n"
$Prompt += "5 - Exit`n"


$choices = @(1, 2, 3, 4, 5)


$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 
# everything goes in this if statement. This ensure's that one of the options is selected.
if ($choices -contains $choice){
    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false
    }
    elseif($choice -eq 1){
        # call the function for ApacheLogs1 and select last 10 logs
        $output = ApacheLogs1 | Select-Object -Last 10
        # format the table
        $output | Format-Table -AutoSize
    }
    elseif($choice -eq 2){
        # call the function for failed logins and select last 10
        $output = getFailedLoginsMenu | Select-Object -Last 10
        # format the table
        $output | Format-Table -AutoSize
    }
    elseif($choice -eq 3){
        # call the function for at risk users
        $days = Read-Host -Prompt "How many days back do you want to go for 10 failed logins"
        $output = getAtRisk($days)
        # format the table
        $output | Format-Table -AutoSize
    }
    elseif($choice -eq 4){
        # run the chrome script
        . $chromeRunScriptPath

}
else{
Write-Host "Invalid choice. Please select one of the operations." | Out-String
}

}
}