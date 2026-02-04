 # Function 1: Login/Logoff Events
function Get-LoginEvents {
    param(
        [int]$Days
    )
    
    $loginouts = Get-EventLog system -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$Days)
    
    if ($loginouts) {
        $loginoutsTable = @()
        for ($i=0; $i -lt $loginouts.Count; $i++) {
            $event = ""
            if ($loginouts[$i].InstanceId -eq "7001") { $event="Logon" }
            if ($loginouts[$i].InstanceId -eq "7002") { $event="Logoff" }
            
            $sid = $loginouts[$i].ReplacementStrings[1]
            try {
                $user = (New-Object System.Security.Principal.SecurityIdentifier($sid)).Translate([System.Security.Principal.NTAccount]).Value
            }
            catch {
                $user = $sid
            }
            
            $loginoutsTable += [pscustomobject]@{
                "Time"  = $loginouts[$i].TimeGenerated; `
                "Id"    = $loginouts[$i].InstanceId; `
                "Event" = $event; `
                "User"  = $user;
            }
        }
        return $loginoutsTable
    }
    else {
        Write-Host "No Winlogon events found in the last $Days days."
        return $null
    }
}

# Function 2: Startup/Shutdown Events
function Get-StartupShutdownEvents {
    param(
        [int]$Days
    )
    
    $events = Get-EventLog system -After (Get-Date).AddDays(-$Days) | Where-Object { $_.EventId -eq 6005 -or $_.EventId -eq 6006 }
    
    if ($events) {
        $eventsTable = @()
        for ($i=0; $i -lt $events.Count; $i++) {
            $event = ""
            if ($events[$i].EventId -eq "6005") { $event="Startup" }
            if ($events[$i].EventId -eq "6006") { $event="Shutdown" }
            
            $eventsTable += [pscustomobject]@{
                "Time"  = $events[$i].TimeGenerated; `
                "Id"    = $events[$i].EventId; `
                "Event" = $event; `
                "User"  = "System";
            }
        }
        return $eventsTable
    }
    else {
        Write-Host "No startup/shutdown events found in the last $Days days."
        return $null
    }
}

# Call both functions and display results
$loginResults = Get-LoginEvents -Days 100
$startupShutdownResults = Get-StartupShutdownEvents -Days 100

Write-Host "`nLogin/Logoff Events:"
$loginResults

Write-Host "`nStartup/Shutdown Events:"
$startupShutdownResults