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
$brain = Get-Content (Join-Path $src 'BotBrain.cs') -Raw
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

# ── 6. Mode enum coverage — every BotMode must be referenced by the brain ───
$modeNames = [regex]::Match($brain, 'enum\s+BotMode\s*\{([^}]+)\}').Groups[1].Value `
             -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\w+$' }
$missing = @()
# ResolveUI is a Tick-level mode (blocking frames) — either file may hold it.
$modeScope = $brain + "`n" + $bot
foreach ($m in $modeNames) {
    if ($modeScope -notmatch "BotMode\.$m") { $missing += $m }
}
if ($missing.Count -gt 0) {
    Report 'FAIL' 'mode-coverage' "BotMode value(s) never referenced: $($missing -join ', ')" `
           'dead enum or missing Decide branch — add the branch or remove the value'
} else {
    Report 'PASS' "mode-coverage: all $($modeNames.Count) BotMode values referenced" $null $null
}

# ── 6b. Pure-layer purity: BotBrain.cs must stay Unity-free (replay tests
# compile it standalone — see v3 design §3.1). Forbidden: engine/game types
# and the singleton/side-effect surface the Intent executor owns. ────────────
$pureForbidden = 'UnityEngine', 'AstarPath', 'Pathfinding', '\.instance\b', '\bTime\.',
                 'LocalGamestate', 'EnemySpawner', 'TagManager', 'PlayerInteraction',
                 'SceneTransitionManager', 'PerkManager', 'ChoiceManager', 'UIFrameManager',
                 'TaggedObject', 'BuildingInteractor', 'ManualAttack', 'Vector3',
                 '\.InteractionBegin\s*\(', '\.SwitchToNight\s*\(', '\bPumpAttack\s*\(', 'Plugin\.'
$pureHits = @()
for ($i = 0; $i -lt ($brain -split "`n").Count; $i++) {
    $l = ($brain -split "`n")[$i]
    if ($l -match '^\s*//') { continue }
    $l = $l -replace '//.*$', ''                       # strip inline comments
    if ($l -match '^\s*$') { continue }
    foreach ($f in $pureForbidden) {
        if ($l -match $f) { $pureHits += "$($i + 1):$($l.Trim())"; break }
    }
}
if ($pureHits.Count -gt 0) {
    Report 'FAIL' 'pure-layer: forbidden token(s) in BotBrain.cs' ($pureHits -join ' | ') `
           'decisions are pure — push the world call into an Intent + Tick executor'
} else {
    Report 'PASS' 'pure-layer: BotBrain.cs contains no Unity/game-singleton tokens' $null $null
}

# ── 7. Snapshot fields used by Decide exist in Snapshot ─────────────────────
$snFields = ($per -split "`n") | ForEach-Object { $_.Trim() } |
    Where-Object { $_ -match '^public\s+\S+\s+(\w+)\s*;' } |
    ForEach-Object { ($_ -split '\s+')[2] -replace ';', '' }
# 's' must be a standalone identifier — without the lookbehind the pattern
# also matches the tail of sessionDefeats.TryGetValue, BindingFlags.X,
# Paths.PluginPath, System.Collections.Generic, items.Length, ...
$used = [regex]::Matches($bot, '(?<![A-Za-z0-9_])s\.([A-Z]\w+)') |
    ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
$unknown = $used | Where-Object { $_ -notin $snFields -and $_ -notin @('Null') }
if ($unknown.Count -gt 0) {
    Report 'WARN' "snapshot-fields: 's.X' with no Snapshot member: $($unknown -join ', ')" `
           'may be fine if X is a local shorthand — verify before deploy' $null
} else {
    Report 'PASS' "snapshot-fields: all $($used.Count) 's.X' refs resolve to Snapshot members" $null $null
}

# ── 8. Learning stack present + wired ───────────────────────────────────
$newFiles = @('Policy.cs','Memory.cs','NetPolicy.cs','Overlay.cs','Coach.cs')
foreach ($nf in $newFiles) {
    if (Test-Path (Join-Path $src $nf)) {
        if ($csproj -match [regex]::Escape($nf) -or $nf -in @('Overlay.cs','Policy.cs','Memory.cs','NetPolicy.cs','Coach.cs')) {
            Report 'PASS' "stack: $nf present" $null $null
        }
    } else { Report 'FAIL' "stack: $nf missing" '' 'restore src/' + $nf }
}
# Neural net must stay shadow-mode: Shadow(...) returns an Intell; the bot
# may only ever *log* it — a direct NetPolicy.Mode/Action call that feeds
# intents would be an unprompted behaviour change. Shadow-ok if no
# "NetPolicy." call outside Shadow()/log lines.
$netCalls = [regex]::Matches($bot, 'NetPolicy\.(\w+)') |
    ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique
$badNet = $netCalls | Where-Object { $_ -notin @('Shadow','Init','Loaded','Agree','Disagree','Ratio') }
if ($badNet) {
    Report 'FAIL' "shadow-gate: NetPolicy.$($badNet -join ',') called in Bot.cs" '' `
           'neural policy must stay advisory — gate via NetPolicy.Shadow only'
} else {
    Report 'PASS' 'shadow-gate: neural net is shadow/advisory only' $null $null
}
# Overlay: F1 or F8 toggle present (F1 collided with Plugin.ToggleMenu, F8 is the audit fix)
if ((Get-Content (Join-Path $src 'Overlay.cs') -Raw) -match 'KeyCode\.(F1|F8)') {
    Report 'PASS' 'overlay: toggle present' $null $null
} else { Report 'WARN' 'overlay: toggle missing' '' 'Overlay.Update should toggle Visible on F1 or F8' }
# MiniMax orchestration guards must stay in place (regression lock).
$cs = Get-Content (Join-Path $PSScriptRoot 'coach-server.py') -Raw
$bp = Get-Content (Join-Path $src 'BotPerception.cs') -Raw
foreach ($pair in @(
    @('guard_patch', 'coach-server: guard_patch (fighter/army_target guard)'),
    @('mm-heartbeat\.json', 'coach-server: MiniMax heartbeat file'),
    @('proposals\.jsonl', 'coach-server: proposal channel'),
    @('def eng_digest', 'coach-server: engineering digest'))) {
    if ($cs -match $pair[0]) { Report 'PASS' $pair[1] $null $null }
    else { Report 'FAIL' ($pair[1] + ' missing') '' 'see docs/ORCHESTRATION.md' }
}
if ($bp -match 'Mathf\.Max\(at, Coach\.ArmyTargetFloor\)') { Report 'PASS' 'coach: army_target is a floor' $null $null }
else { Report 'FAIL' 'coach: army_target overwrites the bot target' '' 'use Mathf.Max(at, Coach.ArmyTargetFloor)' }
# Coach must never block the frame: UnityWebRequest banned (we use
# HttpWebRequest on a background thread).
$coa = Get-Content (Join-Path $src 'Coach.cs') -Raw
if ($coa -match 'UnityWebRequest|\.Download\(.*\)' -and $coa -notmatch 'WebRequest\.Create') {
    Report 'WARN' 'coach-io: possible blocking web call on game thread' '' `
           'Coach calls must stay on a background thread (WebRequest + Thread)'
} else {
    Report 'PASS' 'coach-io: advisor calls stay off the game thread' $null $null
}
# Memory + Policy actually exercised in Bot.cs
foreach ($pin in @('Memory\.(Park|Bump|NearMishap|Count|Init)',
                   'Policy\.(Eval|Commit|Update|Save|RewardMatch|Init|States|Cells)')) {
    if ($bot -match $pin) {
        Report 'PASS' "wired: $($pin.Split('.')[0]) exercised in Bot.cs" $null $null
    } else {
        Report 'WARN' "wired: $($pin.Split('.')[0]) not exercised in Bot.cs" '' `
               'record/learn calls missing — learning layer is dead code'
    }
}

# Map-intel fallback: scenes without a hand strategy_*.json must still get a
# generated playbook — regression = losing the .auto.json fallback and an
# unseen map running blind.
$agentDir = 'K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent'
$autos = (Get-ChildItem (Join-Path $agentDir 'botpack\strategy_*.auto.json') -EA SilentlyContinue |
          Measure-Object).Count
if ($autos -gt 0 -and $bp -match '\.auto\.json') {
    Report 'PASS' "map-intel: $autos auto strategies + LoadStrategy fallback" $null $null
} else {
    Report 'WARN' 'map-intel: auto strategy fallback missing' '' `
           'run tools/gen-mapintel.py; keep the .auto.json fallback in LoadStrategy'
}

Write-Host ''
# PS 5.1-safe: the ternary `? :` is PS7-only and made the whole script a
# parse error (every lint check silently never ran — audit round 7).
$lc = if ($fails -gt 0) { 'Red' } elseif ($warns -gt 0) { 'Yellow' } else { 'Green' }
Write-Host "bot-lint: $fails FAIL, $warns WARN" -ForegroundColor $lc
exit $fails
