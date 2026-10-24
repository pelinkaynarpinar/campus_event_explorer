# Downloads Lato OFL-licensed fonts directly from the public Google Fonts repository.
# Run in project root: powershell -ExecutionPolicy Bypass -File tools\get_lato.ps1
$ErrorActionPreference = 'Stop'
$project = Split-Path -Parent $PSScriptRoot
$destination = Join-Path $project 'assets\fonts'
New-Item -ItemType Directory -Force -Path $destination | Out-Null
$base = 'https://raw.githubusercontent.com/google/fonts/main/ofl/lato/'
$files = @('Lato-Regular.ttf', 'Lato-Bold.ttf', 'Lato-ExtraBold.ttf')
foreach ($file in $files) {
    $out = Join-Path $destination $file
    Write-Host "Downloading $file..."
    Invoke-WebRequest -Uri ($base + $file) -OutFile $out -UseBasicParsing
    if ((Get-Item $out).Length -lt 100000) {
        throw "Font download incomplete: $file"
    }
}
Write-Host 'Fonts downloaded. Now run: flutter pub get'
