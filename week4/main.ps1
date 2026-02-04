# Dot source function
. .\ApacheLogs.ps1

# Call function
$logs = ApacheLogs

# Deliverable 1
Write-Host "`nALL LOGS FROM 10.* NETWORK:"
$logs | Format-Table -AutoSize -Wrap

# Deliverable 2
$filteredLogs = $logs | Where-Object {
    $_.Page -like "*page2.html*" -and
    $_.Referrer -like "*index.html*"
}

Write-Host "`nFILTERED LOGS (page2.html + index.html):"
$filteredLogs | Format-Table -AutoSize -Wrap
