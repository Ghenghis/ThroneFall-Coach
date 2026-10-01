// ===== PukeLogic  (token 0x0200024D) =====
  .method PukeLogic::Update()  // token 0x06000C9C rva 0x39de4 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float PukeLogic::cooldown  /*0x04000F4A*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float PukeLogic::cooldown  /*0x04000F4A*/
    IL_0012: ldarg.0
    IL_0013: ldfld float PukeLogic::cooldown  /*0x04000F4A*/
    IL_0018: ldc.r4 0f
    IL_001d: bge.un.s IL_0038
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld float PukeLogic::cooldown  /*0x04000F4A*/
    IL_0026: ldarg.0
    IL_0027: ldfld float PukeLogic::tickCooldown  /*0x04000F45*/
    IL_002c: add
    IL_002d: stfld float PukeLogic::cooldown  /*0x04000F4A*/
    IL_0032: ldarg.0
    IL_0033: call void PukeLogic::Attack()  /*0x06000C9D*/
    IL_0038: ret

  .method PukeLogic::Attack()  // token 0x06000C9D rva 0x39e20 attrs Private, HideBySig
    // code size 73 (0x49), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp PukeLogic::hpToDamage  /*0x04000F44*/
    IL_0006: ldarg.0
    IL_0007: ldfld Hp PukeLogic::hpToDamage  /*0x04000F44*/
    IL_000c: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0011: ldarg.0
    IL_0012: ldfld float PukeLogic::percentageDamage  /*0x04000F46*/
    IL_0017: mul
    IL_0018: ldarg.0
    IL_0019: ldfld float PukeLogic::realDamage  /*0x04000F47*/
    IL_001e: add
    IL_001f: ldsfld BlacksmithUpgrades BlacksmithUpgrades::instance  /*0x04000B7F*/
    IL_0024: ldfld float BlacksmithUpgrades::rangedResistance  /*0x04000B83*/
    IL_0029: div
    IL_002a: ldnull
    IL_002b: ldc.i4.0
    IL_002c: ldc.i4.1
    IL_002d: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0032: pop
    IL_0033: ldarg.0
    IL_0034: ldfld Hp PukeLogic::hpOwn  /*0x04000F48*/
    IL_0039: ldarg.0
    IL_003a: ldfld float PukeLogic::ownDps  /*0x04000F49*/
    IL_003f: ldnull
    IL_0040: ldc.i4.0
    IL_0041: ldc.i4.0
    IL_0042: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0047: pop
    IL_0048: ret

  .method PukeLogic::.ctor()  // token 0x06000C9E rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

