<#  Resolves the Hugo Extended binary, whether or not PATH has refreshed yet.  #>
function Find-Hugo {
    $cmd = Get-Command hugo -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    $candidates = @(
        (Join-Path $env:LOCALAPPDATA 'Microsoft\WinGet\Packages\Hugo.Hugo.Extended_Microsoft.Winget.Source_8wekyb3d8bbwe\hugo.exe'),
        (Join-Path $env:LOCALAPPDATA 'Microsoft\WinGet\Links\hugo.exe'),
        'C:\ProgramData\chocolatey\bin\hugo.exe'
    )
    foreach ($c in $candidates) { if (Test-Path $c) { return $c } }

    throw "Hugo not found. Install it with:  winget install Hugo.Hugo.Extended"
}
