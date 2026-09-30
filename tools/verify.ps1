# Thronefall trainer - one-shot verification harness.
# Runs the full static+replay+server pipeline and prints a verdict table.
# Usage: .\tools\verify.ps1 [-ReplayTol N] [-NoBuild]
param([int]$ReplayTol = 3, [switch]$NoBuild)

$ErrorActionPreference = 'Continue'
$root = Split-Path -Parent $PSScriptRoot
$results = [ordered]@{}

Write-Host '=== verify ===' -ForegroundColor Cyan

# 1. static lint
& (Join-Path $PSScriptRoot 'bot-lint.ps1') | Out-Null
$results['bot-lint'] = $LASTEXITCODE -eq 0

# 2. build (unless skipped)
if (-not $NoBuild) {
    dotnet build (Join-Path $root 'src\ThronefallTrainer.csproj') -c Release `
        --nologo -v q 2>&1 | Out-Null
    $results['build'] = $LASTEXITCODE -eq 0
}

# 3. replay fixture
$fix = Join-Path $root 'tests\fixtures\runs\durststein-dto'
if (Test-Path (Join-Path $fix 'ticks.jsonl')) {
    $rep = dotnet run --project (Join-Path $root 'tests\Replay\Replay.csproj') `
        -- $fix --tol $ReplayTol 2>&1 | Out-String
    $results['replay'] = ($rep -match 'PASS')
    if (-not $results['replay']) { Write-Host $rep }
} else { $results['replay'] = 'no fixture' }

# 4. coach server endpoints (only if up)
try {
    $st = Invoke-RestMethod 'http://127.0.0.1:8099/state' -TimeoutSec 3
    $mt = Invoke-RestMethod 'http://127.0.0.1:8099/metrics' -TimeoutSec 15
    $results['server']  = $true
    $results['metrics'] = ($null -ne $mt.grades)
} catch { $results['server'] = "offline (start: tools\coach-chat.ps1)" }

# 5. end-to-end link chain (plugin feed → LLM → MiniMax → command apply →
# telemetry) — only when the game + server are live. This is the audit's
# "proof harness"; the static checks above can't see runtime behavior.
try {
    $hc = Invoke-RestMethod 'http://127.0.0.1:8099/health' -TimeoutSec 5
    if ($hc.ok) {
        $e2e = & (Join-Path $PSScriptRoot 'e2e-audit.ps1') 2>&1 | Out-String
        # e2e-audit emits "  FAIL  name" (colon-free) — 'FAIL:' matched
        # nothing and every broken chain reported PASS.
        $fails = ([regex]::Matches($e2e, '(?m)^\s*FAIL\s')).Count
        $results['e2e-chain'] = $fails -eq 0
        if ($fails -gt 0) { Write-Host $e2e }
    } else { $results['e2e-chain'] = 'plugin feed not live' }
} catch { $results['e2e-chain'] = 'server offline' }

# verdict
Write-Host ''
$results.GetEnumerator() | ForEach-Object {
    $ok = $_.Value -eq $true
    Write-Host (" [{0}] {1}  {2}" -f ($(if($ok){'PASS'}elseif($_.Value -is [string]){'SKIP'}else{'FAIL'}), $_.Key, $(if($_.Value -isnot [bool]){"($($_.Value))"}else{''}))) `
        -ForegroundColor ($(if($ok){'Green'}elseif($_.Value -is [string]){'Yellow'}else{'Red'}))
}
$fail = @($results.Values | Where-Object { $_ -eq $false }).Count
Write-Host ("verify: {0} check(s) failed" -f $fail) -ForegroundColor ($(if($fail){'Red'}else{'Green'}))
exit $fail
