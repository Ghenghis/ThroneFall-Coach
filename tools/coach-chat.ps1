# Launch the Grandmaster chat UI next to the game.
# Usage: powershell tools\coach-chat.ps1
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$server = Join-Path $here 'coach-server.py'

# Reuse a live server if one is already bound — a second python dies on
# bind while the browser hits the old (stale) process either way.
$up = $false
try { $up = [bool](Get-NetTCPConnection -LocalPort 8099 -State Listen -ErrorAction Stop) } catch {}
if ($up) {
    Start-Process "http://127.0.0.1:8099/"
    Write-Host "[coach-chat] server already live on http://127.0.0.1:8099/"
    return
}

# Real python only — the App-Execution-Alias stub resolves as `python` but
# Start-Process "succeeds" and the server silently never starts.
$py = (Get-Command python -ErrorAction SilentlyContinue).Source
if ($py -and $py -notmatch 'WindowsApps') {
    Start-Process $py -ArgumentList "`"$server`" --port 8099" -WindowStyle Minimized
} else {
    $py = 'py'   # last-resort launcher
    Start-Process $py -ArgumentList "`"$server`" --port 8099" -WindowStyle Minimized
}

# Verify /health before opening the browser — a dead process used to be
# reported as success.
$live = $false
foreach ($i in 1..20) {
    Start-Sleep -Milliseconds 500
    try { $live = (Invoke-WebRequest 'http://127.0.0.1:8099/health' -UseBasicParsing -TimeoutSec 2).StatusCode -eq 200 } catch {}
    if ($live) { break }
}
if (-not $live) { Write-Host "[coach-chat] server failed to start on :8099" -ForegroundColor Red; exit 1 }
Start-Process "http://127.0.0.1:8099/"
Write-Host "[coach-chat] server on http://127.0.0.1:8099/  (agent dir: BepInEx\plugins\agent)"
