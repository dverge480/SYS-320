. (Join-Path C:\Users\champuser\SYS-320\week3 Login_Logoff_AND_Startup_Shutdown.ps1) 
clear 

# Get Login and Logoff from the last 15 days 
$loginoutTable = Get-LoginEvents -Days 15
$loginoutTable 

# Get all startup/shutdown events from the last 25 days
$allEvents = Get-StartupShutdownEvents -Days 25

# Get Shut Downs from the last 25 days 
$shutdownsTable = $allEvents | Where-Object { $_.Event -eq "Shutdown" }
$shutdownsTable 

# Get Start Ups from the last 25 days 
$startupsTable = $allEvents | Where-Object { $_.Event -eq "Startup" }
$startupsTable