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

# Empty image files are never valid. They appear when two Hugo processes (say
# `hugo server` and this build, which runs with --noBuildLock) convert the same
# new images at once: one copies a file the other has created but not filled.
# Browsers that prefer AVIF then pick the empty variant and show a blank card.
$empty = @(Get-ChildItem $dest -Recurse -File -Include *.avif, *.webp, *.jpg, *.jpeg, *.png -ErrorAction SilentlyContinue |
    Where-Object Length -eq 0)
if ($empty.Count) {
    Write-Host ''
    Write-Host "BUILD FAILED - $($empty.Count) empty image file(s), e.g.:" -ForegroundColor Red
    $empty | Select-Object -First 5 | ForEach-Object { Write-Host "  $($_.FullName)" -ForegroundColor Red }
    Write-Host "Stop any running 'hugo server' and build again." -ForegroundColor Red
    exit 1
}

$pages = @(Get-ChildItem $dest -Recurse -Filter *.html -ErrorAction SilentlyContinue).Count
Write-Host ''
Write-Host "BUILD OK - $pages HTML pages" -ForegroundColor Green
if (-not $Deploy) {
    Write-Host "Throwaway copy; .\public was not touched." -ForegroundColor DarkGray
}
