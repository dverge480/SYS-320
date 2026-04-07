#! /bin/bash

logFile="/var/log/apache2/access.log.1"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

#-------------------------------------------------------------
# function: displayOnlyPages:
# like displayOnlyIPs - but only pages
#-------------------------------------------------------------

function displayOnlyPages(){
	cat "$logFile" | cut -d ' ' -f 7 | sort -n | uniq -c
	printf "\n"
}


function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)
          
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done 
	cat "newtemp.txt" | sort -n | uniq -c
}


#-----------------------------------------------------------------------
# function: frequentVisitors: 
# Only display the IPs that have more than 10 visits
# You can either call histogram and process the results,
# Or make a whole new function. Do not forget to separate the 
# number and check with a condition whether it is greater than 10
# the output should be almost identical to histogram
# only with daily number of visits that are greater than 10 
#------------------------------------------------------------------------

function frequentVisitors(){
	#extract date and IP from log file
	local visitsPerDay=$(cat "$logFile" |cut -d " " -f 4,1 | tr -d '[' | sort | uniq)
	
	#create temp file
	:> newtemp.txt

	#process each line to extract date w/0 hours and IP
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d " " -f 1)
		echo "$IP $withoutHours" >> newtemp.txt #write IP and date to temp file
	done

	#get the count and filter for visits greater then 10

	cat "newtemp.txt" | sort -n | uniq -c | while read -r count ip date;
	do
		if [[ "$count" -gt 10 ]]; then
			echo "$count $ip $date"
		fi
	done
}

#------------------------------------------------------------------------
# function: suspiciousVisitors
# Manually make a list of indicators of attack (ioc.txt)
# filter the records with this indicators of attack
# only display the unique count of IP addresses.  
#-----------------------------------------------------------------------
function suspiciousVisitors(){
	#check if ioc file exists
	if [[ ! -f "ioc.txt" ]]; then
		echo "Error! No IOC file found."
		return
	fi
	
	#read each IOC in the file and search for it in the log file
	cat "ioc.txt" | while read -r indicator;
		do
			grep "$indicator" "$logFile" | cut -d ' ' -f 1
		done | sort -n | uniq -c
}

#-----------------------------------------------------------------------
# Menu
#----------------------------------------------------------------------

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3] Display pages only"
	echo "[4] Histogram"
	echo "[5] Display Frequent Visitors"
	echo "[6] Display Susipcious Visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	elif [[ "$userInput" == "3" ]]; then
		echo "Displaying only pages:"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

        elif [[ "$userInput" == "5" ]]; then
		echo "Displaying frequent Visitors:"
		frequentVisitors

	elif [[ "$userInput" == "6" ]]; then
		echo "Displaying suspicious visitors:"
		suspiciousVisitors
	else
		echo "Invlaid option. Please select a number between 1-7!"
	fi
	echo  ""
done

