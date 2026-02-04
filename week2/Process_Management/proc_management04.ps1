$chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue

if (-not $chrome) {
   Start-Process "chrome.exe" "https://www.champlain.edu"
   Write-Output "Champlain Website Loading..."
}
   else {
   Stop-Process -Name "chrome" -Force
   Write-Output "Chrome Closed"
}