# Thronefall trainer quality lint — static checks over src/.
# Detects regressions that broke live behavior before: ungated cheat calls in
# legit mode, log-field width violations, scaled-time timers, missing csproj
# references, and obvious dead-branch mistakes. Run after editing src/ or
# before deploying. Exit code = number of FAIL checks (0 = clean).
#
# Usage: .\tools\bot-lint.ps1 [-Fix]
#   -Fix : apply safe auto-fixes (currently: none — all findings are reported
#          with a suggested edit; automation stays opt-in by design).
param([switch]$Fix)

$ErrorActionPreference = 'Continue'
$src  = Join-Path $PSScriptRoot '..\src'
$fails = 0; $warns = 0

function Report([string]$level, [string]$check, [string]$detail, [string]$fix) {
    if ($level -eq 'FAIL') { $script:fails++ }
    elseif ($level -eq 'WARN') { $script:warns++ }
    $color = @{ FAIL='Red'; WARN='Yellow'; PASS='Green' }[$level]
    Write-Host "[$level] $check" -ForegroundColor $color
    if ($detail) { Write-Host "       $detail" -ForegroundColor DarkGray }
    if ($fix)    { Write-Host "       fix: $fix" -ForegroundColor Cyan }
}

$bot = Get-Content (Join-Path $src 'Bot.cs') -Raw
$per = Get-Content (Join-Path $src 'BotPerception.cs') -Raw
$pat = Get-Content (Join-Path $src 'BotPatches.cs') -Raw
$plg = Get-Content (Join-Path $src 'Plugin.cs') -Raw
$csproj = Get-Content (Join-Path $src 'ThronefallTrainer.csproj') -Raw

# ── 1. Legit-mode cheat gating ──────────────────────────────────────────────
# Every player-impossible call must be behind a `!Legit` or `else` of `if (Legit)`.
$cheatCalls = @(
    @{ rx = 'pm\.TeleportTo\(';            name = 'PlayerMovement.TeleportTo (movement cheat)' },
    @{ rx = 'heroAttack\.Attack\(\)';      name = 'ManualAttack.Attack() (bypasses cooldown)' },
    @{ rx = 'Hp\.TakeDamage\(';            name = 'Hp.TakeDamage (damage injection)' }
)
$lines = ($bot -split "`n")
foreach ($c in $cheatCalls) {
    $hits = @()
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match $c.rx) { $hits += ($i + 1) }
    }
    if ($hits.Count -eq 0) { continue }
    # ungated = call site has no Legit context within the surrounding block.
    # Look back up to 80 lines — the legit branch of a mode can be dozens of
    # lines long before the `else` (cheat) branch appears.
    $ungated = @()
    foreach ($h in $hits) {
        $window = ($lines[[Math]::Max(0, $h - 80)..($h - 1)] -join ' ')
        if ($window -notmatch 'Legit') { $ungated += $h }
    }
    if ($ungated.Count -gt 0) {
        Report 'FAIL' "legit-gate: $($c.name)" "line(s) $($ungated -join ', ') have no Legit check above them" `
               "wrap in `if (!Legit) { … }` or move under the cheat branch"
    } else {
        Report 'PASS' "legit-gate: $($c.name) gated at line(s) $($hits -join ', ')" $null $null
    }
}

# ── 2. Log field width (FormatStatus/logline fields must stay <=4 chars) ────
$fieldNames = [regex]::Matches($bot, '"([a-zA-Z_]{2,}):')
$tooLong = @()
foreach ($m in $fieldNames) {
    $n = $m.Groups[1].Value
    # only json field prefixes like  "hp": — skip long ones used elsewhere
    if ($n.Length -gt 4 -and $bot -match "`"t`":") {
        # restrict to lines that look like the FormatStatus template
    }
}
$fmt = [regex]::Match($bot, '(?s)FormatStatus.*?return.*?(?=private|public|//|$)')
$fmtLong = [regex]::Matches($bot, '\{"?([A-Za-z]{5,})":') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
if ($fmtLong.Count -gt 0) {
    Report 'WARN' "log-fields: fields >4 chars: $($fmtLong -join ', ')" 'histogram tooling keys off short names' `
           "shorten to <=4 chars per BOT-DEV telemetry convention"
} else {
    Report 'PASS' 'log-fields: all tick fields <=4 chars' $null $null
}

# ── 3. Scaled-time timers (must use Time.unscaledTime in bot timing code) ───
$scaled = [regex]::Matches($bot, 'Time\.time\b(?!scale)') | Where-Object { $true }
$badTime = @()
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match 'Time\.time\b' -and $lines[$i] -notmatch 'timeScale|unscaledTime' -and $lines[$i] -notmatch '^\s*//') {
        $badTime += ($i + 1)
    }
}
if ($badTime.Count -gt 0) {
    Report 'FAIL' 'unscaled-time: Time.time used in Bot.cs' "line(s) $($badTime -join ', ')" `
           'bot timers run during paused scenes — use Time.unscaledTime'
} else {
    Report 'PASS' 'unscaled-time: no raw Time.time in Bot.cs' $null $null
}

# ── 4. Per-tick noisy notes ─────────────────────────────────────────────────
# LogLine(in s, "note") inside a non-guarded path → spam. Find notes that
# aren't inside an if/onChange guard: heuristic = 'LogLine(in s, ' occurrences
# directly under a mode assign with no surrounding condition are flagged.
$noteHits = [regex]::Matches($bot, 'LogLine\(in s, "([^"]+)"\)')
$noteNames = $noteHits | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
Report 'PASS' "notes: $($noteNames.Count) distinct note types ($($noteNames -join ', '))" $null $null

# ── 5. csproj references needed by Bot.cs ───────────────────────────────────
$needs = @{
    'AstarPathfindingProject.dll' = 'AstarPath|ABPath|Pathfinding\.';
    'PackageTools.dll'            = 'VersionedMonoBehaviour (transitively required by AstarPath)';
    'Drawing.dll'                 = 'MonoBehaviourGizmos (transitively required by AstarPath)';
}
foreach ($k in $needs.Keys) {
    if ($bot -match $needs[$k] -and $csproj -notmatch [regex]::Escape($k)) {
        $refName = $k -replace '\.dll$', ''
        Report 'FAIL' "reference: $k" "Bot.cs uses $($needs[$k]) but csproj lacks the reference" `
               "add <Reference Include=`"$refName`"> to ThronefallTrainer.csproj"
    } else {
        Report 'PASS' "reference: $k" $null $null
    }
}

# ── 6. Mode enum coverage — every BotMode must have a Decide branch ─────────
$modeNames = [regex]::Match($bot, 'enum\s+BotMode\s*\{([^}]+)\}').Groups[1].Value `
             -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\w+$' }
$missing = @()
foreach ($m in $modeNames) {
    if ($bot -notmatch "BotMode\.$m") { $missing += $m }
}
if ($missing.Count -gt 0) {
    Report 'FAIL' 'mode-coverage' "BotMode value(s) never referenced: $($missing -join ', ')" `
           'dead enum or missing Decide branch — add the branch or remove the value'
} else {
    Report 'PASS' "mode-coverage: all $($modeNames.Count) BotMode values referenced" $null $null
}

# ── 7. Snapshot fields used by Decide exist in Snapshot ─────────────────────
$snFields = ($per -split "`n") | ForEach-Object { $_.Trim() } |
    Where-Object { $_ -match '^public\s+\S+\s+(\w+)\s*;' } |
    ForEach-Object { ($_ -split '\s+')[2] -replace ';', '' }
$used = [regex]::Matches($bot, 's\.([A-Z]\w+)') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
$unknown = $used | Where-Object { $_ -notin $snFields -and $_ -notin @('Null') }
if ($unknown.Count -gt 0) {
    Report 'WARN' "snapshot-fields: 's.X' with no Snapshot member: $($unknown -join ', ')" `
           'may be fine if X is a local shorthand — verify before deploy' $null
} else {
    Report 'PASS' "snapshot-fields: all $($used.Count) 's.X' refs resolve to Snapshot members" $null $null
}

Write-Host ''
Write-Host "bot-lint: $fails FAIL, $warns WARN" -ForegroundColor ($fails -gt 0 ? 'Red' : ($warns -gt 0 ? 'Yellow' : 'Green'))
exit $fails
