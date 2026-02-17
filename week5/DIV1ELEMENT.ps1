$scraped_page = Invoke-WebRequest -Uri http://10.0.17.17/ToBeScraped.html

#Get a count of the links in the page
$LinkCount = $scraped_page.Links.Count
Write-Host "Number of links on the page: $LinkCount"

#Get the links as HTML elements
#$scraped_page.Links (commented out because the following line can't function at the same time as this one)


# Get only the outerText and href HTML elements
Write-Host "The following are the links on the page --> "
$scraped_page.Links | Format-List outerText, href


# Get outer text of every element with the tag h2 
Write-Host "The following are the out text for every element with the tag h2 -->" 
$h2s = $scraped_page.ParsedHtml.getElementsByTagName("h2") | Format-List outerText
$h2s

# Print innerText of every div element that has the class as "div-1" 
Write-host "The Following is the innerText of every div element that has the class div-1"
$div1=$scraped_page.ParsedHtml.GetElementsByTagName("div") | where { $_.getAttributeNode("class").value -ilike "div-1" } | Select innerText
$div1