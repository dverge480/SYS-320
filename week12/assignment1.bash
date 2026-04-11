#! /bin/bash
clear

# filling courses.txt
bash Courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

function displayLocation(){
echo -n "Input a course location (ex. FREE, CCM): "
read courseLocation

echo ""
echo "Courses in $courseLocation :"
cat "$courseFile" | grep "$courseLocation" | cut -d';' -f1,2,5,6,7 | sed 's/;/ | /g'
echo ""
}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas

function displayAvailability(){

echo -n "Input course subject (ex. SEC, NET): "
read courseSubject

echo ""
echo "Available courses in $courseSubject :"
grep "^$courseSubject" "$courseFile" | while IFS=";" read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10; do
	if [ "$f4" -gt 0 ]; then
		echo "$f1 | $f2 | $f3 | $f4 | $f5 | $f6 | $f7 | $f8 | $f9 | $f10"
	fi
done
echo ""
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display course(s) in the specified classroom"
	echo "[4] Display availability of course subjects"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayLocation

	elif [[ "$userInput" == "4" ]]; then
		displayAvailability

	elif [[ "$userInput" == "5" ]]; then
		displayAvailability
		
	else
		echo "Come on, how hard can numbers be? Invalid input, try again."
	fi
done
