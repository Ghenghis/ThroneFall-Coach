// ===== Wave  (token 0x02000137) =====
  .method Wave::.ctor()  // token 0x06000699 rva 0x1c509 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Spawn>::.ctor()  /*0x0A0002AD*/
    IL_0006: stfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float Wave::difficultyMulti  /*0x040007E3*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ret

  .method Wave::.ctor(System.Collections.Generic.List<Spawn>)  // token 0x0600069A rva 0x1c527 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Spawn>::.ctor()  /*0x0A0002AD*/
    IL_0006: stfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float Wave::difficultyMulti  /*0x040007E3*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ldarg.0
    IL_001d: ldarg.1
    IL_001e: stfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0023: ret

  .method Wave::.ctor(Spawn)  // token 0x0600069B rva 0x1c54c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<Spawn>::.ctor()  /*0x0A0002AD*/
    IL_0006: stfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float Wave::difficultyMulti  /*0x040007E3*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ldarg.0
    IL_001d: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0022: callvirt void System.Collections.Generic.List<Spawn>::Clear()  /*0x0A0002AE*/
    IL_0027: ldarg.0
    IL_0028: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_002d: ldarg.1
    IL_002e: callvirt void System.Collections.Generic.List<Spawn>::Add(!0)  /*0x0A0002AF*/
    IL_0033: ret

  .method Wave::Reset(bool)  // token 0x0600069C rva 0x1c584 attrs Public, HideBySig
    // code size 41 (0x29), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_001a
    IL_0004: ldarg.0
    IL_0005: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_000a: ldloc.0
    IL_000b: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_0010: ldarg.1
    IL_0011: callvirt void Spawn::Reset(bool)  /*0x060006A6*/
    IL_0016: ldloc.0
    IL_0017: ldc.i4.1
    IL_0018: add
    IL_0019: stloc.0
    IL_001a: ldloc.0
    IL_001b: ldarg.0
    IL_001c: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0021: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_0026: blt.s IL_0004
    IL_0028: ret

  .method Wave::Update()  // token 0x0600069D rva 0x1c5bc attrs Public, HideBySig
    // code size 46 (0x2e), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_001f
    IL_0004: ldarg.0
    IL_0005: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_000a: ldloc.0
    IL_000b: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_0010: ldarg.0
    IL_0011: ldfld float Wave::difficultyMulti  /*0x040007E3*/
    IL_0016: callvirt void Spawn::Update(float)  /*0x060006A7*/
    IL_001b: ldloc.0
    IL_001c: ldc.i4.1
    IL_001d: add
    IL_001e: stloc.0
    IL_001f: ldloc.0
    IL_0020: ldarg.0
    IL_0021: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0026: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_002b: blt.s IL_0004
    IL_002d: ret

  .method Wave::HasFinished()  // token 0x0600069E rva 0x1c5f8 attrs Public, HideBySig
    // code size 65 (0x41), max stack 2, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: ldc.i4.0
    IL_0003: stloc.1
    IL_0004: br.s IL_0021
    IL_0006: ldarg.0
    IL_0007: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_000c: ldloc.1
    IL_000d: callvirt !0 System.Collections.Generic.List<Spawn>::get_Item(int)  /*0x0A0002B0*/
    IL_0012: callvirt bool Spawn::get_Finished()  /*0x060006A3*/
    IL_0017: brfalse.s IL_001d
    IL_0019: ldloc.0
    IL_001a: ldc.i4.1
    IL_001b: add
    IL_001c: stloc.0
    IL_001d: ldloc.1
    IL_001e: ldc.i4.1
    IL_001f: add
    IL_0020: stloc.1
    IL_0021: ldloc.1
    IL_0022: ldarg.0
    IL_0023: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0028: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_002d: blt.s IL_0006
    IL_002f: ldloc.0
    IL_0030: ldarg.0
    IL_0031: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0036: callvirt int System.Collections.Generic.List<Spawn>::get_Count()  /*0x0A0002B1*/
    IL_003b: blt.s IL_003f
    IL_003d: ldc.i4.1
    IL_003e: ret
    IL_003f: ldc.i4.0
    IL_0040: ret

  .method Wave::ReduceMaxDelayTillNextSpawn()  // token 0x0600069F rva 0x1c648 attrs Public, HideBySig
    // code size 170 (0xaa), max stack 3, init locals
    .locals ([0] float, [1] float, [2] float, [3] List.Enumerator<Spawn>, [4] Spawn, [5] Spawn)
    IL_0000: ldc.r4 5f
    IL_0005: stloc.0
    IL_0006: ldc.r4 3.4028235E+38f
    IL_000b: stloc.1
    IL_000c: ldarg.0
    IL_000d: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0012: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_0017: stloc.3
    IL_0018: br.s IL_003a
    IL_001a: ldloca.s 3
    IL_001c: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_0021: stloc.s 4
    IL_0023: ldloc.s 4
    IL_0025: callvirt bool Spawn::get_Finished()  /*0x060006A3*/
    IL_002a: brtrue.s IL_003a
    IL_002c: ldloc.1
    IL_002d: ldloc.s 4
    IL_002f: ldfld float Spawn::waitBeforeNextSpawn  /*0x040007EC*/
    IL_0034: call float UnityEngine.Mathf::Min(float,float)  /*0x0A000109*/
    IL_0039: stloc.1
    IL_003a: ldloca.s 3
    IL_003c: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_0041: brtrue.s IL_001a
    IL_0043: leave.s IL_0053
    IL_0045: ldloca.s 3
    IL_0047: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_004d: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0052: endfinally
    IL_0053: ldc.r4 0f
    IL_0058: ldloc.1
    IL_0059: ldloc.0
    IL_005a: sub
    IL_005b: call float UnityEngine.Mathf::Max(float,float)  /*0x0A00004B*/
    IL_0060: stloc.2
    IL_0061: ldarg.0
    IL_0062: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0067: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_006c: stloc.3
    IL_006d: br.s IL_0090
    IL_006f: ldloca.s 3
    IL_0071: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_0076: stloc.s 5
    IL_0078: ldloc.s 5
    IL_007a: callvirt bool Spawn::get_Finished()  /*0x060006A3*/
    IL_007f: brtrue.s IL_0090
    IL_0081: ldloc.s 5
    IL_0083: dup
    IL_0084: ldfld float Spawn::waitBeforeNextSpawn  /*0x040007EC*/
    IL_0089: ldloc.2
    IL_008a: sub
    IL_008b: stfld float Spawn::waitBeforeNextSpawn  /*0x040007EC*/
    IL_0090: ldloca.s 3
    IL_0092: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_0097: brtrue.s IL_006f
    IL_0099: leave.s IL_00a9
    IL_009b: ldloca.s 3
    IL_009d: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_00a3: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00a8: endfinally
    IL_00a9: ret
    .try IL_0018-IL_0045 finally handler IL_0045-IL_0053
    .try IL_006d-IL_009b finally handler IL_009b-IL_00a9

  .method Wave::AddInfoToExisting(ref WaveInfo)  // token 0x060006A0 rva 0x1c71c attrs Public, HideBySig
    // code size 362 (0x16a), max stack 3, init locals
    .locals ([0] List.Enumerator<Spawn>, [1] Spawn, [2] string, [3] string, [4] Sprite, [5] ScreenMarkerIconArachnophobia, [6] WaveEnemyInfo, [7] List.Enumerator<WaveEnemyInfo>, [8] WaveEnemyInfo)
    IL_0000: ldarg.0
    IL_0001: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_000b: stloc.0
    IL_000c: br IL_014d
    IL_0011: ldloca.s 0
    IL_0013: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_0018: stloc.1
    IL_0019: ldloc.1
    IL_001a: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_001f: ldnull
    IL_0020: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0025: brtrue IL_014d
    IL_002a: ldloc.1
    IL_002b: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0030: dup
    IL_0031: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIcon>  /*0x2B000058*/
    IL_0036: dup
    IL_0037: callvirt string ScreenMarkerIcon::get_UnitDescription()  /*0x06000D40*/
    IL_003c: stloc.2
    IL_003d: dup
    IL_003e: callvirt string ScreenMarkerIcon::get_UnitName()  /*0x06000D41*/
    IL_0043: stloc.3
    IL_0044: ldfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_0049: stloc.s 4
    IL_004b: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIconArachnophobia>  /*0x2B000060*/
    IL_0050: stloc.s 5
    IL_0052: ldloc.s 5
    IL_0054: ldnull
    IL_0055: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_005a: brfalse.s IL_0065
    IL_005c: ldloc.s 5
    IL_005e: ldfld Sprite ScreenMarkerIconArachnophobia::defaultSprite  /*0x04000021*/
    IL_0063: stloc.s 4
    IL_0065: ldnull
    IL_0066: stloc.s 6
    IL_0068: ldarg.1
    IL_0069: ldind.ref
    IL_006a: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_006f: callvirt List.Enumerator<!0> System.Collections.Generic.List<WaveEnemyInfo>::GetEnumerator()  /*0x0A0002A4*/
    IL_0074: stloc.s 7
    IL_0076: br.s IL_00b5
    IL_0078: ldloca.s 7
    IL_007a: call !0 System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::get_Current()  /*0x0A0002A5*/
    IL_007f: stloc.s 8
    IL_0081: ldloc.s 8
    IL_0083: ldfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_0088: ldloc.s 4
    IL_008a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_008f: brfalse.s IL_00b5
    IL_0091: ldloc.s 8
    IL_0093: ldfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_0098: ldloc.3
    IL_0099: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_009e: brfalse.s IL_00b5
    IL_00a0: ldloc.s 8
    IL_00a2: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_00a7: ldloc.1
    IL_00a8: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_00ad: bne.un.s IL_00b5
    IL_00af: ldloc.s 8
    IL_00b1: stloc.s 6
    IL_00b3: leave.s IL_00ce
    IL_00b5: ldloca.s 7
    IL_00b7: call bool System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::MoveNext()  /*0x0A0002A7*/
    IL_00bc: brtrue.s IL_0078
    IL_00be: leave.s IL_00ce
    IL_00c0: ldloca.s 7
    IL_00c2: constrained. System.Collections.Generic.List.Enumerator<WaveEnemyInfo>  /*0x1B000078*/
    IL_00c8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00cd: endfinally
    IL_00ce: ldloc.s 6
    IL_00d0: brtrue.s IL_0125
    IL_00d2: newobj void WaveEnemyInfo::.ctor()  /*0x060006AE*/
    IL_00d7: stloc.s 6
    IL_00d9: ldloc.s 6
    IL_00db: ldloc.2
    IL_00dc: stfld string WaveEnemyInfo::enemyDescription  /*0x04000803*/
    IL_00e1: ldloc.s 6
    IL_00e3: ldloc.3
    IL_00e4: stfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_00e9: ldloc.s 6
    IL_00eb: ldloc.s 4
    IL_00ed: stfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_00f2: ldloc.s 6
    IL_00f4: ldloc.1
    IL_00f5: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_00fa: stfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_00ff: ldloc.s 5
    IL_0101: ldnull
    IL_0102: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0107: brfalse.s IL_0117
    IL_0109: ldloc.s 6
    IL_010b: ldloc.s 5
    IL_010d: ldfld Sprite ScreenMarkerIconArachnophobia::arachnophobiaModeSprite  /*0x04000020*/
    IL_0112: stfld Sprite WaveEnemyInfo::AltEnemyIcon  /*0x04000801*/
    IL_0117: ldarg.1
    IL_0118: ldind.ref
    IL_0119: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_011e: ldloc.s 6
    IL_0120: callvirt void System.Collections.Generic.List<WaveEnemyInfo>::Add(!0)  /*0x0A0002A8*/
    IL_0125: ldarg.1
    IL_0126: ldind.ref
    IL_0127: dup
    IL_0128: ldfld int WaveInfo::goldReward  /*0x040007FD*/
    IL_012d: ldloc.1
    IL_012e: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0133: add
    IL_0134: stfld int WaveInfo::goldReward  /*0x040007FD*/
    IL_0139: ldloc.s 6
    IL_013b: dup
    IL_013c: ldfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_0141: ldloc.1
    IL_0142: ldfld int Spawn::count  /*0x040007E7*/
    IL_0147: add
    IL_0148: stfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_014d: ldloca.s 0
    IL_014f: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_0154: brtrue IL_0011
    IL_0159: leave.s IL_0169
    IL_015b: ldloca.s 0
    IL_015d: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_0163: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0168: endfinally
    IL_0169: ret
    .try IL_0076-IL_00c0 finally handler IL_00c0-IL_00ce
    .try IL_000c-IL_015b finally handler IL_015b-IL_0169

  .method Wave::GetWaveInfo()  // token 0x060006A1 rva 0x1c8c8 attrs Public, HideBySig
    // code size 369 (0x171), max stack 3, init locals
    .locals ([0] WaveInfo, [1] List.Enumerator<Spawn>, [2] Spawn, [3] string, [4] string, [5] Sprite, [6] ScreenMarkerIconArachnophobia, [7] WaveEnemyInfo, [8] List.Enumerator<WaveEnemyInfo>, [9] WaveEnemyInfo)
    IL_0000: newobj void WaveInfo::.ctor()  /*0x060006AD*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld List<Spawn> Wave::spawns  /*0x040007E2*/
    IL_000c: callvirt List.Enumerator<!0> System.Collections.Generic.List<Spawn>::GetEnumerator()  /*0x0A00004D*/
    IL_0011: stloc.1
    IL_0012: br IL_0153
    IL_0017: ldloca.s 1
    IL_0019: call !0 System.Collections.Generic.List.Enumerator<Spawn>::get_Current()  /*0x0A00004E*/
    IL_001e: stloc.2
    IL_001f: ldloc.2
    IL_0020: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0025: ldnull
    IL_0026: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002b: brtrue IL_0153
    IL_0030: ldloc.2
    IL_0031: ldfld GameObject Spawn::enemyPrefab  /*0x040007E5*/
    IL_0036: dup
    IL_0037: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIcon>  /*0x2B000058*/
    IL_003c: dup
    IL_003d: callvirt string ScreenMarkerIcon::get_UnitDescription()  /*0x06000D40*/
    IL_0042: stloc.3
    IL_0043: dup
    IL_0044: callvirt string ScreenMarkerIcon::get_UnitName()  /*0x06000D41*/
    IL_0049: stloc.s 4
    IL_004b: ldfld Sprite ScreenMarkerIcon::sprite  /*0x04000FC5*/
    IL_0050: stloc.s 5
    IL_0052: callvirt !!0 UnityEngine.GameObject::GetComponent()<ScreenMarkerIconArachnophobia>  /*0x2B000060*/
    IL_0057: stloc.s 6
    IL_0059: ldloc.s 6
    IL_005b: ldnull
    IL_005c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0061: brfalse.s IL_006c
    IL_0063: ldloc.s 6
    IL_0065: ldfld Sprite ScreenMarkerIconArachnophobia::defaultSprite  /*0x04000021*/
    IL_006a: stloc.s 5
    IL_006c: ldnull
    IL_006d: stloc.s 7
    IL_006f: ldloc.0
    IL_0070: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_0075: callvirt List.Enumerator<!0> System.Collections.Generic.List<WaveEnemyInfo>::GetEnumerator()  /*0x0A0002A4*/
    IL_007a: stloc.s 8
    IL_007c: br.s IL_00bc
    IL_007e: ldloca.s 8
    IL_0080: call !0 System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::get_Current()  /*0x0A0002A5*/
    IL_0085: stloc.s 9
    IL_0087: ldloc.s 9
    IL_0089: ldfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_008e: ldloc.s 5
    IL_0090: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0095: brfalse.s IL_00bc
    IL_0097: ldloc.s 9
    IL_0099: ldfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_009e: ldloc.s 4
    IL_00a0: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_00a5: brfalse.s IL_00bc
    IL_00a7: ldloc.s 9
    IL_00a9: ldfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_00ae: ldloc.2
    IL_00af: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_00b4: bne.un.s IL_00bc
    IL_00b6: ldloc.s 9
    IL_00b8: stloc.s 7
    IL_00ba: leave.s IL_00d5
    IL_00bc: ldloca.s 8
    IL_00be: call bool System.Collections.Generic.List.Enumerator<WaveEnemyInfo>::MoveNext()  /*0x0A0002A7*/
    IL_00c3: brtrue.s IL_007e
    IL_00c5: leave.s IL_00d5
    IL_00c7: ldloca.s 8
    IL_00c9: constrained. System.Collections.Generic.List.Enumerator<WaveEnemyInfo>  /*0x1B000078*/
    IL_00cf: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00d4: endfinally
    IL_00d5: ldloc.s 7
    IL_00d7: brtrue.s IL_012c
    IL_00d9: newobj void WaveEnemyInfo::.ctor()  /*0x060006AE*/
    IL_00de: stloc.s 7
    IL_00e0: ldloc.s 7
    IL_00e2: ldloc.3
    IL_00e3: stfld string WaveEnemyInfo::enemyDescription  /*0x04000803*/
    IL_00e8: ldloc.s 7
    IL_00ea: ldloc.s 4
    IL_00ec: stfld string WaveEnemyInfo::enemyName  /*0x04000802*/
    IL_00f1: ldloc.s 7
    IL_00f3: ldloc.s 5
    IL_00f5: stfld Sprite WaveEnemyInfo::enemyIcon  /*0x04000800*/
    IL_00fa: ldloc.s 7
    IL_00fc: ldloc.2
    IL_00fd: ldfld bool Spawn::eliteEnemies  /*0x040007E6*/
    IL_0102: stfld bool WaveEnemyInfo::eliteEnemy  /*0x04000805*/
    IL_0107: ldloc.s 6
    IL_0109: ldnull
    IL_010a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_010f: brfalse.s IL_011f
    IL_0111: ldloc.s 7
    IL_0113: ldloc.s 6
    IL_0115: ldfld Sprite ScreenMarkerIconArachnophobia::arachnophobiaModeSprite  /*0x04000020*/
    IL_011a: stfld Sprite WaveEnemyInfo::AltEnemyIcon  /*0x04000801*/
    IL_011f: ldloc.0
    IL_0120: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_0125: ldloc.s 7
    IL_0127: callvirt void System.Collections.Generic.List<WaveEnemyInfo>::Add(!0)  /*0x0A0002A8*/
    IL_012c: ldloc.0
    IL_012d: dup
    IL_012e: ldfld int WaveInfo::goldReward  /*0x040007FD*/
    IL_0133: ldloc.2
    IL_0134: ldfld int Spawn::goldCoins  /*0x040007EA*/
    IL_0139: add
    IL_013a: stfld int WaveInfo::goldReward  /*0x040007FD*/
    IL_013f: ldloc.s 7
    IL_0141: dup
    IL_0142: ldfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_0147: ldloc.2
    IL_0148: ldfld int Spawn::count  /*0x040007E7*/
    IL_014d: add
    IL_014e: stfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_0153: ldloca.s 1
    IL_0155: call bool System.Collections.Generic.List.Enumerator<Spawn>::MoveNext()  /*0x0A000051*/
    IL_015a: brtrue IL_0017
    IL_015f: leave.s IL_016f
    IL_0161: ldloca.s 1
    IL_0163: constrained. System.Collections.Generic.List.Enumerator<Spawn>  /*0x1B00000A*/
    IL_0169: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_016e: endfinally
    IL_016f: ldloc.0
    IL_0170: ret
    .try IL_007c-IL_00c7 finally handler IL_00c7-IL_00d5
    .try IL_0012-IL_0161 finally handler IL_0161-IL_016f

