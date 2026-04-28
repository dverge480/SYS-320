echo "Checking for IOC.html in the current directory"

# Verification
if [[ ! -f "IOC.html" ]]; then
  echo "Error: IOC.html not found in the current directory."
  echo "Please make sure the file is saved here before running this script."
  exit 1
fi

# File Exists
xmlstarlet sel -H -t -m "//table/tr[position()>1]" \
 -v "td[1]" -o "  " \
 -v "td[3]" -n IOC.html > IOC.txt
echo ""

# Output
if [[ -f "IOC.txt" ]]; then
  echo "Success: IOC.txt has been created."
else
  echo "Warning: IOC.txt was not created."
  exit 1
fi

echo "Done."

echo "" 

cat IOC.txt
