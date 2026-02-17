$scraped_page = Invoke-WebRequest -Uri http://10.0.17.17/ToBeScraped.html

#Get a count of the links in the page
$linkCount = $scraped_Page.Links.Count

Write-Host "Number of links on the page: $linkCount"