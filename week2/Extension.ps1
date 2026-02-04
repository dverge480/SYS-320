cd C:\Users\champuser\SYS-320\week2

$files = Get-ChildItem
for ($j=0; $j -le $files.Count; $j++){
    if ($files[$j].extension -ilike ".ps1"){
        Write-Host $files[$j].Name
    }
}