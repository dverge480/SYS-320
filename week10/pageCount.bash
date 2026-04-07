#!/bin/bash

allLogs=""

file="/var/log/apache2/access.log"

function pageCount(){
	pageAccessed=$(cat "$file" | cut -d' ' -f7 | sort | uniq -c | sort -rn)
}

ipAccessed=$(cat "$file" | cut -d ' ' -f1)
echo "$ipsAccessed"
echo ""

pageCount
echo "$pageAccessed"
