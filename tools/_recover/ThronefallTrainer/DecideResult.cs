using System.Collections.Generic;

namespace ThronefallTrainer;

internal struct DecideResult
{
	public BotMode Mode;

	public Vec2 AimPos;

	public bool HasAim;

	public float Arrive;

	public bool ProjectToNav;

	public int Pursue;

	public List<Intent> Intents;

	public List<string> Notes;

	public List<string> RulesFired;
}
