# build-desktop.ps1 — build the Thronefall Command desktop host (WebView2).
# Produces dist\desktop\ThronefallCommand.exe — double-click to run.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$proj = Join-Path $root 'desktop\ThronefallCommand\ThronefallCommand.csproj'
$out  = Join-Path $root 'dist\desktop'

Write-Host "Building Thronefall Command (net8.0-windows / WebView2)..." -ForegroundColor Cyan
dotnet publish $proj -c Release -o $out `
  -p:PublishSingleFile=false -p:SelfContained=false --nologo
if ($LASTEXITCODE -ne 0) { throw "publish failed" }

Write-Host ""
Write-Host "Desktop app: $out\ThronefallCommand.exe" -ForegroundColor Green
Write-Host "Requires: .NET 8 desktop runtime + Edge WebView2 (preinstalled on Win10/11)."
Write-Host "First run: pick a port (free ports listed, 'auto' picks one) -> Connect."
