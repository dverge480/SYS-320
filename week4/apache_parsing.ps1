function ApacheLogs {

    $logPath = "C:\xampp\apache\logs\access.log"

    if (-not (Test-Path $logPath)) {
        Write-Error "Apache log not found at $logPath"
        return
    }

    $pattern = '^(?<IP>\S+) \S+ \S+ \[(?<Time>[^\]]+)\] "(?<Method>\S+) (?<Page>\S+) (?<Protocol>[^"]+)" (?<Response>\d+) \S+ "(?<Referrer>[^"]*)" "(?<Client>[^"]*)"'

    $records = foreach ($line in Get-Content $logPath) {

        if ($line -match $pattern) {
            [PSCustomObject]@{
                IP        = $matches.IP
                Time      = $matches.Time
                Method    = $matches.Method
                Page      = $matches.Page
                Protocol  = $matches.Protocol
                Response  = $matches.Response
                Referrer  = $matches.Referrer
                Client    = $matches.Client
            }
        }
    }

    $records | Where-Object { $_.IP -like "10.*" }
}
