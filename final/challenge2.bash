echo "Enter the name of the file to be scanned:"
read logfile

echo ""

echo "Enter the IOC file:"
read iocfile
# In our case, iocfile should be IOC.txt

# Clearing report file
> report.txt


while IFS= read -r ioc;
do
	ioc=$(echo "$ioc" | xargs)
	[[ -z "$ioc" ]] && continue
	grep -Fi "$ioc" "$logfile" | awk '{print $1, $4, $7}' >> report.txt

done < "$iocfile"

echo "Scan complete. Results saved to report.txt"
