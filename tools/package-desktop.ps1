# package-desktop.ps1 - build ThronefallCommand and stage a distributable zip.
# Inno Setup is not installed on this machine; when it is, swap the zip step
# for iscc.exe compile. The zip is the v3 release artifact.
param([switch]$NoBuild)
$ErrorActionPreference = 'Stop'
$root   = Split-Path -Parent $PSScriptRoot
$src    = Join-Path $root 'desktop\ThronefallCommand'
$bin    = Join-Path $src 'bin\Release\net8.0-windows'
$stage  = Join-Path $root 'dist\staging\desktop'
$zip    = Join-Path $root 'dist\ThronefallCommand.zip'

if (-not $NoBuild) {
    dotnet build (Join-Path $src 'ThronefallCommand.csproj') -c Release | Out-Null
    if ($LASTEXITCODE -ne 0) { Write-Host "BUILD FAILED"; exit 1 }
}
if (-not (Test-Path (Join-Path $bin 'ThronefallCommand.exe'))) {
    Write-Host "no exe at $bin - run without -NoBuild"; exit 1
}
if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory -Force -Path $stage | Out-Null
Copy-Item "$bin\*" $stage -Recurse
@"
THRONEFALL COMMAND - desktop host
==================================
ThronefallCommand.exe - WPF host for the coach web UI (:8099 or auto-attaches
to a running coach-server.py on 8090..8140). Requires the WebView2 runtime
(installer prompts if missing) and .NET 8 desktop runtime.

F1 opens the full shortcut list. Blue border = MiniMax actively steering.
"@ | Set-Content (Join-Path $stage 'INSTALL.txt')
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path "$stage\*" -DestinationPath $zip
$exe = Get-Item (Join-Path $bin 'ThronefallCommand.exe')
$zipMb = [math]::Round((Get-Item $zip).Length/1MB, 1)
$exeKb = [math]::Round($exe.Length/1KB)
Write-Host "packaged: $zip ($zipMb MB)"
Write-Host "exe: $exeKb KB"
