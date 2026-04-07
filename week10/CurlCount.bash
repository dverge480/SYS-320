#!/bin/bash

allLogs=""

file="/var/log/apache2/access.log"


function countingCurlAccess (){
	curlAccessed=$(cat "$file" | grep "curl" | cut -d ' ' -f1,12 | sort | uniq -c)
}


countingCurlAccess
echo "$curlAccessed"
