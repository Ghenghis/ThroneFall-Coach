// ===== AutoDayNight  (token 0x02000073) =====
  .method AutoDayNight::Start()  // token 0x06000254 rva 0xabfa attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator AutoDayNight::Startup()  /*0x06000255*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method AutoDayNight::Startup()  // token 0x06000255 rva 0xac09 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void AutoDayNight.<Startup>d__6::.ctor(int)  /*0x06000257*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld AutoDayNight AutoDayNight.<Startup>d__6::<>4__this  /*0x04000330*/
    IL_000d: ret

  .method AutoDayNight::.ctor()  // token 0x06000256 rva 0xac18 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 36 (0x24), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool AutoDayNight::autoDayLength  /*0x04000329*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 15f
    IL_000d: stfld float AutoDayNight::dayLength  /*0x0400032A*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 15f
    IL_0018: stfld float AutoDayNight::nightLength  /*0x0400032C*/
    IL_001d: ldarg.0
    IL_001e: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0023: ret

// ===== AutoDayNight/<Startup>d__6  (token 0x02000074) =====
  .method AutoDayNight.<Startup>d__6::.ctor(int)  // token 0x06000257 rva 0xac3d attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int AutoDayNight.<Startup>d__6::<>1__state  /*0x0400032E*/
    IL_000d: ret

  .method AutoDayNight.<Startup>d__6::System.IDisposable.Dispose()  // token 0x06000258 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoDayNight.<Startup>d__6::MoveNext()  // token 0x06000259 rva 0xac4c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 171 (0xab), max stack 2, init locals
    .locals ([0] int, [1] AutoDayNight)
    IL_0000: ldarg.0
    IL_0001: ldfld int AutoDayNight.<Startup>d__6::<>1__state  /*0x0400032E*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld AutoDayNight AutoDayNight.<Startup>d__6::<>4__this  /*0x04000330*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0039, IL_0050)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int AutoDayNight.<Startup>d__6::<>1__state  /*0x0400032E*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld object AutoDayNight.<Startup>d__6::<>2__current  /*0x0400032F*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld int AutoDayNight.<Startup>d__6::<>1__state  /*0x0400032E*/
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldc.i4.m1
    IL_003b: stfld int AutoDayNight.<Startup>d__6::<>1__state  /*0x0400032E*/
    IL_0040: ldarg.0
    IL_0041: ldnull
    IL_0042: stfld object AutoDayNight.<Startup>d__6::<>2__current  /*0x0400032F*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.2
    IL_0049: stfld int AutoDayNight.<Startup>d__6::<>1__state  /*0x0400032E*/
    IL_004e: ldc.i4.1
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldc.i4.m1
    IL_0052: stfld int AutoDayNight.<Startup>d__6::<>1__state  /*0x0400032E*/
    IL_0057: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_005c: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0061: brfalse.s IL_0093
    IL_0063: ldloc.1
    IL_0064: ldfld bool AutoDayNight::autoDayLength  /*0x04000329*/
    IL_0069: brfalse.s IL_007b
    IL_006b: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0070: ldloc.1
    IL_0071: ldfld float AutoDayNight::dayLength  /*0x0400032A*/
    IL_0076: callvirt void DayNightCycle::SetToAutoDayLength(float)  /*0x060003B5*/
    IL_007b: ldloc.1
    IL_007c: ldfld bool AutoDayNight::autoNightLength  /*0x0400032B*/
    IL_0081: brfalse.s IL_0093
    IL_0083: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0088: ldloc.1
    IL_0089: ldfld float AutoDayNight::nightLength  /*0x0400032C*/
    IL_008e: callvirt void DayNightCycle::SetToAutoNightLength(float)  /*0x060003B6*/
    IL_0093: ldloc.1
    IL_0094: ldfld GameObject AutoDayNight::uiCountdownPrefab  /*0x0400032D*/
    IL_0099: ldsfld NightscoreUI NightscoreUI::instance  /*0x040014D4*/
    IL_009e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a3: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_00a8: pop
    IL_00a9: ldc.i4.0
    IL_00aa: ret

  .method AutoDayNight.<Startup>d__6::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x0600025A rva 0xad03 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AutoDayNight.<Startup>d__6::<>2__current  /*0x0400032F*/
    IL_0006: ret

  .method AutoDayNight.<Startup>d__6::System.Collections.IEnumerator.Reset()  // token 0x0600025B rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method AutoDayNight.<Startup>d__6::System.Collections.IEnumerator.get_Current()  // token 0x0600025C rva 0xad03 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object AutoDayNight.<Startup>d__6::<>2__current  /*0x0400032F*/
    IL_0006: ret

