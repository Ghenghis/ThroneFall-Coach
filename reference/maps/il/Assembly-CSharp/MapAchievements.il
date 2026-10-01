// ===== MapAchievements  (token 0x020001EF) =====
  .method MapAchievements::Start()  // token 0x06000A3B rva 0x3065c attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator MapAchievements::GiveMapAchievements()  /*0x06000A3C*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method MapAchievements::GiveMapAchievements()  // token 0x06000A3C rva 0x3066b attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void MapAchievements.<GiveMapAchievements>d__1::.ctor(int)  /*0x06000A3E*/
    IL_0006: ret

  .method MapAchievements::.ctor()  // token 0x06000A3D rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== MapAchievements/<GiveMapAchievements>d__1  (token 0x020001F0) =====
  .method MapAchievements.<GiveMapAchievements>d__1::.ctor(int)  // token 0x06000A3E rva 0x30673 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int MapAchievements.<GiveMapAchievements>d__1::<>1__state  /*0x04000CFF*/
    IL_000d: ret

  .method MapAchievements.<GiveMapAchievements>d__1::System.IDisposable.Dispose()  // token 0x06000A3F rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method MapAchievements.<GiveMapAchievements>d__1::MoveNext()  // token 0x06000A40 rva 0x30684 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 180 (0xb4), max stack 2, init locals
    .locals ([0] int, [1] bool, [2] List.Enumerator<Equippable>, [3] Equippable)
    IL_0000: ldarg.0
    IL_0001: ldfld int MapAchievements.<GiveMapAchievements>d__1::<>1__state  /*0x04000CFF*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: switch (IL_001b, IL_0032, IL_0049)
    IL_0019: ldc.i4.0
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldc.i4.m1
    IL_001d: stfld int MapAchievements.<GiveMapAchievements>d__1::<>1__state  /*0x04000CFF*/
    IL_0022: ldarg.0
    IL_0023: ldnull
    IL_0024: stfld object MapAchievements.<GiveMapAchievements>d__1::<>2__current  /*0x04000D00*/
    IL_0029: ldarg.0
    IL_002a: ldc.i4.1
    IL_002b: stfld int MapAchievements.<GiveMapAchievements>d__1::<>1__state  /*0x04000CFF*/
    IL_0030: ldc.i4.1
    IL_0031: ret
    IL_0032: ldarg.0
    IL_0033: ldc.i4.m1
    IL_0034: stfld int MapAchievements.<GiveMapAchievements>d__1::<>1__state  /*0x04000CFF*/
    IL_0039: ldarg.0
    IL_003a: ldnull
    IL_003b: stfld object MapAchievements.<GiveMapAchievements>d__1::<>2__current  /*0x04000D00*/
    IL_0040: ldarg.0
    IL_0041: ldc.i4.2
    IL_0042: stfld int MapAchievements.<GiveMapAchievements>d__1::<>1__state  /*0x04000CFF*/
    IL_0047: ldc.i4.1
    IL_0048: ret
    IL_0049: ldarg.0
    IL_004a: ldc.i4.m1
    IL_004b: stfld int MapAchievements.<GiveMapAchievements>d__1::<>1__state  /*0x04000CFF*/
    IL_0050: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0055: callvirt int LevelProgressManager::CrownsAchieved()  /*0x0600094E*/
    IL_005a: call void AchievementManager::GiveCrownsAchievement(int)  /*0x0600090F*/
    IL_005f: ldc.i4.1
    IL_0060: stloc.1
    IL_0061: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0066: ldfld List<Equippable> PerkManager::allEquippables  /*0x04000BE8*/
    IL_006b: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0070: stloc.2
    IL_0071: br.s IL_0090
    IL_0073: ldloca.s 2
    IL_0075: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_007a: stloc.3
    IL_007b: ldloc.3
    IL_007c: ldc.i4.0
    IL_007d: callvirt bool Equippable::IsAvailableInContentPack(Equippable.ContentPack)  /*0x06000B55*/
    IL_0082: brfalse.s IL_0090
    IL_0084: ldloc.3
    IL_0085: callvirt bool Equippable::get_IsUnlocked()  /*0x06000B54*/
    IL_008a: brtrue.s IL_0090
    IL_008c: ldc.i4.0
    IL_008d: stloc.1
    IL_008e: leave.s IL_00a9
    IL_0090: ldloca.s 2
    IL_0092: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0097: brtrue.s IL_0073
    IL_0099: leave.s IL_00a9
    IL_009b: ldloca.s 2
    IL_009d: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_00a3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a8: endfinally
    IL_00a9: ldloc.1
    IL_00aa: brfalse.s IL_00b2
    IL_00ac: ldc.i4.8
    IL_00ad: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_00b2: ldc.i4.0
    IL_00b3: ret
    .try IL_0071-IL_009b finally handler IL_009b-IL_00a9

  .method MapAchievements.<GiveMapAchievements>d__1::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000A41 rva 0x30754 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MapAchievements.<GiveMapAchievements>d__1::<>2__current  /*0x04000D00*/
    IL_0006: ret

  .method MapAchievements.<GiveMapAchievements>d__1::System.Collections.IEnumerator.Reset()  // token 0x06000A42 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method MapAchievements.<GiveMapAchievements>d__1::System.Collections.IEnumerator.get_Current()  // token 0x06000A43 rva 0x30754 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object MapAchievements.<GiveMapAchievements>d__1::<>2__current  /*0x04000D00*/
    IL_0006: ret

