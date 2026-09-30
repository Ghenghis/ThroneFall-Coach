using System;

namespace ThronefallTrainer;

internal struct Vec2(float x, float z)
{
	public float X = x;

	public float Z = z;

	public static readonly Vec2 Zero = new Vec2(0f, 0f);

	public float Mag => (float)Math.Sqrt(X * X + Z * Z);

	public float SqrMag => X * X + Z * Z;

	public Vec2 Norm
	{
		get
		{
			float mag = Mag;
			if (!(mag > 1E-05f))
			{
				return Zero;
			}
			return new Vec2(X / mag, Z / mag);
		}
	}

	public static Vec2 operator +(Vec2 a, Vec2 b)
	{
		return new Vec2(a.X + b.X, a.Z + b.Z);
	}

	public static Vec2 operator -(Vec2 a, Vec2 b)
	{
		return new Vec2(a.X - b.X, a.Z - b.Z);
	}

	public static Vec2 operator *(Vec2 a, float k)
	{
		return new Vec2(a.X * k, a.Z * k);
	}

	public static Vec2 Perp(Vec2 a)
	{
		return new Vec2(0f - a.Z, a.X);
	}

	public static float Dist(Vec2 a, Vec2 b)
	{
		return (a - b).Mag;
	}

	public static Vec2 StandOff(Vec2 point, Vec2 from, float off)
	{
		Vec2 vec = from - point;
		if (!(vec.SqrMag < 0.01f))
		{
			return point + vec.Norm * off;
		}
		return point;
	}
}
