<#
.SYNOPSIS
  Install (or remove) the per-user scheduled task that runs tools\coach-supervisor.ps1 -Once every minute.
.DESCRIPTION
  Task name: ThronefallCoachSupervisor. Runs as the current user, hidden, at logon and every minute afterwards, so the coach server
  (incident watchdog + MiniMax wake + scheduler) is always brought back within about a minute after a crash or a reboot.
  No admin rights needed. Remove with:  pwsh -File tools\install-supervisor.ps1 -Remove
#>
param([switch]$Remove, [string]$TaskName = 'ThronefallCoachSupervisor')
$ErrorActionPreference = 'Stop'
if ($Remove) {
    if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) { Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false; "removed $TaskName" } else { "$TaskName is not installed" }
    return
}
$script = Join-Path $PSScriptRoot 'coach-supervisor.ps1'
$pwsh = (Get-Command pwsh -ErrorAction SilentlyContinue)
$exe = if ($pwsh) { $pwsh.Source } else { (Get-Command powershell).Source }
$arg = '-NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File "{0}" -Once' -f $script
$action = New-ScheduledTaskAction -Execute $exe -Argument $arg
$logon = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
$every = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes 1)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -MultipleInstances IgnoreNew -ExecutionTimeLimit (New-TimeSpan -Minutes 2)
Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger @($logon, $every) -Settings $settings -Description 'Keeps the Thronefall coach server (incident watchdog, MiniMax wake, scheduler) alive' -Force | Out-Null
Get-ScheduledTask -TaskName $TaskName | Select-Object TaskName, State | Format-Table -AutoSize | Out-String
"installed: runs every minute as $env:USERNAME; state file agent\supervisor.json"
