# Regenerates the decompiled reference source used to maintain the trainer.
# Requires: dotnet tool install -g ilspycmd
# Usage: .\tools\decompile.ps1 [-GameRoot "K:\Downloads-IDM\Thronefall"]
param(
    [string]$GameRoot = (Split-Path $PSScriptRoot -Parent | Split-Path -Parent)
)

$ErrorActionPreference = 'Stop'
$managed = Join-Path $GameRoot 'Thronefall_Data\Managed'
$out = Join-Path $PSScriptRoot '..\decompiled'

# Upfront guards — a missing tool or wrong GameRoot used to surface as raw
# native-exit noise under ErrorActionPreference Stop.
if (-not (Get-Command ilspycmd -ErrorAction SilentlyContinue)) {
    throw "ilspycmd not on PATH — run: dotnet tool install -g ilspycmd"
}
if (-not (Test-Path $managed)) {
    throw "Managed dir not found at $managed — pass -GameRoot <game install>"
}

ilspycmd (Join-Path $managed 'Assembly-CSharp.dll') -o $out -p
ilspycmd (Join-Path $managed 'KB.FogRTS.Runtime.dll') -o (Join-Path $PSScriptRoot '..\decompiled_fog') -p

Write-Host "Decompiled to $out (game) and decompiled_fog (fog-of-war runtime)."
Write-Host 'Re-check class/member names used by src\Plugin.cs and src\Patches.cs after game updates.'
