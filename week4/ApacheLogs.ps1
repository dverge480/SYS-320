function ApacheLogs {

    $logs = Get-Content "C:\xampp\apache\logs\access.log"
    $records = @()

    foreach ($line in $logs) {

        # Skip empty or malformed lines
        if ([string]::IsNullOrWhiteSpace($line)) {
            continue
        }

        $words = $line.Split(" ")

        # Apache logs should have at least 12 fields
        if ($words.Count -lt 12) {
            continue
        }

        $records += [PSCustomObject]@{
            IP       = $words[0]
            Time     = $words[3].Trim("[")
            Method   = $words[5].Trim('"')
            Page     = $words[6]
            Protocol = $words[7].Trim('"')
            Response = $words[8]
            Referrer = $words[10].Trim('"')
            Client   = ($words[11..($words.Count - 1)] -join " ").Trim('"')
        }
    }

    return $records | Where-Object { $_.IP -ilike "10.*" }
}
