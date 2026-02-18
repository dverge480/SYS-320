# Start﻿
. C:/Users/champuser/SYS-320/week6/Users.ps1
. C:/Users/champuser/SYS-320/week6/Event-Logs.ps1
. C:/Users/champuser/SYS-320/week6/String-Helper.ps1

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
$Prompt += "9 - List at Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "See ya later alligator!" | Out-String
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

        $name = Read-Host -Prompt "Please enter the username for the new user"

        #check if user already exists
        if(checkUser $name){
            Write-Host "User $name already exists. Please pick a different username." | Out-String
            continue
         }
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        #Check Password complexity
        if(-not (checkPassword $password)){
            Write-Host "Password does not meet requirements. Must be at leaset 6 characters long, contain 1 letter, 1 number, and 1 special character"
            continue
        }

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # check if user exists
        if(-not (checkUser $name)){
            Write-Host "User $name does not exist." | Out-String
            continue
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # Check if user already exists

        if(-not (checkUser $name)){
            Write-Host "User $name does not exist." | Out-String
            continue
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        #Check if user exists 
        if(-not (checkUser $name)){
            Write-Host "User $name does not exist" | Out-String
            continue
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # Check if user exists 
        if(-not (checkUser $name)){
            Write-Host "User $name does not exist" | Out-String
            continue
        }

        $days = Read-Host -Prompt "Please enter the number of days to serach back"
        
        $userLogins = getLogInAndOffs $days #days is given by the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # Check if user exists 
        if(-not (checkUser $name)){
            Write-Host "User $name does not exist" | Out-String
            continue
        }

        $days = Read-Host -Prompt "Please enter the number of days to serach back"

        $userLogins = getFailedLogins $days #days is given by the user
        

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


# List at Risk Users 

 elseif($choice -eq 9){
        
        # Get days from user
        $days = Read-Host -Prompt "Please enter the number of days to search back"
        
        # Get all failed logins
        $failedLogins = getFailedLogins $days
        
        # Group by user and count failed attempts
        $atRiskUsers = $failedLogins | Group-Object -Property User | Where-Object { $_.Count -gt 10 }
        
        if($atRiskUsers.Count -eq 0){
            Write-Host "No at-risk users found (users with more than 10 failed logins)." | Out-String
        }
        else{
            Write-Host "`nAt-Risk Users (More than 10 failed logins in the last $days days):" | Out-String
            
            $atRiskTable = @()
            foreach($user in $atRiskUsers){
                $atRiskTable += [pscustomobject]@{
                    "User" = $user.Name
                    "Failed Login Count" = $user.Count
                }
            }
            
            Write-Host ($atRiskTable | Format-Table | Out-String)
        }
    }


    # Invalid choice
    else{
        Write-Host "Invalid choice. Please select a number between 1 and 10." | Out-String
    }

}