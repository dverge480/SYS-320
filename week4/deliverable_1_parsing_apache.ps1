function ApacheLogs {
    $logPath = "C:\xampp\apache\logs\access.log"
    $tableRecords = @()

    Get-Content $logPath | ForEach-Object {
        if ($_ -match '^(?<IP>\S+) \S+ \S+ \[(?<Time>[^\]]+)\] "(?<Method>\S+) (?<Page>\S+) (?<Protocol>[^"]+)" (?<Response>\d+) \S+ "(?<Referrer>[^"]*)" "(?<Client>[^"]*)"') {
            $tableRecords += [PSCustomObject]@{
                IP       = $matches.IP
                Time     = $matches.Time
                Method   = $matches.Method
                Page     = $matches.Page
                Protocol = $matches.Protocol
                Response = $matches.Response
                Referrer = $matches.Referrer
                Client   = $matches.Client
            }
        }
    }

    $tableRecords | Where-Object { $_.IP -like "10.*" }
}

$tableRecords = ApacheLogs
$tableRecords | Format-Table -AutoSize -Wrap
