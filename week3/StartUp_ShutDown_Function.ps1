# Function to get computer startup and shutdown events
function Get-StartupShutdownEvents {
    param(
        [int]$Days  # Input parameter: number of days to look back
    )
    
    # Get startup and shutdown records from Windows Events
    $events = Get-EventLog system -After (Get-Date).AddDays(-$Days) | Where-Object { $_.EventId -eq 6005 -or $_.EventId -eq 6006 }
    
    # Check if any events were found before looping
    if ($events) {
        $eventsTable = @() # Empty Array to fill customly
        for ($i=0; $i -lt $events.Count; $i++) {
            # Creating event property value based on EventId
            $event = ""
            if ($events[$i].EventId -eq "6005") { $event="Startup" }
            if ($events[$i].EventId -eq "6006") { $event="Shutdown" }
            
            # Adding each new line (in form of a custom object) to our empty array
            $eventsTable += [pscustomobject]@{
                "Time"  = $events[$i].TimeGenerated; `
                "Id"    = $events[$i].EventId; `
                "Event" = $event; `
                "User"  = "System";
            }
        } # End of for loop
        
        return $eventsTable  # Return the results
    }
    else {
        Write-Host "No startup/shutdown events found in the last $Days days."
        return $null
    }
}

# Call the function with 30 days as the parameter and print results
$startupShutdownResults = Get-StartupShutdownEvents -Days 30
$startupShutdownResults