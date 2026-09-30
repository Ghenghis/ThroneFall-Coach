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

# ErrorActionPreference.Stop does NOT catch a non-zero native exit — a failed
# decompile still printed the success banner and left STALE .cs trees behind
# that later diffs read as current. Check the exit code and clean the dirs.
foreach ($d in @($out, (Join-Path $PSScriptRoot '..\decompiled_fog'))) {
    if (Test-Path $d) { Remove-Item $d -Recurse -Force }
}
ilspycmd (Join-Path $managed 'Assembly-CSharp.dll') -o $out -p
if ($LASTEXITCODE -ne 0) { throw "ilspycmd failed on Assembly-CSharp ($LASTEXITCODE)" }
ilspycmd (Join-Path $managed 'KB.FogRTS.Runtime.dll') -o (Join-Path $PSScriptRoot '..\decompiled_fog') -p
if ($LASTEXITCODE -ne 0) { throw "ilspycmd failed on FogRTS ($LASTEXITCODE)" }

Write-Host "Decompiled to $out (game) and decompiled_fog (fog-of-war runtime)."
Write-Host 'Re-check class/member names used by src\Plugin.cs and src\Patches.cs after game updates.'
