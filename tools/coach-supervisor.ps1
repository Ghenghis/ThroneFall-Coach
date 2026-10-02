<#
.SYNOPSIS
  Keeps the Thronefall coach server (and with it the incident watchdog, the MiniMax wake path and the scheduler) alive.

.DESCRIPTION
  One pass (-Once, what the scheduled task runs every minute) or a loop (default, every 30 s):
    1. GET http://127.0.0.1:<Port>/alive  - must answer ok, and the command-center watchdog thread must be alive
    2. agent\cc-heartbeat.json must be younger than 120 s (written by the scheduler's self-check job)
    3. two failed passes in a row -> kill whatever holds coach-server.py on that port and start a fresh server (hidden window)
  Writes agent\supervisor.json (read by the Live View's "supervisor" cell) and appends to agent\supervisor.log.
  It never touches the game process: a dead GAME is reported (game_running=false) and shows up as a FEED incident.

  Install as a per-user scheduled task:  tools\install-supervisor.ps1   (remove with -Remove)
#>
param(
    [switch]$Once,
    [int]$Port = 8099,
    [int]$IntervalSec = 30,
    [string]$Agent = 'K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent',
    [string]$Python = ''
)
$ErrorActionPreference = 'Continue'
$trainer = Split-Path -Parent $PSScriptRoot
$stateFile = Join-Path $Agent 'supervisor.json'
$logFile = Join-Path $Agent 'supervisor.log'
$fails = 0
if (-not $Python) {
    $cmd = Get-Command python -ErrorAction SilentlyContinue
    $Python = if ($cmd) { $cmd.Source } else { 'C:\Python314\python.exe' }
}

function Write-Log($msg) {
    try { Add-Content -LiteralPath $logFile -Value ("{0} {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $msg) -Encoding utf8 } catch { }
}

function Read-State {
    if (Test-Path -LiteralPath $stateFile) { try { return Get-Content -LiteralPath $stateFile -Raw -ErrorAction Stop | ConvertFrom-Json } catch { } }
    return [pscustomobject]@{ restarts = 0; last_restart = 0; fails = 0 }
}

function Save-State($ok, $note, $restarts, $lastRestart) {
    $game = [bool](Get-Process -Name thronefall -ErrorAction SilentlyContinue)
    $o = [ordered]@{ t = [math]::Round([DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds() / 1000.0, 1); ok = $ok; note = $note; restarts = $restarts; last_restart = $lastRestart; game_running = $game; port = $Port; pid = $PID }
    try { ($o | ConvertTo-Json -Compress) | Set-Content -LiteralPath ($stateFile + '.tmp') -Encoding utf8; Move-Item -LiteralPath ($stateFile + '.tmp') -Destination $stateFile -Force } catch { }
}

function Test-Server {
    try {
        $r = Invoke-RestMethod -Uri "http://127.0.0.1:$Port/alive" -TimeoutSec 4
        if (-not $r.ok) { return 'alive endpoint said not ok' }
        if (-not $r.watchdog) { return 'command-center watchdog thread is not running' }
    } catch { return "no answer from /alive: $($_.Exception.Message)" }
    $hb = Join-Path $Agent 'cc-heartbeat.json'
    if (Test-Path -LiteralPath $hb) {
        $age = ((Get-Date).ToUniversalTime() - (Get-Item -LiteralPath $hb).LastWriteTimeUtc).TotalSeconds
        if ($age -gt 120) { return ("cc-heartbeat.json is {0:n0}s old (scheduler stuck)" -f $age) }
    }
    return $null
}

function Restart-Server($why) {
    Write-Log "RESTART coach server: $why"
    # only processes that really run coach-server.py on our port - never a blanket kill of python
    Get-CimInstance Win32_Process -Filter "Name='python.exe' or Name='pythonw.exe'" -ErrorAction SilentlyContinue |
        Where-Object { $_.CommandLine -match 'coach-server\.py' -and $_.CommandLine -match "--port\s+$Port" } |
        ForEach-Object { Write-Log "  killing pid $($_.ProcessId)"; Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
    Start-Sleep -Seconds 2
    $out = Join-Path $Agent 'coach-server.out.log'
    $env:THRONEFALL_AGENT = $Agent        # the server must use exactly the agent dir this supervisor watches, whatever the ambient environment holds
    Start-Process -FilePath $Python -ArgumentList @('-u', (Join-Path $trainer 'tools\coach-server.py'), '--port', $Port) -WorkingDirectory $trainer `
        -WindowStyle Hidden -RedirectStandardOutput $out -RedirectStandardError ($out + '.err') | Out-Null
    for ($i = 0; $i -lt 30; $i++) {
        Start-Sleep -Seconds 1
        try { if ((Invoke-RestMethod -Uri "http://127.0.0.1:$Port/alive" -TimeoutSec 2).ok) { Write-Log "  server is back after $($i + 1)s"; return $true } } catch { }
    }
    Write-Log '  server did NOT come back within 30s'
    return $false
}

function Pass {
    $st = Read-State
    $restarts = [int]$st.restarts; $last = $st.last_restart
    $problem = Test-Server
    if (-not $problem) {
        $script:fails = 0
        Save-State $true 'server healthy' $restarts $last
        return
    }
    $script:fails++
    Write-Log "check failed ($script:fails): $problem"
    if ($Once) {
        # a one-shot pass has no memory between runs: confirm the failure once more before acting
        Start-Sleep -Seconds 5
        $problem2 = Test-Server
        if (-not $problem2) { Save-State $true 'server recovered by itself' $restarts $last; return }
        $script:fails = 2
    }
    if ($script:fails -ge 2) {
        $ok = Restart-Server $problem
        $restarts++; $last = [math]::Round([DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds() / 1000.0, 1)
        Save-State $ok ($(if ($ok) { "restarted: $problem" } else { "restart FAILED: $problem" })) $restarts $last
        $script:fails = 0
    } else {
        Save-State $false "failing: $problem" $restarts $last
    }
}

if ($Once) { Pass; return }
Write-Log "supervisor loop started (pid $PID, port $Port, every $IntervalSec s)"
while ($true) { Pass; Start-Sleep -Seconds $IntervalSec }
