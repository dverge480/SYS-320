$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ' 

# Define a regex for IP addresses 
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" 

# Get $notfounds records that match to the regex 
$ipsUnorganized = $regex.Matches($notfounds) 

# Get ips as pscustomobject 
$ips = @()
for($i=0; $i -lt $ipsunorganized.count; $i++){
 $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

# Count ips from number 8 
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object -Property IP | Select-Object Count, Name
$counts