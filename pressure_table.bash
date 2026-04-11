#!/bin/bash

#-------------------------------------------------------------------------------------------
# Script that fetches data and merges temperature and pressure readings from assignmnet.html
#-------------------------------------------------------------------------------------------

# extract temperature data from assignment.html
sed -n '/<table id="temp">/,/<table id="press">/p' assignment.html | \
grep "<td>" | \
sed 's/<[^>]*>//g' | \
sed 's/^[[:space:]]*//g' | \
awk 'NF' | \
paste -d " " - - > /tmp/temp.txt

# Extract pressure data
sed -n '/<table id="press">/,/<\/table>/p' assignment.html | \
grep "<td>" | \
sed 's/<[^>]*>//g' | \
sed 's/^[[:space:]]*//g' | \
awk 'NF' | \
paste -d " " - - > /tmp/pressure.txt

# Merge the data by matching timestamps
while read temp datetime; do
    pressure=$(grep "$datetime" /tmp/pressure.txt | awk '{print $1}')
    if [ -n "$pressure" ]; then
        echo "$pressure $temp $datetime"
    fi
done < /tmp/temp.txt

# Cleanup
rm -f /tmp/temp.txt /tmp/pressure.txt
