# Builds the trainer and deploys it into the game's BepInEx plugins folder.
# Usage: .\tools\build-and-deploy.ps1 [-GameRoot "K:\Downloads-IDM\Thronefall"]
param(
    [string]$GameRoot = (Split-Path $PSScriptRoot -Parent | Split-Path -Parent)
)

$ErrorActionPreference = 'Stop'
$src = Join-Path $PSScriptRoot '..\src'

Push-Location $src
try {
    dotnet build -c Release
    if ($LASTEXITCODE -ne 0) { throw "Build failed" }
}
finally { Pop-Location }

$dll = Join-Path $src '..\bin\ThronefallTrainer.dll'
$dest = Join-Path $GameRoot 'BepInEx\plugins'
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item $dll $dest -Force
Write-Host "Deployed $dll -> $dest"
Write-Host 'Note: the game must be restarted to load the new build (plugins load at startup).'
