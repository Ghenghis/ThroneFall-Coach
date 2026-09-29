# Launch the Grandmaster chat UI next to the game.
# Usage: powershell tools\coach-chat.ps1
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$server = Join-Path $here 'coach-server.py'

# Prefer the user's real python, fall back to py launcher.
$py = (Get-Command python -ErrorAction SilentlyContinue).Source
if (-not $py) { $py = 'py' }

Start-Process $py -ArgumentList "`"$server`" --port 8099" -WindowStyle Minimized
Start-Sleep -Seconds 2
Start-Process "http://127.0.0.1:8099/"
Write-Host "[coach-chat] server on http://127.0.0.1:8099/  (agent dir: BepInEx\plugins\agent)"
