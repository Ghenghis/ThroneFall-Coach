// ===== PacifistPact  (token 0x02000208) =====
  .method PacifistPact::Start()  // token 0x06000ADD rva 0x33704 attrs Private, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: callvirt bool PerkManager::get_PacifistPactEquipped()  /*0x060009A2*/
    IL_000a: brfalse.s IL_001a
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call IEnumerator PacifistPact::EnablePacifistPact()  /*0x06000ADE*/
    IL_0013: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0018: pop
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0020: ret

  .method PacifistPact::EnablePacifistPact()  // token 0x06000ADE rva 0x33726 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PacifistPact.<EnablePacifistPact>d__1::.ctor(int)  /*0x06000AE0*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld PacifistPact PacifistPact.<EnablePacifistPact>d__1::<>4__this  /*0x04000DA4*/
    IL_000d: ret

  .method PacifistPact::.ctor()  // token 0x06000ADF rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== PacifistPact/<EnablePacifistPact>d__1  (token 0x02000209) =====
  .method PacifistPact.<EnablePacifistPact>d__1::.ctor(int)  // token 0x06000AE0 rva 0x33735 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PacifistPact.<EnablePacifistPact>d__1::<>1__state  /*0x04000DA2*/
    IL_000d: ret

  .method PacifistPact.<EnablePacifistPact>d__1::System.IDisposable.Dispose()  // token 0x06000AE1 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PacifistPact.<EnablePacifistPact>d__1::MoveNext()  // token 0x06000AE2 rva 0x33744 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 140 (0x8c), max stack 2, init locals
    .locals ([0] int, [1] PacifistPact)
    IL_0000: ldarg.0
    IL_0001: ldfld int PacifistPact.<EnablePacifistPact>d__1::<>1__state  /*0x04000DA2*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PacifistPact PacifistPact.<EnablePacifistPact>d__1::<>4__this  /*0x04000DA4*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0039, IL_0050)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int PacifistPact.<EnablePacifistPact>d__1::<>1__state  /*0x04000DA2*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld object PacifistPact.<EnablePacifistPact>d__1::<>2__current  /*0x04000DA3*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld int PacifistPact.<EnablePacifistPact>d__1::<>1__state  /*0x04000DA2*/
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldc.i4.m1
    IL_003b: stfld int PacifistPact.<EnablePacifistPact>d__1::<>1__state  /*0x04000DA2*/
    IL_0040: ldarg.0
    IL_0041: ldnull
    IL_0042: stfld object PacifistPact.<EnablePacifistPact>d__1::<>2__current  /*0x04000DA3*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.2
    IL_0049: stfld int PacifistPact.<EnablePacifistPact>d__1::<>1__state  /*0x04000DA2*/
    IL_004e: ldc.i4.1
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldc.i4.m1
    IL_0052: stfld int PacifistPact.<EnablePacifistPact>d__1::<>1__state  /*0x04000DA2*/
    IL_0057: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_005c: ldfld float PerkManager::pacifistAutoAttackMulti  /*0x04000C59*/
    IL_0061: call void RoyalForgeUpgrade::AutoAttackMulti(float)  /*0x06000CBE*/
    IL_0066: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_006b: ldfld float PerkManager::pacifistManualAttackMulti  /*0x04000C5A*/
    IL_0070: call void RoyalForgeUpgrade::ManualAttackMulti(float)  /*0x06000CBD*/
    IL_0075: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_007a: ldfld float PerkManager::pacifistHpMulti  /*0x04000C5B*/
    IL_007f: call void RoyalForgeUpgrade::PlayerHealthMulti(float)  /*0x06000CBC*/
    IL_0084: ldloc.1
    IL_0085: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_008a: ldc.i4.0
    IL_008b: ret

  .method PacifistPact.<EnablePacifistPact>d__1::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000AE3 rva 0x337dc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PacifistPact.<EnablePacifistPact>d__1::<>2__current  /*0x04000DA3*/
    IL_0006: ret

  .method PacifistPact.<EnablePacifistPact>d__1::System.Collections.IEnumerator.Reset()  // token 0x06000AE4 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PacifistPact.<EnablePacifistPact>d__1::System.Collections.IEnumerator.get_Current()  // token 0x06000AE5 rva 0x337dc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PacifistPact.<EnablePacifistPact>d__1::<>2__current  /*0x04000DA3*/
    IL_0006: ret

