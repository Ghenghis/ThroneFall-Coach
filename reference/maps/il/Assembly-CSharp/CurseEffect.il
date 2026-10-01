// ===== CurseEffect  (token 0x020000A6) =====
  .method CurseEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x06000396 rva 0x101aa attrs Public, Virtual, HideBySig
    // code size 21 (0x15), max stack 8
    IL_0000: ldsfld CurseBlastMA CurseBlastMA::instance  /*0x04000C97*/
    IL_0005: ldarg.1
    IL_0006: ldarg.0
    IL_0007: ldfld Weapon CurseEffect::weaponToDamageEverybody  /*0x040004A4*/
    IL_000c: ldarg.2
    IL_000d: ldarg.s 5
    IL_000f: callvirt void CurseBlastMA::AddCursedHp(Hp,Weapon,TaggedObject,float)  /*0x060009E8*/
    IL_0014: ret

  .method CurseEffect::.ctor()  // token 0x06000397 rva 0x101c0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0006: ret

