

Get-Content C:\xampp\apache\logs\access.log | Select-String -NotMatch "\s200\s"
