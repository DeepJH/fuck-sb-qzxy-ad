$inputFile = ".\urls.txt"
$outputDir = ".\rule-sets"

if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

$clashFile = Join-Path $outputDir "clash_block.yaml"
$adguardFile = Join-Path $outputDir "adguard_block.txt"

$domains = Get-Content $inputFile -ErrorAction SilentlyContinue | Where-Object { $_.Trim() -ne "" }

$clashRules = @()
$adguardRules = @()

foreach ($line in $domains) {
    $line = $line.Trim()
    
    if ($line -match "^(\d{1,3}\.){3}\d{1,3}$") {
        $clashRules += "IP-CIDR,$line,no-resolve"
    }
    elseif ($line -match "^(\d{1,3}\.){3}\d{1,3}/\d{1,2}$") {
        $clashRules += "IP-CIDR,$line,no-resolve"
    }
    elseif ($line -match "^[a-zA-Z0-9][a-zA-Z0-9-]*(\.[a-zA-Z0-9-]+)+$") {
        $clashRules += "DOMAIN-SUFFIX,$line,REJECT"
        $adguardRules += "||$line^"
    }
}

$clashContent = @"
payload:
$(($clashRules | ForEach-Object { "  - $_" }) -join "`n")
"@

$adguardContent = $adguardRules -join "`n"

$clashContent | Out-File -FilePath $clashFile -Encoding UTF8
$adguardContent | Out-File -FilePath $adguardFile -Encoding UTF8

Write-Host "Clash rules: $clashFile"
Write-Host "AdGuard rules: $adguardFile"
Write-Host "Total domains: $($domains.Count)"
Write-Host "Clash rules: $($clashRules.Count)"
Write-Host "AdGuard rules: $($adguardRules.Count)"