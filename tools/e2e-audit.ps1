# End-to-end verification: web -> server -> game -> Minimax, every link proven.
# Usage: powershell -File tools/e2e-audit.ps1
$ErrorActionPreference = "SilentlyContinue"
$ok = 0; $fail = 0; $rows = @()
function Check($name, $test) {
    try { $r = & $test } catch { $r = "exception: $($_.Exception.Message)" }
    # The thrown-path detail used to land in $detail and print nothing —
    # FAIL rows carried no reason.
    if ($r -eq $true) { $script:ok++; $script:rows += "  PASS  $name" }
    else { $script:fail++; $script:rows += "  FAIL  $name$(if($r -is [string]){ " -- $r"})" }
}

$port = "http://127.0.0.1:8099"
$agent = "K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent"
$gamelog = "K:\Downloads-IDM\Thronefall\BepInEx\LogOutput.log"

"=== E2E AUDIT $(Get-Date -Format 'HH:mm:ss') ==="

# 1. server endpoints
Check "GET / 200"            { (Invoke-WebRequest "$port/" -UseBasicParsing -TimeoutSec 8).StatusCode -eq 200 }
Check "GET /state 200"       { $j = Invoke-WebRequest "$port/state" -UseBasicParsing -TimeoutSec 8; $j.StatusCode -eq 200 }
Check "GET /audit 200"       { $j = Invoke-WebRequest "$port/audit" -UseBasicParsing -TimeoutSec 8; ($j.Content | ConvertFrom-Json).t -gt 0 }
Check "GET /health 200"      { (($(Invoke-WebRequest "$port/health" -UseBasicParsing -TimeoutSec 8).StatusCode) -eq 200) }
Check "GET /metrics 200"     { $m = Invoke-WebRequest "$port/metrics" -UseBasicParsing -TimeoutSec 15 | ConvertFrom-Json; $m.curve.Count -gt 0 }
Check "GET /live.json ts"    { (Invoke-WebRequest "$port/live.json" -UseBasicParsing -TimeoutSec 8 | ConvertFrom-Json).ts -gt 0 }
Check "GET /live.png bytes"  { (Invoke-WebRequest "$port/live.png" -UseBasicParsing -TimeoutSec 8).RawContentLength -gt 10000 }

# 2. feeds fresh
Check "audit.json < 10s"     { (Get-Item "$agent\audit.json").LastWriteTime -gt (Get-Date).AddSeconds(-10) }
Check "live.png < 15s"       { (Get-Item "$agent\live.png").LastWriteTime -gt (Get-Date).AddSeconds(-15) }
Check "chat POST /chat"      {
    $r = Invoke-WebRequest "$port/chat" -Method POST -Body '{"message":"status?"}' -UseBasicParsing -TimeoutSec 60 | ConvertFrom-Json
    $r.reply.Length -gt 10 }

# 3. round-trip: command -> game log
# Backup+restore the command file — overwriting a pending real command
# silently rewrites live game config (audit #12).
Check "order->applied"       {
    $cmdFile = "$agent\coach-commands.json"
    $backup = $null
    if (Test-Path $cmdFile) { $backup = Get-Content $cmdFile -Raw }
    try {
        $log = Get-Content $gamelog -Tail 4000
        $before = ($log | Select-String 'user-cmd').Count
        Set-Content $cmdFile '{"escort_size":5,"note":"e2e-audit"}'
        Start-Sleep -Seconds 8
        ((Get-Content $gamelog -Tail 4000 | Select-String 'user-cmd').Count -gt $before)
    } finally {
        if ($null -ne $backup) { Set-Content $cmdFile $backup } else { Remove-Item $cmdFile -ErrorAction SilentlyContinue }
    } }

# 4. Minimax watch loop live
Check "mmwatch < 90s"        {
    $last = Get-Content "$agent\mmwatch.jsonl" -Tail 1 | ConvertFrom-Json
    $last.t -gt (Get-Date).AddSeconds(-95).ToUniversalTime().Subtract([datetime]'1970-01-01').TotalSeconds }
Check "mm apply rate > 50%"  {
    $m = Invoke-WebRequest "$port/metrics" -UseBasicParsing -TimeoutSec 15 | ConvertFrom-Json
    $m.mm_total -eq 0 -or $m.mm_rate -ge 50 }

# 5. bot sanity in current run
# The run must be fresh enough to be THIS session — a brand-new run still
# idling at t<60 reads as "no day phase" and false-failed (audit staleness).
Check "run has day phase"    {
    $run = Get-ChildItem "$agent\runs" | Sort-Object LastWriteTime -Desc | Select-Object -First 1
    if (-not $run) { return $false }
    if ($run.LastWriteTime -lt (Get-Date).AddMinutes(-30)) { return "stale run dir" }
    $modes = Get-Content "$($run.FullName)\ticks.jsonl" -Tail 2000 | ForEach-Object { (($_ | ConvertFrom-Json).mode) }
    $modes -contains 'SpendGold' -or $modes -contains 'CollectCoin' -or $modes -contains 'PositionArmy' }
Check "no instant night"     {
    $run = Get-ChildItem "$agent\runs" | Sort-Object LastWriteTime -Desc | Select-Object -First 1
    $t = Get-Content "$($run.FullName)\ticks.jsonl" -Tail 4000 | ForEach-Object { $j = $_ | ConvertFrom-Json; if ($j.mode -eq 'StartNight') { [int]$j.t; break } }
    -not $t -or $t -gt 60 }

""
$rows | ForEach-Object { $_ }
""
"RESULT: $ok pass / $fail fail"
if ($fail -eq 0) { "ALL LINKS VERIFIED" } else { "BROKEN LINKS PRESENT" }
