# Changelog

## Unreleased — campaign autopilot (2026-09)

Full campaign autopilot, verified end-to-end live (30k+ telemetry lines):

- **FSM bot (F6)**: `Idle / CollectCoin / ReturnHome / HoldCastle / Engage /
  EnterLevel / StartNight / SpendGold / ResolveUI`; steering injected via
  Harmony prefix on `MoveScript`.
- **Campaign loop**: title → level-select map → nearest unbeaten
  `LevelInteractor` (else nearest playable) → match → victory frame → repeat.
- **Blocking-frame resolver**: `ChoiceManager` picks auto-resolved *before* the
  `freezePlayer` gate (unframed pending choices deadlocked holds), perk frames
  auto-pick first unselected `PerkSelectionItem`, end-of-match detection via
  `BackToLevelSelectHelper` with `frameSeen` escalation, generic close/apply.
- **Day economy**: `Focus` harvests + `InteractionBegin`/`InteractionHold`
  hold-to-pay on `BuildingInteractor`s; gold actually drains now.
- **Spend-stall fix**: 7 s no-payment watch → dead slot parked on `buildIgnore`
  for the rest of the day (cleared at dusk) → candidate pool drains →
  `Nighthorn`/`DayNightCycle.SwitchToNight()` fallback fires.
- **Stuck watchdog**: 3-strike teleport nudge only when aim distance isn't
  closing (no more jerk mid-pursuit).
- **Survival bundle**: F6 applies god/regen/magnet/instant-kill/no-cooldown and
  restores prior cheat states on toggle-off (`Bot.BotSurvivalCheats`, default on).
- **Telemetry**: `BepInEx\plugins\bot-log.jsonl` — ~4 Hz snapshot lines +
  one-shot notes (`build-stall`, `choice-pick`, `switch-night`, …).
- **Docs**: `AUTOPILOT.md` (status/issues/handoff), `CONFIG.md` (all 48 keys),
  `BOT-DEV.md` (extension guide), `TESTING.md` (e2e checklist),
  README autopilot sections.

Known issues carried forward: straight-line steering wedges on building
colliders (nudges recover), `frameSeen` escalation can exit a run if a pause
frame embeds `BackToLevelSelectHelper`, cheat-dependent combat. See
AUTOPILOT §8–9 for the full list and next actions.

## fd4841e — initial trainer (first commit)

- BepInEx plugin, IMGUI overlay (F1), themes/opacity.
- Cheat set: protection (god/instant-revive/never-lose), economy
  (free/instant build, magnet), combat (instant-kill, mults, multi-shot,
  regen, no-cooldown), enemies (speed/damage/HP scaling, endless waves),
  army (command range, respawn, ally mults), world/time (speed, endless day),
  camera (zoom, reveal), meta/progression save writers.
- Harmony patches on `Hp.TakeDamage`, `PlayerInteraction.SpendCoins`/
  `SpendEnergyCores`, `Coinslot.AddFill`, `Hp.Start`,
  `LocalGamestate.SetState`, `Weapon.Attack`.
- `tools\build-and-deploy.ps1`, `tools\decompile.ps1`, ilspycmd reference dumps.
