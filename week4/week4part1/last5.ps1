# Get-Content C:\xampp\apache\logs\access.log | Select-String '200'﻿

$A = Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern '10.0.17.17'

#Display last 5 elements for result array
$A[-5..-1]