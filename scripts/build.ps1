<#
    Production build.

    Usage:
      .\scripts\build.ps1            # safe check build into a temp folder, nothing touched
      .\scripts\build.ps1 -Deploy    # real build into .\public (the GitHub Pages submodule)

    Fails loudly on any Hugo ERROR so a broken build never reaches the live site.
#>
param(
    [switch]$Deploy
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent

. (Join-Path $PSScriptRoot 'find-hugo.ps1')
$hugo = Find-Hugo

if ($Deploy) {
    $dest = Join-Path $repo 'public'
    Write-Host "DEPLOY build -> $dest" -ForegroundColor Yellow
} else {
    $dest = Join-Path ([System.IO.Path]::GetTempPath()) "riganti-check-$(Get-Date -Format yyyyMMdd-HHmmss)"
    Write-Host "CHECK build -> $dest" -ForegroundColor Cyan
}
Write-Host "Hugo:  $hugo"
Write-Host ''

# Windows PowerShell mangles native stderr when piped, so capture via files instead.
$outFile = [System.IO.Path]::GetTempFileName()
$errFile = [System.IO.Path]::GetTempFileName()

$proc = Start-Process -FilePath $hugo `
    -ArgumentList @('--destination', "`"$dest`"", '--noBuildLock') `
    -WorkingDirectory $repo -NoNewWindow -Wait -PassThru `
    -RedirectStandardOutput $outFile -RedirectStandardError $errFile

$lines = @()
foreach ($f in @($outFile, $errFile)) {
    if (Test-Path $f) { $lines += @(Get-Content $f -ErrorAction SilentlyContinue) }
}
Remove-Item $outFile, $errFile -ErrorAction SilentlyContinue

$errors   = @($lines | Where-Object { $_ -match '^ERROR' })
$warnings = @($lines | Where-Object { $_ -match '^WARN' })

$lines | Where-Object { $_ -notmatch '^WARN' } | ForEach-Object { Write-Host $_ }

if ($warnings.Count) {
    Write-Host ''
    Write-Host "$($warnings.Count) warning(s):" -ForegroundColor DarkYellow
    $warnings | ForEach-Object { Write-Host "  $_" -ForegroundColor DarkYellow }
}

if ($errors.Count -or $proc.ExitCode -ne 0) {
    Write-Host ''
    Write-Host "BUILD FAILED - $($errors.Count) error(s), exit $($proc.ExitCode)" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
    exit 1
}

$pages = @(Get-ChildItem $dest -Recurse -Filter *.html -ErrorAction SilentlyContinue).Count
Write-Host ''
Write-Host "BUILD OK - $pages HTML pages" -ForegroundColor Green
if (-not $Deploy) {
    Write-Host "Throwaway copy; .\public was not touched." -ForegroundColor DarkGray
}
