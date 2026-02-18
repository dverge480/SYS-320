


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

#-------------------------------------------------------------------------------------------------
# Create a function called checkPassword in String-Helper that:
#              - Checks if the given string is at least 6 characters
#              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
#              - If the given string does not satisfy conditions, returns false
#              - If the given string satisfy the conditions, returns true
# Check the given password with your new function. 
#              - If false is returned, do not continue and inform the user
#              - If true is returned, continue with the rest of the function
#---------------------------------------------------------------------------------------------------

function checkPassword($password){

    # Convert SecureString to Plain Text for Validation
    $plainPassword = [System.Net.NetworkCredential]::new("", $password).Password

    #check all requirements using regex 
    #6 characters, AND letter AND number AND special character
    if($plainPassword.Length -ge 6 -and 
       $plainPassword -match "[a-zA-Z]" -and
       $plainPassword -match "[0-9]" -and
       $plainPassword -match "[^a-zA-Z0-9]"){
       return $true
    }
    return $false
}




 