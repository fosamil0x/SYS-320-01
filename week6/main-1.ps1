. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Get At-Risk Users`n"
$Prompt += "10 - Exit`n"

$choices = @(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)


$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

if ($choices -contains $choice){
    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 
        # TODO: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        $name = Read-Host -Prompt "Please enter the username for the new user"
        #Write-Host $name
        $checkUser = checkUser $name
        Write-host $checkUser
        if ($checkUser -eq $false){
           Write-Host "User does not yet exist. Continuing..." | Out-String
           $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
           
           
           $checkPassword = checkPassword $password
           if ($checkPassword -eq $true){
                #use functions to create a user. Write message to host
                createAUser $name $password
                Write-Host "User: $name is created." | Out-String
                }
            }

        if($checkUser -eq $true){
            Write-Host "Create User Failed. Use a unique username and a password that meets the requirements. Exiting..."}

        # TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function
            
    }



    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.
        $checkUser = checkUser $name
        if ($checkUser -eq $true){
            Write-Host "User found. Deleting..." | Out-String
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else{
            Write-Host "No user found. Exiting..."
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        $checkUser = checkUser $name
        if($checkUser -eq $true){
            Write-Host "User found. Enabling..." | Out-String
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else{
        Write-Host "No user found. Exiting..."
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.

        $checkUser = checkUser $name
        if($checkUser -eq $true){
            Write-Host "User Found. Disabling..."
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else{
            Write-Host "User not found. Exiting..."
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
        $checkUser = checkUser $name
        if ($checkUser -eq $true){
            $days = Read-Host -Prompt "User Found. Please provide how many days you want to see for Log-In Logs"
            $userLogins = getLogInAndOffs $days
        # TODO: Change the above line in a way that, the days 90 should be taken from the user
        # I did this using $days and read-host. See line 147
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            Write-Host "User Not Found. Exiting..."
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.
        $checkUser = checkUser $name
        if($checkUser -eq $true){
            $days = Read-Host -Prompt "User Found. Please provide how many days you want to see for Failed Log-In Logs"
            $userLogins = getFailedLogins $days
        # TODO: Change the above line in a way that, the days 90 should be taken from the user
        # I used $days and read-host again. See line 165
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
        Write-Host "User not found. Exiting..."
        }
    }

    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    elseif($choice -eq 9){
        $days = Read-Host -Prompt "Provide a number of days to see more than 10 failed login attempts within"
        $atRisk = getAtRisk $days
        if($atRisk){
            Write-Host "At risk users found. See Below" | Out-String
            $atRisk | Format-Table -Autosize
        }
        else{
            Write-Host "No at risk users found. Exiting..."
        }
    
    }



    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    # See lines 19, 30, and 203-205 for how I handled this. I put the entire while loop in an if statement
    # to check if the choice made by the user is in a list of choices. If it is, it'll proceed with the loop.
    # If the choice is not in the list of choices, it tells the user the choice is invalid and asks them
    # to select one of the operations again.
}
else{
Write-Host "Invalid choice. Please select one of the operations." | Out-String
}

}
