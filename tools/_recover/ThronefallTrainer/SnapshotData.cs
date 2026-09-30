using System.Globalization;
using System.Text;

namespace ThronefallTrainer;

internal struct SnapshotData
{
	public bool Valid;

	public string GameState;

	public string SceneName;

	public Vec2 HeroPos;

	public float HeroHpPct;

	public bool HeroDead;

	public int Balance;

	public int CoreBalance;

	public bool IsNight;

	public float DayTimeLeft;

	public int Wave;

	public int WaveTotal;

	public int EnemyCount;

	public bool HasCoin;

	public Vec2 CoinPos;

	public float CoinDist;

	public int CoinCount;

	public bool HasNearEnemy;

	public Vec2 NearEnemyPos;

	public float NearEnemyDist;

	public int NearFoeCount;

	public bool HasCastle;

	public Vec2 CastlePos;

	public float CastleDist;

	public bool HasCastleThreat;

	public Vec2 CastleThreatPos;

	public float CastleThreatDist;

	public bool HasThreatAnchor;

	public Vec2 ThreatAnchor;

	public bool HasArmyAnchor;

	public Vec2 ArmyAnchor;

	public string ArmyAnchorLine;

	public int DoorCount;

	public int DoorsCovered;

	public int FreeUnits;

	public bool HasUncoveredDoor;

	public Vec2 UncoveredDoorPos;

	public string UncoveredDoorLine;

	public int UncoveredDoorTarget;

	public bool UncoveredDoorHot;

	public int ArmyTarget;

	public float SelfDefendRange;

	public float DayBudget;

	public bool RedAlert;

	public float RedAlertRadius;

	public bool OnLevelSelect;

	public int InteractorCount;

	public int LevelCount;

	public bool HasLevel;

	public Vec2 LevelPos;

	public float LevelDist;

	public bool SceneBusy;

	public bool HasHorn;

	public Vec2 HornPos;

	public float HornDist;

	public int BuildCount;

	public bool HasBuild;

	public int BuildKey;

	public string BuildName;

	public Vec2 BuildPos;

	public float BuildDist;

	public int BuildScore;

	public bool BuildHarvest;

	public bool HeldBuildComplete;

	public int AllyCount;

	public Vec2 AllyCentroid;

	public bool CanCommand;

	public bool CanSwitch;

	public bool NightCall;

	public bool HasWeapon;

	public float ActiveRange;

	public bool ActiveFiresMoving;

	public int NextWaveCount;

	public int NextWaveElites;

	public float NextWaveMaxHp;

	public float NextWaveSpeed;

	public float NextWaveFoeRange;

	public int NextWaveGold;

	public bool FinalWaveNext;

	public float NearEnemyRange;

	public float NearEnemyHp;

	public bool NearEnemyElite;

	public float CastleHpPct;

	public bool WaveBeforeFinalNext;

	public int ShrineCount;

	public Vec2 ShrinePos;

	public float ShrineDist;

	public int BuildMil;

	public int BuildInc;

	public bool HasBuildStand;

	public Vec2 BuildStandPos;

	public float BuildStandDist;

	public bool HasCastleStand;

	public Vec2 CastleStandPos;

	public string ToJson(string note, float t, BotMode mode)
	{
		CultureInfo invariantCulture = CultureInfo.InvariantCulture;
		StringBuilder stringBuilder = new StringBuilder(420);
		stringBuilder.Append("{\"t\":").Append(t.ToString("0.00", invariantCulture)).Append(",\"mode\":\"")
			.Append(mode)
			.Append("\"")
			.Append(",\"state\":\"")
			.Append(GameState)
			.Append("\"")
			.Append(",\"scene\":\"")
			.Append(Esc(SceneName))
			.Append("\"")
			.Append(",\"night\":")
			.Append(IsNight ? "true" : "false")
			.Append(",\"wave\":\"")
			.Append(Wave)
			.Append('/')
			.Append(WaveTotal)
			.Append("\"")
			.Append(",\"foes\":")
			.Append(EnemyCount)
			.Append(",\"coins\":")
			.Append(CoinCount)
			.Append(",\"gold\":")
			.Append(Balance)
			.Append(",\"hp\":")
			.Append(HeroHpPct.ToString("0.###", invariantCulture))
			.Append(",\"pos\":[")
			.Append(HeroPos.X.ToString("0.#", invariantCulture))
			.Append(',')
			.Append(HeroPos.Z.ToString("0.#", invariantCulture))
			.Append(']')
			.Append(",\"note\":\"")
			.Append(Esc(note))
			.Append('"');
		Append(stringBuilder, ",\"dead\":", HeroDead);
		Append(stringBuilder, ",\"cbal\":", CoreBalance);
		Append(stringBuilder, ",\"dtl\":", DayTimeLeft, invariantCulture);
		Append(stringBuilder, ",\"cpos\":", CoinPos, HasCoin, invariantCulture);
		Append(stringBuilder, ",\"cd\":", CoinDist, invariantCulture);
		Append(stringBuilder, ",\"epos\":", NearEnemyPos, HasNearEnemy, invariantCulture);
		Append(stringBuilder, ",\"ed\":", NearEnemyDist, invariantCulture);
		Append(stringBuilder, ",\"nf\":", NearFoeCount);
		Append(stringBuilder, ",\"cast\":", CastlePos, HasCastle, invariantCulture);
		Append(stringBuilder, ",\"cad\":", CastleDist, invariantCulture);
		Append(stringBuilder, ",\"cthp\":", CastleThreatPos, HasCastleThreat, invariantCulture);
		Append(stringBuilder, ",\"cthd\":", CastleThreatDist, invariantCulture);
		Append(stringBuilder, ",\"ta\":", ThreatAnchor, HasThreatAnchor, invariantCulture);
		Append(stringBuilder, ",\"ls\":", OnLevelSelect);
		Append(stringBuilder, ",\"inter\":", InteractorCount);
		Append(stringBuilder, ",\"lvln\":", LevelCount);
		Append(stringBuilder, ",\"lvlp\":", LevelPos, HasLevel, invariantCulture);
		Append(stringBuilder, ",\"lvld\":", LevelDist, invariantCulture);
		Append(stringBuilder, ",\"busy\":", SceneBusy);
		Append(stringBuilder, ",\"hpos\":", HornPos, HasHorn, invariantCulture);
		Append(stringBuilder, ",\"hd\":", HornDist, invariantCulture);
		Append(stringBuilder, ",\"bld\":", BuildCount);
		Append(stringBuilder, ",\"bldk\":", BuildKey);
		stringBuilder.Append(",\"bn\":\"").Append(Esc(BuildName)).Append('"');
		Append(stringBuilder, ",\"bpos\":", BuildPos, HasBuild, invariantCulture);
		Append(stringBuilder, ",\"bd\":", BuildDist, invariantCulture);
		Append(stringBuilder, ",\"bsc\":", BuildScore);
		Append(stringBuilder, ",\"bharv\":", BuildHarvest);
		Append(stringBuilder, ",\"ally\":", AllyCount);
		Append(stringBuilder, ",\"free\":", FreeUnits);
		Append(stringBuilder, ",\"drc\":", DoorsCovered);
		Append(stringBuilder, ",\"drn\":", DoorCount);
		Append(stringBuilder, ",\"ra\":", RedAlert);
		Append(stringBuilder, ",\"at\":", ArmyTarget);
		Append(stringBuilder, ",\"hot\":", UncoveredDoorHot);
		Append(stringBuilder, ",\"dbg\":", DayBudget, invariantCulture);
		Append(stringBuilder, ",\"acen\":", AllyCentroid, AllyCount > 0, invariantCulture);
		Append(stringBuilder, ",\"cmd\":", CanCommand);
		Append(stringBuilder, ",\"csw\":", CanSwitch);
		Append(stringBuilder, ",\"weap\":", HasWeapon);
		Append(stringBuilder, ",\"wrng\":", ActiveRange, invariantCulture);
		Append(stringBuilder, ",\"wfm\":", ActiveFiresMoving);
		Append(stringBuilder, ",\"nwc\":", NextWaveCount);
		Append(stringBuilder, ",\"nwe\":", NextWaveElites);
		Append(stringBuilder, ",\"nwh\":", NextWaveMaxHp, invariantCulture);
		Append(stringBuilder, ",\"nws\":", NextWaveSpeed, invariantCulture);
		Append(stringBuilder, ",\"nwr\":", NextWaveFoeRange, invariantCulture);
		Append(stringBuilder, ",\"nwg\":", NextWaveGold);
		Append(stringBuilder, ",\"fw\":", FinalWaveNext);
		Append(stringBuilder, ",\"erng\":", NearEnemyRange, invariantCulture);
		Append(stringBuilder, ",\"ehp\":", NearEnemyHp, invariantCulture);
		Append(stringBuilder, ",\"eel\":", NearEnemyElite);
		Append(stringBuilder, ",\"chp\":", CastleHpPct, invariantCulture);
		Append(stringBuilder, ",\"wbf\":", WaveBeforeFinalNext);
		Append(stringBuilder, ",\"shr\":", ShrineCount);
		Append(stringBuilder, ",\"shp\":", ShrinePos, ShrineCount > 0, invariantCulture);
		Append(stringBuilder, ",\"shd\":", ShrineDist, invariantCulture);
		Append(stringBuilder, ",\"bmil\":", BuildMil);
		Append(stringBuilder, ",\"binc\":", BuildInc);
		Append(stringBuilder, ",\"bst\":", HasBuildStand);
		Append(stringBuilder, ",\"bsp\":", BuildStandPos, HasBuildStand, invariantCulture);
		Append(stringBuilder, ",\"bsd\":", BuildStandDist, invariantCulture);
		Append(stringBuilder, ",\"cst\":", HasCastleStand);
		Append(stringBuilder, ",\"csp\":", CastleStandPos, HasCastleStand, invariantCulture);
		return stringBuilder.Append('}').ToString();
	}

	private static string Esc(string v)
	{
		if (!string.IsNullOrEmpty(v))
		{
			return v.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\n", "\\n")
				.Replace("\r", "\\r")
				.Replace("\t", "\\t");
		}
		return "";
	}

	private static void Append(StringBuilder sb, string key, bool v)
	{
		sb.Append(key).Append(v ? "true" : "false");
	}

	private static void Append(StringBuilder sb, string key, int v)
	{
		sb.Append(key).Append(v);
	}

	private static void Append(StringBuilder sb, string key, float v, CultureInfo ci)
	{
		sb.Append(key).Append(v.ToString("0.###", ci));
	}

	private static void Append(StringBuilder sb, string key, Vec2 p, bool present, CultureInfo ci)
	{
		sb.Append(key);
		if (!present)
		{
			sb.Append("null");
		}
		else
		{
			sb.Append('[').Append(p.X.ToString("0.#", ci)).Append(',')
				.Append(p.Z.ToString("0.#", ci))
				.Append(']');
		}
	}
}
