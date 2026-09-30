using System;
using System.Collections.Generic;

namespace ThronefallTrainer;

internal static class BotBrain
{
	private const float ArriveCoin = 0.6f;

	private const float ArriveHold = 2.5f;

	public static DecideResult Decide(in SnapshotData s, ref BotMemory m, float now, bool legit, in PolicyTable pol)
	{
		DecideResult r = new DecideResult
		{
			Mode = m.Mode,
			Intents = new List<Intent>(),
			Notes = new List<string>(),
			RulesFired = (pol.firedIds ?? new List<string>())
		};
		if (m.HeldBuild >= 0)
		{
			bool flag = !s.HasBuild || s.BuildKey != m.HeldBuild;
			m.HeldMisses = (flag ? (m.HeldMisses + 1) : 0);
			float num = ((s.BuildName != null && (s.BuildName.IndexOf("castle", StringComparison.OrdinalIgnoreCase) >= 0 || s.BuildName.IndexOf("hall", StringComparison.OrdinalIgnoreCase) >= 0)) ? 12f : 5.5f);
			if ((flag && m.HeldMisses >= 3) || (s.BuildDist > num && (!s.HasBuildStand || !(s.BuildStandDist <= 3f))))
			{
				r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
				m.HeldBuild = -1;
				m.HeldMisses = 0;
				m.SlotVisitKey = -1;
			}
		}
		bool flag2 = s.GameState == "InMatch" && m.PrevGameState != "InMatch";
		m.PrevGameState = s.GameState;
		if (((!string.IsNullOrEmpty(s.SceneName) && s.SceneName != m.DayScene) || (s.Wave <= 0 && m.PrevWave > 0) || m.DayStartAt <= 0f) | flag2)
		{
			m.DayScene = s.SceneName;
			m.DayStartAt = now;
			m.NightRequestAt = 0f;
			m.ArmyPhase = 0;
		}
		m.PrevWave = s.Wave;
		bool flag3 = now - m.DayStartAt < 45f;
		if (m.LastNightState != s.IsNight)
		{
			m.NightRequestAt = 0f;
			m.LastNightState = s.IsNight;
			if (!s.IsNight)
			{
				m.ArmyPhase = 0;
				m.DayStartAt = now;
				r.Intents.Add(Intent.Of(IntentKind.ClearCoinPark));
			}
		}
		if (s.HasLevel)
		{
			m.Mode = BotMode.EnterLevel;
			r.Mode = m.Mode;
			r.HasAim = false;
			if (!s.SceneBusy)
			{
				m.BusySince = -1f;
			}
			else if (m.BusySince < 0f)
			{
				m.BusySince = now;
			}
			bool flag4 = m.BusySince >= 0f && now - m.BusySince > 30f;
			if (now >= m.LevelInteractAt && (!s.SceneBusy | flag4))
			{
				m.LevelInteractAt = now + 2f;
				r.Notes.Add("level-interact");
				r.Intents.Add(Intent.Of(IntentKind.SeedLoadout));
				if (flag4)
				{
					r.Intents.Add(Intent.Of(IntentKind.InteractLevel));
					r.Notes.Add("busy-hung");
				}
				else
				{
					r.Intents.Add(Intent.Of(IntentKind.TransitionLevel));
				}
				r.Notes.Add("transition-level");
			}
			return r;
		}
		if (s.HeroDead || s.HeroHpPct <= 0f)
		{
			m.Mode = BotMode.HeroDead;
			r.Mode = m.Mode;
			if (m.HeldBuild >= 0)
			{
				r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
				m.HeldBuild = -1;
				m.SlotVisitKey = -1;
			}
			if (s.HasCastleStand)
			{
				Aim(ref r, s.CastleStandPos, 2.5f);
			}
			else if (s.HasCastle)
			{
				Aim(ref r, Vec2.StandOff(s.CastlePos, s.HeroPos, 4f), 2.5f);
			}
			else
			{
				r.HasAim = false;
			}
			return r;
		}
		if (s.IsNight && !s.RedAlert && !s.HasCastleThreat && s.NearFoeCount == 0 && (!s.HasNearEnemy || s.NearEnemyDist > 12f) && s.HasCoin && s.CoinDist <= pol.K("coin_seek") * 1.5f)
		{
			m.Mode = BotMode.CollectCoin;
			r.Mode = m.Mode;
			Aim(ref r, s.CoinPos, 0.6f);
			return r;
		}
		if (s.IsNight)
		{
			if (legit && s.HasUncoveredDoor && s.UncoveredDoorHot && s.FreeUnits >= 2 && now - m.LastSquadAt > 6f)
			{
				m.LastSquadAt = now;
				r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
				r.Notes.Add("squad-door:" + s.UncoveredDoorLine);
			}
			else if (legit && s.HasUncoveredDoor && !s.RedAlert && s.FreeUnits >= s.UncoveredDoorTarget && now - m.LastSquadAt > 4f)
			{
				m.LastSquadAt = now;
				r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
				r.Notes.Add("squad-post:" + s.UncoveredDoorLine);
			}
			if (s.RedAlert && s.HasThreatAnchor)
			{
				if (s.AllyCount > 0 && now - m.LastBreachAt > 8f)
				{
					m.LastBreachAt = now;
					r.Intents.Add(Intent.Of(IntentKind.RecallToBreach));
					r.Notes.Add("breach-response");
				}
				if ((s.HasNearEnemy && s.NearEnemyDist <= ((s.SelfDefendRange > 0f) ? s.SelfDefendRange : 7f)) || s.NearFoeCount >= 2)
				{
					m.Mode = BotMode.Engage;
					r.Mode = m.Mode;
					m.Pursue = (r.Pursue = 1);
					Aim(ref r, s.ThreatAnchor, 1.5f);
					r.Intents.Add(Intent.Of(IntentKind.PumpAttack));
					r.Notes.Add("red-alert");
				}
				else
				{
					m.Mode = BotMode.HoldCastle;
					r.Mode = m.Mode;
					Vec2 vec = s.CastlePos - s.ThreatAnchor;
					Vec2 vec2 = ((vec.SqrMag > 0.01f) ? (s.CastlePos + vec.Norm * 5f) : s.CastlePos);
					Aim(ref r, s.HasCastleStand ? s.CastleStandPos : vec2, 2.5f);
					r.Notes.Add("red-hold");
				}
				return r;
			}
			if (s.HasCastleThreat)
			{
				_ = 1;
			}
			else
				_ = s.HasNearEnemy;
			Vec2 vec3 = (s.HasCastleThreat ? s.CastleThreatPos : s.NearEnemyPos);
			Vec2 vec4 = (s.HasThreatAnchor ? (s.ThreatAnchor - s.CastlePos) : Vec2.Zero);
			if ((s.HasNearEnemy && s.NearEnemyDist <= ((s.SelfDefendRange > 0f) ? s.SelfDefendRange : 7f)) || s.NearFoeCount >= 2)
			{
				if (legit && s.HeroHpPct < pol.K("retreat_hp") && s.HasCastle)
				{
					m.Mode = BotMode.ReturnHome;
					r.Mode = m.Mode;
					m.Pursue = (r.Pursue = (s.HasCastleThreat ? 1 : 2));
					Aim(ref r, Vec2.StandOff(s.CastlePos, s.HeroPos, 3f), 2.5f);
					r.Intents.Add(Intent.Of(IntentKind.PumpAttack));
					return r;
				}
				m.Mode = BotMode.Engage;
				r.Mode = m.Mode;
				bool flag5 = s.HasCastleThreat && s.CastleThreatDist < 20f;
				m.Pursue = (r.Pursue = ((flag5 || !s.HasNearEnemy) ? 1 : 2));
				bool flag6 = s.ActiveRange >= 6f;
				float num2 = (s.HasNearEnemy ? s.NearEnemyDist : float.MaxValue);
				if (flag6 && s.HasCastle)
				{
					float num3 = Math.Max(pol.K("pull_near"), s.NearEnemyRange + pol.K("pull_foe_pad"));
					if (num2 < num3 || s.NearFoeCount >= (int)pol.K("pull_swarm"))
					{
						Vec2 vec5 = s.CastlePos - s.NearEnemyPos;
						Vec2 vec6 = ((vec5.SqrMag > 0.01f) ? vec5.Norm : Vec2.Perp((vec4.SqrMag > 0.01f) ? vec4.Norm : new Vec2(1f, 0f)));
						Aim(ref r, s.CastlePos + vec6 * 4f, 1.2f);
					}
					else
					{
						float num4 = ((m.LastOrbitAt > 0f) ? Math.Min(now - m.LastOrbitAt, 0.5f) : 0.25f);
						m.LastOrbitAt = now;
						m.OrbitAngle += pol.K("orbit_spin") * m.OrbitDir * num4;
						float num5 = pol.K("orbit_arc");
						if (m.OrbitAngle > num5)
						{
							m.OrbitAngle = num5;
							m.OrbitDir = -1f;
						}
						else if (m.OrbitAngle < 0f - num5)
						{
							m.OrbitAngle = 0f - num5;
							m.OrbitDir = 1f;
						}
						Vec2 vec7 = ((vec4.SqrMag > 0.01f) ? vec4.Norm : new Vec2(0f, 1f));
						Vec2 vec8 = s.CastlePos - vec7 * 3f;
						float num6 = Clamp(Math.Max(s.ActiveRange * 0.3f, s.NearEnemyRange + pol.K("kite_foe_pad")), pol.K("kite_r_min"), pol.K("kite_r_max"));
						Vec2 pos = vec8 + (vec7 * (0f - (float)Math.Cos(m.OrbitAngle)) + Vec2.Perp(vec7) * (float)Math.Sin(m.OrbitAngle)) * num6;
						Aim(ref r, pos, 1.5f);
						r.ProjectToNav = true;
					}
				}
				else if (s.NearFoeCount >= 3 || num2 < 1.8f)
				{
					Vec2 vec9 = s.HeroPos - s.NearEnemyPos;
					if (vec9.SqrMag < 0.01f)
					{
						vec9 = s.HeroPos - vec3;
					}
					Vec2 vec10 = (s.HasCastle ? (s.CastlePos - s.HeroPos) : Vec2.Zero);
					Vec2 norm = (vec9.Norm * 0.7f + vec10.Norm * 0.3f).Norm;
					Aim(ref r, s.HeroPos + norm * pol.K("melee_pull"), 1.2f);
				}
				else
				{
					Vec2 point = ((m.Pursue == 2 && s.HasNearEnemy) ? s.NearEnemyPos : vec3);
					Aim(ref r, Vec2.StandOff(point, s.HeroPos, 1.2f), 1f);
				}
				r.Intents.Add(Intent.Of(IntentKind.PumpAttack));
				if (s.AllyCount > 0 && s.CanCommand && now - m.LastArmyCmdAt > 25f)
				{
					m.LastArmyCmdAt = now;
					r.Intents.Add(Intent.Of(IntentKind.CommandArmy));
					r.Intents.Add(Intent.Of(IntentKind.PlaceArmy));
					r.Notes.Add("escort");
				}
			}
			else if (s.HasCastle)
			{
				m.Mode = BotMode.HoldCastle;
				r.Mode = m.Mode;
				if (s.HasUncoveredDoor && s.UncoveredDoorHot)
				{
					Aim(ref r, s.UncoveredDoorPos, 2.5f);
				}
				else
				{
					Aim(ref r, s.HasThreatAnchor ? s.ThreatAnchor : s.CastlePos, 2.5f);
				}
				if (s.FreeUnits > 0 && s.CanCommand && now - m.LastEscortAt > 20f)
				{
					m.LastEscortAt = now;
					r.Intents.Add(Intent.Of(IntentKind.EscortHero));
					r.Notes.Add("escort-refresh");
				}
				if (s.AllyCount > 0 && s.CanCommand && now - m.LastArmyCmdAt > 60f)
				{
					m.LastArmyCmdAt = now;
					r.Intents.Add(Intent.Of(IntentKind.CommandArmy));
					r.Intents.Add(Intent.Of(IntentKind.PlaceArmy));
					r.Notes.Add("army-reposition");
				}
			}
			else
			{
				m.Mode = BotMode.Idle;
				r.Mode = m.Mode;
				r.HasAim = false;
			}
			return r;
		}
		if (m.DayStartAt > 0f && !flag3 && ((s.CanSwitch && (s.NightCall || (s.ArmyTarget > 0 && s.AllyCount >= s.ArmyTarget && (s.DoorCount == 0 || s.DoorsCovered > 0)) || (s.DoorCount > 0 && s.DoorsCovered >= s.DoorCount && s.AllyCount > 0))) || now - m.DayStartAt > ((s.DayBudget > 0f) ? s.DayBudget : 240f)))
		{
			m.Mode = BotMode.StartNight;
			r.Mode = m.Mode;
			if (m.HeldBuild >= 0)
			{
				r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
				m.HeldBuild = -1;
				m.SlotVisitKey = -1;
			}
			if (s.HasHorn)
			{
				Aim(ref r, s.HornPos, 2f);
				if (s.HornDist <= 2.8f && now >= m.HornInteractAt)
				{
					m.HornInteractAt = now + 2f;
					r.Intents.Add(Intent.Of(IntentKind.HornInteract));
					r.Notes.Add("horn-interact");
				}
			}
			else if ((s.SceneName == null || !s.SceneName.StartsWith("_")) && now >= m.NightRequestAt)
			{
				m.NightRequestAt = now + 15f;
				r.Notes.Add("switch-night");
				r.Intents.Add(Intent.Of(IntentKind.SwitchNight));
			}
			return r;
		}
		if (legit)
		{
			if (s.HasUncoveredDoor && s.FreeUnits >= (s.UncoveredDoorHot ? 2 : Math.Max(4, s.UncoveredDoorTarget)) && now - m.LastSquadAt > 6f)
			{
				m.LastSquadAt = now;
				r.Intents.Add(Intent.Of(IntentKind.PlaceSquad));
				r.Notes.Add("squad-door:" + s.UncoveredDoorLine);
			}
			if (s.FreeUnits > 0 && now - m.LastEscortAt > 20f)
			{
				m.LastEscortAt = now;
				r.Intents.Add(Intent.Of(IntentKind.EscortHero));
				r.Notes.Add("escort-refresh");
			}
		}
		float num7 = ((s.FinalWaveNext || (float)s.NextWaveCount >= pol.K("big_wave_nwc")) ? pol.K("coin_seek_big") : pol.K("coin_seek"));
		if ((float)s.Balance < 10f)
		{
			num7 *= 1.5f;
		}
		if (s.HasCoin && s.CoinDist <= num7)
		{
			m.Mode = BotMode.CollectCoin;
			r.Mode = m.Mode;
			Aim(ref r, s.CoinPos, 0.6f);
			return r;
		}
		if (m.HeldBuild >= 0 && s.HeldBuildComplete)
		{
			r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
			m.HeldBuild = -1;
			m.SlotVisitKey = -1;
			r.Notes.Add("build-done");
			return r;
		}
		if (s.HasBuild && (s.Balance > 0 || s.BuildHarvest))
		{
			m.Mode = BotMode.SpendGold;
			r.Mode = m.Mode;
			string text = s.BuildName ?? "";
			bool flag7 = text.IndexOf("castle", StringComparison.OrdinalIgnoreCase) >= 0 || text.IndexOf("hall", StringComparison.OrdinalIgnoreCase) >= 0;
			bool flag8 = s.BuildDist <= (flag7 ? 10f : 4f) || (s.HasBuildStand && s.BuildStandDist <= 1.2f);
			if (flag8)
			{
				Aim(ref r, s.HeroPos, 1f);
			}
			else if (s.HasBuildStand)
			{
				Aim(ref r, s.BuildStandPos, 0.8f);
			}
			else
			{
				Aim(ref r, Vec2.StandOff(s.BuildPos, s.HeroPos, flag7 ? 6f : 3f), 1f);
			}
			if (flag8 && s.BuildKey >= 0)
			{
				if (s.BuildKey != m.SlotVisitKey)
				{
					m.SlotVisitKey = s.BuildKey;
					m.SlotVisitSince = now;
				}
				else if (now - m.SlotVisitSince >= 10f)
				{
					r.Intents.Add(Intent.Of(IntentKind.ParkSlot));
					r.Notes.Add("slot-abandon");
					if (m.HeldBuild >= 0)
					{
						r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
						m.HeldBuild = -1;
					}
					m.SlotVisitKey = -1;
					m.SlotVisitSince = now;
					return r;
				}
			}
			if (flag8 && now >= m.BuildInteractAt)
			{
				m.BuildInteractAt = now + 0.4f;
				if (m.HeldBuild < 0)
				{
					r.Intents.Add(Intent.Of(IntentKind.BeginHold));
					m.HeldBuild = s.BuildKey;
					m.SpendWatchGold = s.Balance;
					m.SpendWatchCores = s.CoreBalance;
					m.SpendWatchAt = now + 7f;
				}
				else if (s.Balance != m.SpendWatchGold || s.CoreBalance != m.SpendWatchCores)
				{
					r.Notes.Add("pay");
					m.SpendWatchGold = s.Balance;
					m.SpendWatchCores = s.CoreBalance;
					m.SpendWatchAt = now + 7f;
					m.SlotVisitSince = now;
				}
				else if (now >= m.SpendWatchAt)
				{
					r.Notes.Add("build-stall");
					r.Intents.Add(Intent.Of(IntentKind.ParkSlot));
					r.Intents.Add(Intent.Of(IntentKind.ReleaseHold));
					m.HeldBuild = -1;
					m.SlotVisitKey = -1;
					return r;
				}
				r.Intents.Add(Intent.Of(IntentKind.PumpHold));
				if (now >= m.NextHoldNoteAt)
				{
					m.NextHoldNoteAt = now + 3f;
					r.Notes.Add("build-hold");
				}
			}
			return r;
		}
		if (legit && m.ArmyPhase < 2 && s.AllyCount > 0 && s.HasCastle && s.CanCommand)
		{
			if (m.ArmyPhase == 0)
			{
				r.Intents.Add(Intent.Of(IntentKind.CommandArmy));
				m.ArmyPhase = 1;
				m.ArmyWalkAt = now + 8f;
			}
			m.Mode = BotMode.PositionArmy;
			r.Mode = m.Mode;
			Vec2 vec11;
			if (s.HasArmyAnchor)
			{
				vec11 = s.ArmyAnchor;
				if (s.ArmyAnchorLine != m.LastArmyLine || now >= m.ArmyLineNoteAt)
				{
					m.LastArmyLine = s.ArmyAnchorLine;
					m.ArmyLineNoteAt = now + 10f;
					r.Notes.Add("army-line:" + s.ArmyAnchorLine);
				}
			}
			else
			{
				Vec2 vec12 = (s.HasThreatAnchor ? (s.ThreatAnchor - s.CastlePos) : Vec2.Zero);
				vec11 = ((vec12.SqrMag > 0.01f) ? (s.CastlePos + vec12.Norm * pol.K("army_anchor")) : s.CastlePos);
			}
			Aim(ref r, vec11, 3f);
			if (Vec2.Dist(s.HeroPos, vec11) <= 4f || now >= m.ArmyWalkAt)
			{
				r.Intents.Add(Intent.Of(IntentKind.PlaceArmy));
				m.ArmyPhase = 2;
				r.Notes.Add("army-placed");
			}
			return r;
		}
		bool flag9 = m.DayStartAt > 0f && !flag3 && (s.NightCall || (s.ArmyTarget > 0 && s.AllyCount >= s.ArmyTarget && (s.DoorCount == 0 || s.DoorsCovered > 0)) || (s.DoorCount > 0 && s.DoorsCovered >= s.DoorCount && s.AllyCount > 0) || now - m.DayStartAt > ((s.DayBudget > 0f) ? s.DayBudget : 240f));
		if (flag9 && s.HasHorn)
		{
			m.Mode = BotMode.StartNight;
			r.Mode = m.Mode;
			Aim(ref r, s.HornPos, 2f);
			if (s.HornDist <= 2.8f && now >= m.HornInteractAt)
			{
				m.HornInteractAt = now + 2f;
				r.Intents.Add(Intent.Of(IntentKind.HornInteract));
				r.Notes.Add("horn-interact");
			}
			return r;
		}
		if (flag9 && s.CanSwitch && now >= m.NightRequestAt && (s.SceneName == null || !s.SceneName.StartsWith("_")))
		{
			m.NightRequestAt = now + 15f;
			r.Notes.Add("switch-night");
			r.Intents.Add(Intent.Of(IntentKind.SwitchNight));
			m.Mode = BotMode.StartNight;
			r.Mode = m.Mode;
			return r;
		}
		if (s.HasUncoveredDoor)
		{
			m.Mode = BotMode.PositionArmy;
			r.Mode = m.Mode;
			Vec2 pos2 = s.UncoveredDoorPos;
			if (s.HasCastle)
			{
				Vec2 vec13 = s.CastlePos - s.UncoveredDoorPos;
				if (vec13.Mag > 2f)
				{
					pos2 = s.UncoveredDoorPos + vec13.Norm * 14f;
				}
			}
			Aim(ref r, pos2, 2.5f);
			r.Notes.Add("hero-door:" + s.UncoveredDoorLine);
			return r;
		}
		if (s.HasCastle && s.CastleDist > pol.K("home_radius"))
		{
			m.Mode = BotMode.ReturnHome;
			r.Mode = m.Mode;
			if (s.HasCastleStand)
			{
				Aim(ref r, s.CastleStandPos, 2.5f);
			}
			else
			{
				Aim(ref r, Vec2.StandOff(s.CastlePos, s.HeroPos, 4f), 2.5f);
			}
			return r;
		}
		m.Mode = BotMode.Idle;
		r.Mode = m.Mode;
		r.HasAim = false;
		return r;
	}

	private static void Aim(ref DecideResult r, Vec2 pos, float arrive)
	{
		r.AimPos = pos;
		r.Arrive = arrive;
		r.HasAim = true;
	}

	private static float Clamp(float v, float lo, float hi)
	{
		if (!(v < lo))
		{
			if (!(v > hi))
			{
				return v;
			}
			return hi;
		}
		return lo;
	}
}
