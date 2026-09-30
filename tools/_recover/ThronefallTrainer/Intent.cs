namespace ThronefallTrainer;

internal struct Intent
{
	public IntentKind Kind;

	public int Index;

	public bool CheatOnly;

	public static Intent Of(IntentKind k)
	{
		return new Intent
		{
			Kind = k,
			Index = -1
		};
	}

	public static Intent At(IntentKind k, int i)
	{
		return new Intent
		{
			Kind = k,
			Index = i
		};
	}

	public static Intent Cheat(IntentKind k)
	{
		return new Intent
		{
			Kind = k,
			Index = -1,
			CheatOnly = true
		};
	}
}
