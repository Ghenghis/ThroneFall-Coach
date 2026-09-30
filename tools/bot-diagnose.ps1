# Thronefall bot live diagnoser — reads recent bot-log.jsonl + BepInEx log
# and reports what the run is doing wrong (or right) with suggested fixes.
#
# Usage: .\tools\bot-diagnose.ps1 [-Lines 2000] [-Fix]
#   -Lines : how many jsonl lines to inspect from the tail (default 2000)
#   -Fix   : apply safe repairs (currently: config drift — re-disables cheats
#            if legit-mode is expected but a cheat-mode note appears)
param(
    [int]$Lines = 2000,
    [switch]$Fix
)

$ErrorActionPreference = 'Continue'
$gameRoot = Split-Path $PSScriptRoot -Parent | Split-Path -Parent
$logFile  = Join-Path $gameRoot 'BepInEx\plugins\bot-log.jsonl'
$cfgFile  = Join-Path $gameRoot 'BepInEx\config\dev.thronefall.trainer.cfg'
$bep      = Join-Path $gameRoot 'BepInEx\LogOutput.log'
$issues = 0

function Diag([string]$sev, [string]$what, [string]$detail, [string]$fix) {
    if ($sev -ne 'OK') { $script:issues++ }
    $color = @{ OK='Green'; WARN='Yellow'; FAIL='Red'; INFO='Cyan' }[$sev]
    Write-Host "[$sev] $what" -ForegroundColor $color
    if ($detail) { Write-Host "      $detail" -ForegroundColor DarkGray }
    if ($fix)    { Write-Host "      fix: $fix" -ForegroundColor Cyan }
}

if (-not (Test-Path $logFile)) { Write-Host "bot-log.jsonl not found at $logFile"; exit 2 }
$rows = Get-Content $logFile -Tail $Lines | ForEach-Object {
    try { $_ | ConvertFrom-Json } catch { $null }
} | Where-Object { $_ -ne $null }
if ($rows.Count -lt 20) { Write-Host "too few log rows ($($rows.Count))"; exit 2 }

$t0 = $rows[0].t; $t1 = $rows[-1].t
$windowMin = [math]::Round(($t1 - $t0) / 60.0, 1)
Write-Host "window: $($rows.Count) rows over $windowMin min (t=$t0 → $t1)"
Write-Host "last: $($rows[-1].scene) / $($rows[-1].state) / $($rows[-1].mode) hp=$($rows[-1].hp) foes=$($rows[-1].foes) gold=$($rows[-1].gold) wave=$($rows[-1].wave) night=$($rows[-1].night)"
Write-Host ""

$notes = $rows | Where-Object { $_.note -and $_.note -ne 'tick' -and $_.note -ne 'invalid' } | Group-Object note | Sort-Object Count -Descending
if ($notes) { Write-Host "notes: $(($notes | ForEach-Object { "$($_.Name)x$($_.Count)" }) -join '  ')"; Write-Host "" }

# ── 1. Stuck loop: same pos bucket for >40 s while a TRAVEL mode is active ──
# Holding a defensive anchor during Engage is correct play — only travel
# modes (EnterLevel/SpendGold/CollectCoin/StartNight/PositionArmy) should
# flag as "parked".
$travel = @('EnterLevel','SpendGold','CollectCoin','StartNight','PositionArmy','ReturnHome')
$posBuckets = $rows | Where-Object { $_.pos -and $_.mode -in $travel } |
              Group-Object { ($_.pos | ForEach-Object { [math]::Round($_) }) -join ',' } |
              Sort-Object Count -Descending
$top = $posBuckets | Select-Object -First 1
if ($top -and $top.Count -gt 150 -and $top.Name -ne '0,0') {
    $modes = ($top.Group | Group-Object mode | Sort-Object Count -Descending | Select-Object -First 1).Name
    Diag 'FAIL' 'hero parked' "hero spent $($top.Count) ticks (~$([math]::Round($top.Count*0.26)) s) near $($top.Name) in $modes" `
         "check unstick/snap notes; if none, the watchdog may be blind (hasTarget false?) — grep 'stuck strike' in LogOutput.log"
} else {
    $anchorHold = $rows | Where-Object { $_.pos -and $_.mode -eq 'Engage' } |
                  Group-Object { ($_.pos | ForEach-Object { [math]::Round($_) }) -join ',' } |
                  Sort-Object Count -Descending | Select-Object -First 1
    $holdNote = if ($anchorHold -and $anchorHold.Count -gt 150) {
        "anchor hold at $($anchorHold.Name) x$($anchorHold.Count) (defensive — expected while Engaged)"
    } else { 'no dominant travel bucket' }
    Diag 'OK' 'hero mobile-or-anchored' $holdNote $null
}

# ── 2. Teleport-nudge while legit expected ──────────────────────────────────
$cfg = if (Test-Path $cfgFile) { Get-Content $cfgFile -Raw } else { '' }
$legitExpected = $cfg -match 'BotSurvivalCheats\s*=\s*false'
$tps = $rows | Where-Object { $_.note -eq 'teleport-nudge' }
if ($tps.Count -gt 0 -and $legitExpected) {
    Diag 'FAIL' 'cheat leak' "teleport-nudge fired $($tps.Count)x while config expects legit mode" `
         "old log lines linger across restarts — check t values are from THIS launch; if recent, rebuild+redeploy"
} elseif ($tps.Count -gt 0) {
    Diag 'INFO' 'teleport-nudge' "fired $($tps.Count)x — cheat mode active, expected" $null
}

# ── 3. Unstick/snap storms ──────────────────────────────────────────────────
$un = ($rows | Where-Object { $_.note -match '^(unstick|snap)' }).Count
if ($un -gt 40) {
    Diag 'WARN' 'unstick storm' "$un recovery events in window — navigation is fighting geometry" `
         "inspect last snap pos vs target; if same obstacle repeats, widen sidestep reach or check navmesh coverage"
} elseif ($un -gt 0) {
    Diag 'OK' 'recoveries' "$un unstick/snap events (self-resolving)" $null
}

# ── 4. Day never ends ───────────────────────────────────────────────────────
$dayRows = $rows | Where-Object { $_.night -eq $false -and $_.scene -and $_.scene -notmatch '^_' }
$nightRows = $rows | Where-Object { $_.night -eq $true }
if ($dayRows.Count -gt 400 -and $nightRows.Count -eq 0) {
    $bld = ($dayRows | Where-Object { $_.bld -gt 0 }).Count
    Diag 'FAIL' 'day never ends' "$($dayRows.Count) day ticks, no night transitions, bld>0 on $bld" `
         "if bld>0: slot deny-loop → should self-park at 7 s; if stall notes present but still stuck, lower spendWatch or pre-filter more costs"
}

# ── 5. Wave not advancing ───────────────────────────────────────────────────
$waves = $nightRows | Group-Object wave | Sort-Object Name
if ($waves.Count -eq 1 -and $nightRows.Count -gt 400) {
    $foePeak = ($nightRows | Measure-Object foes -Maximum).Maximum
    Diag 'WARN' 'wave grind' "wave $($waves[0].Name) running $($nightRows.Count) ticks, peak foes=$foePeak" `
         "slow legit nights are normal (army does the work); >15 min on one wave → check allies exist (army-placed note)"
}

# ── 6. Frame/choice churn ───────────────────────────────────────────────────
$fc = ($rows | Where-Object { $_.note -in @('frame-close','choice-pick','perk-pick') }).Count
if ($fc -gt 60) { Diag 'WARN' 'UI churn' "$fc frame/choice resolves in window" 'a frame may be reopening — check ResolveUI order vs. new frame type' }

# ── 7. Defeats ──────────────────────────────────────────────────────────────
$defeats = $rows | Where-Object { $_.note -eq 'defeat' }
if ($defeats.Count -gt 0) {
    $scenes = $defeats | Group-Object scene | ForEach-Object { "$($_.Name)x$($_.Count)" }
    Diag 'INFO' 'defeats' "$($defeats.Count) defeat(s) this window ($($scenes -join ', '))" `
         "3+ on one scene → rotation (score penalty) should pick another node; verify next EnterLevel chooses differently"
}

# ── 8. Config drift check ───────────────────────────────────────────────────
if ($cfg -ne '') {
    $cheatsOn = [regex]::Matches($cfg, '(?m)^\s*(GodHero|GodAll|InstantKill|NeverLose|NoCooldown|FreeBuild|InstantBuild)\s*=\s*true')
    if ($legitExpected -and $cheatsOn.Count -gt 0) {
        Diag 'FAIL' 'config drift' "BotSurvivalCheats=false but $($cheatsOn.Count) cheat flags still true: $(($cheatsOn | ForEach-Object { $_.Groups[1].Value }) -join ', ')" `
             "run with -Fix to write false values, or edit $cfgFile manually"
        if ($Fix) {
            $fixed = [regex]::Replace($cfg, '(?m)^(\s*(GodHero|GodAll|InstantKill|NeverLose|NoCooldown|FreeBuild|InstantBuild)\s*=\s*)true', '${1}false')
            Set-Content $cfgFile $fixed -NoNewline
            Write-Host "  → repaired $cfgFile (cheats forced false)" -ForegroundColor Green
        }
    } else {
        Diag 'OK' 'config consistent' "BotSurvivalCheats=$(if($legitExpected){'false (legit)'}else{'true (bundle)'})" $null
    }
}

# ── 9. Process/DLL health ───────────────────────────────────────────────────
$proc = Get-Process thronefall -ErrorAction SilentlyContinue
if ($proc) {
    $age = ((Get-Date) - $proc[0].StartTime).TotalMinutes
    $logAge = ((Get-Date) - (Get-Item $logFile).LastWriteTime).TotalSeconds
    Diag 'INFO' 'process' "thronefall.exe running $([math]::Round($age,1)) min; log last write $([math]::Round($logAge)) s ago" `
             $(if ($logAge -gt 30) { "log stalled >30 s — game may be paused/crashed or bot disabled" } else { $null })
} else {
    Diag 'WARN' 'process' 'thronefall.exe not running' 'relaunch to continue verification'
}

Write-Host ""
Write-Host "bot-diagnose: $issues issue(s)" -ForegroundColor $(if ($issues -gt 0) { 'Yellow' } else { 'Green' })
exit $(if ($issues -gt 0) { 1 } else { 0 })
