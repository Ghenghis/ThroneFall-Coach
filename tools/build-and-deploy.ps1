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
    # Wait for the DLL handle to actually release — a fixed 2 s could race
    # a slow disk flush and the Copy-Item threw under -ErrorAction Stop.
    foreach ($i in 1..20) {
        if (-not (Get-Process thronefall -ErrorAction SilentlyContinue)) { break }
        Start-Sleep -Milliseconds 500
    }
}

$dll = Join-Path $src '..\bin\ThronefallTrainer.dll'
$dest = Join-Path $GameRoot 'BepInEx\plugins'
New-Item -ItemType Directory -Force -Path $dest | Out-Null

# Copy with retry + HASH verification — a partial/failed copy used to
# print "Deployed" anyway (audit: no post-deploy check at all).
$copied = $false
foreach ($i in 1..6) {
    try {
        Copy-Item $dll (Join-Path $dest 'ThronefallTrainer.dll') -Force
        if ((Get-FileHash $dll).Hash -eq
            (Get-FileHash (Join-Path $dest 'ThronefallTrainer.dll')).Hash) {
            $copied = $true; break
        }
    } catch { Start-Sleep -Milliseconds 800 }
}
if (-not $copied) { throw "Deploy failed: hash mismatch or copy errors" }
Write-Host "Deployed $dll -> $dest (hash verified)"

if ($NoRelaunch) {
    Write-Host 'Skipped relaunch (-NoRelaunch).'
} else {
    $logPath = Join-Path $GameRoot 'BepInEx\LogOutput.log'
    $logLen = if (Test-Path $logPath) { (Get-Item $logPath).Length } else { 0 }
    Start-Process (Join-Path $GameRoot 'thronefall.exe') -WorkingDirectory $GameRoot
    # Prove the plugin actually LOADED — relaunch+crash used to look identical
    # to a good deploy from this script's output.
    $loaded = $false
    foreach ($i in 1..30) {
        Start-Sleep -Seconds 1
        if (Test-Path $logPath) {
            $tail = Get-Content $logPath -Raw -ErrorAction SilentlyContinue
            if ($tail -and $tail.Substring([Math]::Max(0, $tail.Length - 4000)) -match 'Thronefall Trainer|trainer\.dll|BepInEx.*loaded') {
                $loaded = $true; break
            }
        }
    }
    Write-Host ($(if ($loaded) { 'Relaunched — plugin load line present in log.' }
                  else { 'Relaunched — WARNING: no plugin load line in LogOutput.log yet (check manually).' })) -ForegroundColor ($(if ($loaded) { 'Green' } else { 'Yellow' }))
}
