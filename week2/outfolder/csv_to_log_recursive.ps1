$files = Get-ChildItem -File -Recurse
$files | ForEach-Object -Process { Rename-Item $_.FullName ($_.Name -replace '.csv', '.log') }
Get-ChildItem -File -Recurse