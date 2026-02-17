# Dot Notation 
. C:\Users\champuser\SYS-320\week5\class\Script1Scraper.ps1


# Assigning the gatherClasses function to the variable $classes   
$classes = gatherClasses

#Assigning the daysTranslator function to the variable $DaysTranslator to call it with the $classes variable
$DaysTranslator = $DaysTranslator | select "Class Code", Instructor, Location, Days, "Time Start" | 
    where {$_.Instructor -ilike "*Furkan Paligu*"}

# only show the filtered results
$DaysTranslator

# Display the results to the console
# Write-Host "--- Scraped Classes ---" -ForegroundColor Cyan
# $classes

Write-Host "`n--- Translated Days ---" -ForegroundColor Green
$DaysTranslator

