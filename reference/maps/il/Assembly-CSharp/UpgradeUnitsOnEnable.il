// ===== UpgradeUnitsOnEnable  (token 0x02000396) =====
  .method UpgradeUnitsOnEnable::OnEnable()  // token 0x060013B0 rva 0x5d75c attrs Private, HideBySig
    // code size 96 (0x60), max stack 4, init locals
    .locals ([0] Hp[], [1] int, [2] AutoAttack[], [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld Hp[] UpgradeUnitsOnEnable::units  /*0x040017F7*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_0059
    IL_000b: ldloc.0
    IL_000c: ldloc.1
    IL_000d: ldelem.ref
    IL_000e: dup
    IL_000f: dup
    IL_0010: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_0015: ldarg.0
    IL_0016: ldfld float UpgradeUnitsOnEnable::healthMulti  /*0x040017F8*/
    IL_001b: mul
    IL_001c: stfld float Hp::maxHp  /*0x04000A2C*/
    IL_0021: dup
    IL_0022: ldc.r4 100000000f
    IL_0027: callvirt void Hp::Heal(float)  /*0x0600082E*/
    IL_002c: callvirt !!0[] UnityEngine.Component::GetComponents()<AutoAttack>  /*0x2B00008D*/
    IL_0031: stloc.2
    IL_0032: ldc.i4.0
    IL_0033: stloc.3
    IL_0034: br.s IL_004f
    IL_0036: ldloc.2
    IL_0037: ldloc.3
    IL_0038: ldelem.ref
    IL_0039: dup
    IL_003a: callvirt float AutoAttack::get_DamageMultiplyer()  /*0x0600022C*/
    IL_003f: ldarg.0
    IL_0040: ldfld float UpgradeUnitsOnEnable::attackMulti  /*0x040017F9*/
    IL_0045: mul
    IL_0046: callvirt void AutoAttack::set_DamageMultiplyer(float)  /*0x0600022D*/
    IL_004b: ldloc.3
    IL_004c: ldc.i4.1
    IL_004d: add
    IL_004e: stloc.3
    IL_004f: ldloc.3
    IL_0050: ldloc.2
    IL_0051: ldlen
    IL_0052: conv.i4
    IL_0053: blt.s IL_0036
    IL_0055: ldloc.1
    IL_0056: ldc.i4.1
    IL_0057: add
    IL_0058: stloc.1
    IL_0059: ldloc.1
    IL_005a: ldloc.0
    IL_005b: ldlen
    IL_005c: conv.i4
    IL_005d: blt.s IL_000b
    IL_005f: ret

  .method UpgradeUnitsOnEnable::.ctor()  // token 0x060013B1 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

