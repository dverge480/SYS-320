$files = Get-ChildItem

$folderPath = "C:\Users\champuser\SYS-320\week2/outfolder/"
$filePath = Join-Path $folderPath "out.csv"

$files | Where-Object { $_.Extension -eq ".ps1" } |
Export-Csv -Path $filePath