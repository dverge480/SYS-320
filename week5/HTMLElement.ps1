$scraped_page = Invoke-WebRequest -Uri http://10.0.17.17/ToBeScraped.html

#Get a count of the links in the page
$LinkCount = $scraped_page.Links.Count

Write-Host "Number of links on the page: $LinkCount"

#Get the links as HTML elements 
$scraped_page.ParsedHtml