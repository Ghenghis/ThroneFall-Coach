using System;

namespace ThronefallTrainer;

[Serializable]
public class SlotPackRec
{
	public int id;

	public string name;

	public float[] pos;

	public StandPtRec[] stands;
}
