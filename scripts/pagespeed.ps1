<#
  Runs Google PageSpeed Insights (Lighthouse) against the live site and prints a
  summary next to the 13 Nov 2026 mobile baseline.

  Usage (the key stays in your terminal session, never in a file or the repo):
      $env:PSI_KEY = '<your PageSpeed Insights API key>'
      .\scripts\pagespeed.ps1
      .\scripts\pagespeed.ps1 -Url https://riganti.com.au/build/tv/

  Without PSI_KEY it still runs, but keyless calls share one small daily quota
  across everyone and often fail with HTTP 429.
  Full JSON reports are saved to $env:TEMP\pagespeed\ for deeper digging.
#>
param(
    [string]$Url = 'https://riganti.com.au/',
    [string[]]$Strategy = @('mobile', 'desktop')
)

$ErrorActionPreference = 'Stop'
$outDir = Join-Path $env:TEMP 'pagespeed'
New-Item -ItemType Directory -Force $outDir | Out-Null

$baseline = @{   # mobile, Lighthouse 13.6.0 via PSI, 13 Nov 2026
    performance = 61; lcp = 14.6; fcp = 2.1; si = 6.1; tbt = 300; cls = 0; kib = 5800
}

$cats = 'performance', 'seo', 'accessibility', 'best-practices'
foreach ($s in $Strategy) {
    $q = "url=$([uri]::EscapeDataString($Url))&strategy=$s&" + (($cats | ForEach-Object { "category=$_" }) -join '&')
    if ($env:PSI_KEY) { $q += "&key=$($env:PSI_KEY)" }
    $file = Join-Path $outDir ("psi-{0}-{1:yyyyMMdd-HHmm}.json" -f $s, (Get-Date))
    Write-Host "Running $s (30-90 s)..." -ForegroundColor DarkGray
    $code = curl.exe -s -o $file -w '%{http_code}' --max-time 180 "https://www.googleapis.com/pagespeedonline/v5/runPagespeed?$q"
    if ($code -ne '200') {
        $msg = try { (Get-Content $file -Raw | ConvertFrom-Json).error.message } catch { 'no details' }
        Write-Host "$s failed: HTTP $code - $msg" -ForegroundColor Red
        continue
    }
    $r = (Get-Content $file -Raw | ConvertFrom-Json).lighthouseResult
    $a = $r.audits
    $score = { param($c) [int][math]::Round($r.categories.$c.score * 100) }
    $lcp = $a.'largest-contentful-paint'.numericValue / 1000
    $kib = [int]($a.'total-byte-weight'.numericValue / 1024)

    Write-Host ""
    Write-Host ("== {0}  ({1}, Lighthouse {2})" -f $s.ToUpper(), $Url, $r.lighthouseVersion) -ForegroundColor Cyan
    "{0,-26}{1,6}" -f 'Performance', (& $score 'performance')
    "{0,-26}{1,6}" -f 'SEO', (& $score 'seo')
    "{0,-26}{1,6}" -f 'Accessibility', (& $score 'accessibility')
    "{0,-26}{1,6}" -f 'Best practices', (& $score 'best-practices')
    "{0,-26}{1,10}" -f 'Largest Contentful Paint', $a.'largest-contentful-paint'.displayValue
    "{0,-26}{1,10}" -f 'First Contentful Paint', $a.'first-contentful-paint'.displayValue
    "{0,-26}{1,10}" -f 'Speed Index', $a.'speed-index'.displayValue
    "{0,-26}{1,10}" -f 'Total Blocking Time', $a.'total-blocking-time'.displayValue
    "{0,-26}{1,10}" -f 'Cumulative Layout Shift', $a.'cumulative-layout-shift'.displayValue
    "{0,-26}{1,10}" -f 'Total payload', ("{0:N0} KiB" -f $kib)
    if ($s -eq 'mobile') {
        Write-Host ("vs baseline: Performance {0} -> {1}, LCP {2} s -> {3:N1} s, payload {4:N0} -> {5:N0} KiB" -f `
            $baseline.performance, (& $score 'performance'), $baseline.lcp, $lcp, $baseline.kib, $kib) -ForegroundColor Yellow
    }
    $fails = $r.categories.PSObject.Properties.Value | ForEach-Object { $_.auditRefs } |
        Where-Object { $_.weight -gt 0 -and $a.($_.id).score -ne $null -and $a.($_.id).score -lt 0.9 } |
        ForEach-Object { $a.($_.id).title } | Select-Object -Unique
    if ($fails) { Write-Host "Flagged audits:" -ForegroundColor DarkYellow; $fails | ForEach-Object { "  - $_" } }
    Write-Host "Full report: $file" -ForegroundColor DarkGray
}
