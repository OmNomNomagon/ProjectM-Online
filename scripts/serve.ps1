<#
    Local preview server with live reload.
    Usage:  .\scripts\serve.ps1  [-Port 1313] [-Drafts]
    Then open http://localhost:1313  -- edits rebuild and refresh automatically.
#>
param(
    [int]$Port = 1313,
    [switch]$Drafts
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent

. (Join-Path $PSScriptRoot 'find-hugo.ps1')
$hugo = Find-Hugo

Set-Location $repo

$hugoArgs = @(
    'server'
    '--port', $Port
    '--bind', '127.0.0.1'
    '--navigateToChanged'
    '--disableFastRender'
    # Since Hugo 0.123 the server renders to publishDir ON DISK by default. Here that is
    # .\public - the live-site submodule - so it would fill the deploy repo with pages
    # carrying injected livereload <script> tags. Keep the preview entirely in memory.
    '--renderToMemory'
)
if ($Drafts) { $hugoArgs += '--buildDrafts' }

Write-Host "Hugo:  $hugo"
Write-Host "Serving $repo on http://localhost:$Port"
Write-Host ''

& $hugo @hugoArgs
