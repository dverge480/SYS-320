

Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern "\s(404|400)\s"
