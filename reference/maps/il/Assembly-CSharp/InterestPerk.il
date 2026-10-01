// ===== InterestPerk  (token 0x0200019E) =====
  .method InterestPerk::Awake()  // token 0x06000862 rva 0x28a7f attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld InterestPerk InterestPerk::instance  /*0x04000A6A*/
    IL_0006: ret

  .method InterestPerk::Start()  // token 0x06000863 rva 0x28a87 attrs Private, HideBySig
    // code size 32 (0x20), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable InterestPerk::requiredEquippable  /*0x04000A6B*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brtrue.s IL_0014
    IL_000d: ldarg.0
    IL_000e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0013: ret
    IL_0014: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0019: ldarg.0
    IL_001a: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_001f: ret

  .method InterestPerk::Update()  // token 0x06000864 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InterestPerk::OnDawn_AfterSunrise()  // token 0x06000865 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InterestPerk::OnDawn_BeforeSunrise()  // token 0x06000866 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InterestPerk::OnDusk()  // token 0x06000867 rva 0x28aa8 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 17 (0x11), max stack 8
    IL_0000: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0005: ldarg.0
    IL_0006: call int InterestPerk::InterestAmount()  /*0x06000869*/
    IL_000b: callvirt void PlayerInteraction::AddCoin(int)  /*0x06000C0E*/
    IL_0010: ret

  .method InterestPerk::OnDuskEarly()  // token 0x06000868 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method InterestPerk::InterestAmount()  // token 0x06000869 rva 0x28aba attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable InterestPerk::requiredEquippable  /*0x04000A6B*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brtrue.s IL_000f
    IL_000d: ldc.i4.0
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld int InterestPerk::maximumInterest  /*0x04000A6D*/
    IL_0015: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_001a: callvirt int PlayerInteraction::get_Balance()  /*0x06000C04*/
    IL_001f: conv.r4
    IL_0020: ldarg.0
    IL_0021: ldfld int InterestPerk::interestForEach  /*0x04000A6C*/
    IL_0026: conv.r4
    IL_0027: div
    IL_0028: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_002d: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_0032: ret

  .method InterestPerk::.ctor()  // token 0x0600086A rva 0x28aee attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld int InterestPerk::interestForEach  /*0x04000A6C*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.s 20
    IL_000a: stfld int InterestPerk::maximumInterest  /*0x04000A6D*/
    IL_000f: ldarg.0
    IL_0010: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0015: ret

