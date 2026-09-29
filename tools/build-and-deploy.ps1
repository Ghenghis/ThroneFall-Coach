# Builds the trainer and deploys it into the game's BepInEx plugins folder.
# Stops thronefall.exe first — the plugin DLL is locked while the game runs.
# Usage: .\tools\build-and-deploy.ps1 [-GameRoot "K:\Downloads-IDM\Thronefall"] [-NoRelaunch]
param(
    [string]$GameRoot = (Split-Path $PSScriptRoot -Parent | Split-Path -Parent),
    [switch]$NoRelaunch
)

$ErrorActionPreference = 'Stop'
$src = Join-Path $PSScriptRoot '..\src'

Push-Location $src
try {
    dotnet build -c Release
    if ($LASTEXITCODE -ne 0) { throw "Build failed" }
}
finally { Pop-Location }

$proc = Get-Process thronefall -ErrorAction SilentlyContinue
if ($proc) {
    Write-Host "Stopping thronefall.exe (PID $($proc[0].Id)) — plugin DLL is locked while running"
    Stop-Process -Name thronefall -Force
    Start-Sleep -Seconds 2
}

$dll = Join-Path $src '..\bin\ThronefallTrainer.dll'
$dest = Join-Path $GameRoot 'BepInEx\plugins'
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item $dll $dest -Force
Write-Host "Deployed $dll -> $dest"

if ($NoRelaunch) {
    Write-Host 'Skipped relaunch (-NoRelaunch).'
} else {
    Start-Process (Join-Path $GameRoot 'thronefall.exe') -WorkingDirectory $GameRoot
    Write-Host 'Relaunched game.'
}
