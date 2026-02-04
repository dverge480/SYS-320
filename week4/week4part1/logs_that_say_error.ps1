$A = Get-Content C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'

#Display last 5 elements for result array
$A[-5..-1]