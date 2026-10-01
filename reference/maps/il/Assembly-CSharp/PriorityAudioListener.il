// ===== PriorityAudioListener  (token 0x02000249) =====
  .method PriorityAudioListener::OnEnable()  // token 0x06000C8D rva 0x39cc5 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator PriorityAudioListener::ExecuteAfterTime()  /*0x06000C8E*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ret

  .method PriorityAudioListener::ExecuteAfterTime()  // token 0x06000C8E rva 0x39cd4 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PriorityAudioListener.<ExecuteAfterTime>d__1::.ctor(int)  /*0x06000C91*/
    IL_0006: ret

  .method PriorityAudioListener::OnDisable()  // token 0x06000C8F rva 0x39cdc attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: call BackupAudioListener BackupAudioListener::get_Instance()  /*0x06000275*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0018
    IL_000d: call BackupAudioListener BackupAudioListener::get_Instance()  /*0x06000275*/
    IL_0012: ldc.i4.1
    IL_0013: callvirt void BackupAudioListener::EnableBackupListener(bool)  /*0x06000278*/
    IL_0018: ret

  .method PriorityAudioListener::.ctor()  // token 0x06000C90 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== PriorityAudioListener/<ExecuteAfterTime>d__1  (token 0x0200024A) =====
  .method PriorityAudioListener.<ExecuteAfterTime>d__1::.ctor(int)  // token 0x06000C91 rva 0x39cf6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PriorityAudioListener.<ExecuteAfterTime>d__1::<>1__state  /*0x04000F3D*/
    IL_000d: ret

  .method PriorityAudioListener.<ExecuteAfterTime>d__1::System.IDisposable.Dispose()  // token 0x06000C92 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PriorityAudioListener.<ExecuteAfterTime>d__1::MoveNext()  // token 0x06000C93 rva 0x39d08 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 74 (0x4a), max stack 2, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int PriorityAudioListener.<ExecuteAfterTime>d__1::<>1__state  /*0x04000F3D*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: brfalse.s IL_0010
    IL_000a: ldloc.0
    IL_000b: ldc.i4.1
    IL_000c: beq.s IL_0029
    IL_000e: ldc.i4.0
    IL_000f: ret
    IL_0010: ldarg.0
    IL_0011: ldc.i4.m1
    IL_0012: stfld int PriorityAudioListener.<ExecuteAfterTime>d__1::<>1__state  /*0x04000F3D*/
    IL_0017: br.s IL_0030
    IL_0019: ldarg.0
    IL_001a: ldnull
    IL_001b: stfld object PriorityAudioListener.<ExecuteAfterTime>d__1::<>2__current  /*0x04000F3E*/
    IL_0020: ldarg.0
    IL_0021: ldc.i4.1
    IL_0022: stfld int PriorityAudioListener.<ExecuteAfterTime>d__1::<>1__state  /*0x04000F3D*/
    IL_0027: ldc.i4.1
    IL_0028: ret
    IL_0029: ldarg.0
    IL_002a: ldc.i4.m1
    IL_002b: stfld int PriorityAudioListener.<ExecuteAfterTime>d__1::<>1__state  /*0x04000F3D*/
    IL_0030: call BackupAudioListener BackupAudioListener::get_Instance()  /*0x06000275*/
    IL_0035: ldnull
    IL_0036: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_003b: brtrue.s IL_0019
    IL_003d: call BackupAudioListener BackupAudioListener::get_Instance()  /*0x06000275*/
    IL_0042: ldc.i4.0
    IL_0043: callvirt void BackupAudioListener::EnableBackupListener(bool)  /*0x06000278*/
    IL_0048: ldc.i4.0
    IL_0049: ret

  .method PriorityAudioListener.<ExecuteAfterTime>d__1::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000C94 rva 0x39d5e attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PriorityAudioListener.<ExecuteAfterTime>d__1::<>2__current  /*0x04000F3E*/
    IL_0006: ret

  .method PriorityAudioListener.<ExecuteAfterTime>d__1::System.Collections.IEnumerator.Reset()  // token 0x06000C95 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PriorityAudioListener.<ExecuteAfterTime>d__1::System.Collections.IEnumerator.get_Current()  // token 0x06000C96 rva 0x39d5e attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PriorityAudioListener.<ExecuteAfterTime>d__1::<>2__current  /*0x04000F3E*/
    IL_0006: ret

