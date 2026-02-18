# File Routing

. C:\Users\champuser\SYS-320\week4\apache_parsing.ps1
. C:\Users\champuser\SYS-320\week6\Event-Logs.ps1


# Creating the variable choice 
$choice = 0

# Main menu using a while loop
while ($choice -ne 5) { # Prompt the menu till user enters 5
  Write-Host "`nMain Menu: Pick an Option`n"
  Write-Host "1. Display the last 10 Apache logs`n" 
  Write-Host "2. Display the last 10 failed logins for all users`n" 
  Write-Host "3. Display at-risk users (users who failed login >9 times)`n" # Idea for criteria borrowed from Matt Compton
  Write-Host "4. Start Chrome web browser and navigate it to champlain.edu`n" 
  Write-Host "5. Exit`n" 

  $choice = Read-Host -Prompt "Enter your choice (1-5)"
  
    if ($choice -eq 1) {
    Write-Host "Displaying Last 10 Apache Logs:`n"
    ApacheLogs | Select-Object -Last 10 | Format-Table -AutoSize -Wrap
    }
    elseif ($choice -eq 2) {
      getFailedLogins
    }
    elseif ($choice -eq 3) {
      at_risk_users
    }
    elseif ($choice -eq 4) {
      $chromeRunning = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
      if (-not $chromeRunning) {
          Start-Process "chrome.exe" "https://www.champlain.edu"
          Write-Host "Chrome started and navigated to champlain.edu"
      }
      else {
        Write-Host "Chrome is already running."
      }
    }
    elseif ($choice -eq 5) {
        Write-Host "Exiting menu"
    }
    else {
    Write-Host "Invalid input. Enter an integer between 1 and 5."
    }
}