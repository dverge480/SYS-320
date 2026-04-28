# Run with sudo privledges
#!/bin/bash

cat > report.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
<title>
Reported Access Logs
</title>
</head>
<body>
<h1> Access logs with IOC indicators:</h1>
<table>
EOF

while IFS= read -r line;
do
	ip=$(echo "$line" | awk '{print $1}')
	timestamp=$(echo "$line" | awk '{print $2}')
	page=$(echo "$line" | awk '{print $3}')

	echo " <tr>" >> report.html
	echo " <td>$ip</td>" >> report.html
	echo " <td>$timestamp</td>" >> report.html
	echo " <td>$page</td>" >> report.html
	echo " </tr>" >> report.html

done < report.txt

cat >> report.html << 'EOF'
</table>
</body>
</html>
EOF

sudo mv report.html /var/www/html

echo "The file created named report.html has been moved to the webpage directory."
