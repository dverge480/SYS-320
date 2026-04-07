#!/bin/bash

# redirect the output of ip addr into ip_address.txt
# if this script is run on another workstation it will still work as we are using > to override anything that is already in the file.
ip addr > ip_address.txt

#use the awk command to filter the contents of ip_address.txt
#output the line that has inet AND that does not have the loopback address
#print the second field for any line that meets both conditions
address=$(awk '/inet / && !/127.0.0.1/ {print $2}' ip_address.txt)

#output the address variable in the terminal but only print the first 1-10 characters of the output (to get rid of the CIDR notation)
echo "$address" | cut -c 1-10
