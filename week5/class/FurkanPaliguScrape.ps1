# Dot Notation 
. C:\Users\champuser\SYS-320\week5\class\Script1Scraper.ps1


# Assigning the gatherClasses function to the variable $classes   
$classes = gatherClasses


$Instructors = $FullTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                          ($_."Class Code" -ilike "NET*") -or `
                                          ($_."Class Code" -ilike "FOR*") -or `
                                          ($_."Class Code" -ilike "CSI*") -or `
                                          ($_."Class Code" -ilike "DAT*") `
                                        } `
                              | Sort-Object "Instructor" `
                              | Select-Object "Instructor" -Unique

# Group all selected instructors by how many classes they teach, sort by count (desc)
$FullTable |
Where-Object { $_.Instructor -in $Instructors.Instructor } |
Group-Object "Instructor" |
Select-Object Count, Name |
Sort-Object Count -Descending
