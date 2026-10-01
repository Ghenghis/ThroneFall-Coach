// ===== OnDeathStartNextDay  (token 0x02000204) =====
  .method OnDeathStartNextDay::Start()  // token 0x06000AC9 rva 0x33416 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0006: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_000b: ldarg.0
    IL_000c: ldftn void OnDeathStartNextDay::OnDeath()  /*0x06000ACA*/
    IL_0012: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_001c: ret

  .method OnDeathStartNextDay::OnDeath()  // token 0x06000ACA rva 0x33434 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator OnDeathStartNextDay::DelayedSwithToDay()  /*0x06000ACB*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method OnDeathStartNextDay::DelayedSwithToDay()  // token 0x06000ACB rva 0x33443 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void OnDeathStartNextDay.<DelayedSwithToDay>d__2::.ctor(int)  /*0x06000ACD*/
    IL_0006: ret

  .method OnDeathStartNextDay::.ctor()  // token 0x06000ACC rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== OnDeathStartNextDay/<DelayedSwithToDay>d__2  (token 0x02000205) =====
  .method OnDeathStartNextDay.<DelayedSwithToDay>d__2::.ctor(int)  // token 0x06000ACD rva 0x3344b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int OnDeathStartNextDay.<DelayedSwithToDay>d__2::<>1__state  /*0x04000D99*/
    IL_000d: ret

  .method OnDeathStartNextDay.<DelayedSwithToDay>d__2::System.IDisposable.Dispose()  // token 0x06000ACE rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method OnDeathStartNextDay.<DelayedSwithToDay>d__2::MoveNext()  // token 0x06000ACF rva 0x3345c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 67 (0x43), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int OnDeathStartNextDay.<DelayedSwithToDay>d__2::<>1__state  /*0x04000D99*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: brfalse.s IL_0010
    IL_000a: ldloc.0
    IL_000b: ldc.i4.1
    IL_000c: beq.s IL_0030
    IL_000e: ldc.i4.0
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldc.i4.m1
    IL_0012: stfld int OnDeathStartNextDay.<DelayedSwithToDay>d__2::<>1__state  /*0x04000D99*/
    IL_0017: ldarg.0
    IL_0018: ldc.r4 2f
    IL_001d: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_0022: stfld object OnDeathStartNextDay.<DelayedSwithToDay>d__2::<>2__current  /*0x04000D9A*/
    IL_0027: ldarg.0
    IL_0028: ldc.i4.1
    IL_0029: stfld int OnDeathStartNextDay.<DelayedSwithToDay>d__2::<>1__state  /*0x04000D99*/
    IL_002e: ldc.i4.1
    IL_002f: ret
    IL_0030: ldarg.0
    IL_0031: ldc.i4.m1
    IL_0032: stfld int OnDeathStartNextDay.<DelayedSwithToDay>d__2::<>1__state  /*0x04000D99*/
    IL_0037: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_003c: callvirt void DayNightCycle::SwithToDay()  /*0x060003B2*/
    IL_0041: ldc.i4.0
    IL_0042: ret

  .method OnDeathStartNextDay.<DelayedSwithToDay>d__2::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000AD0 rva 0x334ab attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object OnDeathStartNextDay.<DelayedSwithToDay>d__2::<>2__current  /*0x04000D9A*/
    IL_0006: ret

  .method OnDeathStartNextDay.<DelayedSwithToDay>d__2::System.Collections.IEnumerator.Reset()  // token 0x06000AD1 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method OnDeathStartNextDay.<DelayedSwithToDay>d__2::System.Collections.IEnumerator.get_Current()  // token 0x06000AD2 rva 0x334ab attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object OnDeathStartNextDay.<DelayedSwithToDay>d__2::<>2__current  /*0x04000D9A*/
    IL_0006: ret

