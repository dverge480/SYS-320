function gatherClasses {
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.17/courses.html
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")
    $FullTable = @()

    # Starting at 1 to skip the header row
    for($i=1; $i -lt $trs.length; $i++){
        $tds = $trs[$i].getElementsByTagName("td")
        
        # Ensure we have data in the row before processing
        if ($tds.Count -ge 10) {
            $Times = $tds[5].innerText.Split("-")

            $FullTable += [pscustomobject]@{
                "Class Code" = $tds[0].innerText.Trim()
                "Title"      = $tds[1].innerText.Trim()
                "Days"       = $tds[4].innerText.Trim() # Capital 'D'
                "Time Start" = $Times[0].Trim()
                "Instructor" = $tds[6].innerText.Trim()
                "Location"   = $tds[9].innerText.Trim() # Capital 'L'
            }
        }
    }
    return $FullTable
}

# call function to test that it works! 
# gatherClasses

# -----------------------------------------------------------------------------------------------------------------

#Funcation to turn days property into an array

function daysTranslator($FullTable){

# Go over every record in the table 
for($i=0; $i -lt $FullTable.length; $i++){

    #Empty array to hold days for every record
    $Days = @()

    #If you see "M" --> Monday 
    if($FullTable[$i].Days -ilike "*M*") {$Days += "Monday"}

    #If you see "T" followed by T,W or F --> Tuesday 
    if($FullTable[$i].Days -ilike "*T[W,F]*") {$Days += "Tuesday"}


    #If you see "W" --> Wednesday 
    if($FullTable[$i].Days -ilike "*W*") {$Days += "Wednesday"}

    #If you see "TH" --> Thursday  
    if($FullTable[$i].Days -ilike "*TH*") {$Days += "Thursday"}


    #If you see "F" --> Friday 
    if($FullTable[$i].Days -ilike "*F") {$Days += "Friday"}

    
    #Switch from abbreviation to full name
    $FullTable[$i].Days = $Days

} #end of for loop
return $FullTable
}
    