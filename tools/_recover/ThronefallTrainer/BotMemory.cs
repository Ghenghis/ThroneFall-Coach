namespace ThronefallTrainer;

internal struct BotMemory
{
	public BotMode Mode;

	public int HeldBuild;

	public int HeldMisses;

	public float BuildInteractAt;

	public int SpendWatchGold;

	public int SpendWatchCores;

	public float SpendWatchAt;

	public float NextHoldNoteAt;

	public bool LastNightState;

	public float NightRequestAt;

	public float HornInteractAt;

	public float LevelInteractAt;

	public int ArmyPhase;

	public float ArmyWalkAt;

	public float LastSquadAt;

	public float LastBreachAt;

	public float DayStartAt;

	public string DayScene;

	public string PrevGameState;

	public string LastArmyLine;

	public float ArmyLineNoteAt;

	public int PrevWave;

	public float SquadWalkAt;

	public float LastEscortAt;

	public int SlotVisitKey;

	public float SlotVisitSince;

	public float BusySince;

	public float LastArmyCmdAt;

	public float OrbitAngle;

	public float OrbitDir;

	public float LastOrbitAt;

	public int Pursue;

	public static BotMemory Fresh()
	{
		return new BotMemory
		{
			Mode = BotMode.Idle,
			HeldBuild = -1,
			BusySince = -1f,
			SlotVisitKey = -1,
			OrbitDir = 1f,
			LastNightState = true,
			ArmyPhase = 0
		};
	}
}
