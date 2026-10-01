// ===== TemplePrayers  (token 0x020002B1) =====
  .method TemplePrayers::EnableEffectAtPurchase()  // token 0x06000ECB rva 0x42ad0 attrs Public, Virtual, HideBySig
    // code size 103 (0x67), max stack 4, init locals
    .locals ([0] Shrine[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: call !!0[] UnityEngine.Object::FindObjectsOfType(bool)<Shrine>  /*0x2B0000D5*/
    IL_0007: stfld Shrine[] TemplePrayers::shrines  /*0x04001126*/
    IL_000c: ldarg.0
    IL_000d: ldfld Shrine[] TemplePrayers::shrines  /*0x04001126*/
    IL_0012: stloc.0
    IL_0013: ldc.i4.0
    IL_0014: stloc.1
    IL_0015: br.s IL_0060
    IL_0017: ldloc.0
    IL_0018: ldloc.1
    IL_0019: ldelem.ref
    IL_001a: dup
    IL_001b: dup
    IL_001c: callvirt float Shrine::get_CollectionRange()  /*0x06000E10*/
    IL_0021: ldarg.0
    IL_0022: ldfld float TemplePrayers::rangeMulti  /*0x04001125*/
    IL_0027: mul
    IL_0028: callvirt void Shrine::set_CollectionRange(float)  /*0x06000E11*/
    IL_002d: dup
    IL_002e: ldc.i4.1
    IL_002f: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<AutoAttack>  /*0x2B0000D6*/
    IL_0034: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0039: ldc.i4.0
    IL_003a: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_003f: dup
    IL_0040: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0045: ldarg.0
    IL_0046: ldfld float TemplePrayers::rangeMulti  /*0x04001125*/
    IL_004b: mul
    IL_004c: stfld float TargetPriority::range  /*0x040010D2*/
    IL_0051: callvirt BuildSlot Shrine::get_ParentBuildSlot()  /*0x06000E13*/
    IL_0056: ldc.i4.0
    IL_0057: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_005c: ldloc.1
    IL_005d: ldc.i4.1
    IL_005e: add
    IL_005f: stloc.1
    IL_0060: ldloc.1
    IL_0061: ldloc.0
    IL_0062: ldlen
    IL_0063: conv.i4
    IL_0064: blt.s IL_0017
    IL_0066: ret

  .method TemplePrayers::EnableEffectAtDusk()  // token 0x06000ECC rva 0x42b44 attrs Public, Virtual, HideBySig
    // code size 67 (0x43), max stack 2, init locals
    .locals ([0] Shrine[], [1] int, [2] Shrine)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call IEnumerator TemplePrayers::MarkShrineAsKnockedOut()  /*0x06000ECD*/
    IL_0007: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_000c: pop
    IL_000d: ldarg.0
    IL_000e: ldfld Shrine[] TemplePrayers::shrines  /*0x04001126*/
    IL_0013: stloc.0
    IL_0014: ldc.i4.0
    IL_0015: stloc.1
    IL_0016: br.s IL_003c
    IL_0018: ldloc.0
    IL_0019: ldloc.1
    IL_001a: ldelem.ref
    IL_001b: stloc.2
    IL_001c: ldloc.2
    IL_001d: callvirt BuildSlot Shrine::get_ParentBuildSlot()  /*0x06000E13*/
    IL_0022: ldloc.2
    IL_0023: callvirt bool Shrine::get_ShrineHasBeenActivated()  /*0x06000E14*/
    IL_0028: brtrue.s IL_002d
    IL_002a: ldc.i4.0
    IL_002b: br.s IL_0033
    IL_002d: ldloc.2
    IL_002e: callvirt int Shrine::get_IncomeOnceUnlocked()  /*0x06000E12*/
    IL_0033: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_0038: ldloc.1
    IL_0039: ldc.i4.1
    IL_003a: add
    IL_003b: stloc.1
    IL_003c: ldloc.1
    IL_003d: ldloc.0
    IL_003e: ldlen
    IL_003f: conv.i4
    IL_0040: blt.s IL_0018
    IL_0042: ret

  .method TemplePrayers::MarkShrineAsKnockedOut()  // token 0x06000ECD rva 0x42b93 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void TemplePrayers.<MarkShrineAsKnockedOut>d__4::.ctor(int)  /*0x06000ED0*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld TemplePrayers TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>4__this  /*0x04001129*/
    IL_000d: ret

  .method TemplePrayers::DisableEffectAtDawn()  // token 0x06000ECE rva 0x42ba4 attrs Public, Virtual, HideBySig
    // code size 79 (0x4f), max stack 4, init locals
    .locals ([0] Shrine[], [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld Shrine[] TemplePrayers::shrines  /*0x04001126*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: br.s IL_0048
    IL_000b: ldloc.0
    IL_000c: ldloc.1
    IL_000d: ldelem.ref
    IL_000e: dup
    IL_000f: dup
    IL_0010: callvirt float Shrine::get_CollectionRange()  /*0x06000E10*/
    IL_0015: ldarg.0
    IL_0016: ldfld float TemplePrayers::rangeMulti  /*0x04001125*/
    IL_001b: div
    IL_001c: callvirt void Shrine::set_CollectionRange(float)  /*0x06000E11*/
    IL_0021: ldc.i4.1
    IL_0022: callvirt !!0 UnityEngine.Component::GetComponentInChildren(bool)<AutoAttack>  /*0x2B0000D6*/
    IL_0027: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_002c: ldc.i4.0
    IL_002d: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0032: dup
    IL_0033: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_0038: ldarg.0
    IL_0039: ldfld float TemplePrayers::rangeMulti  /*0x04001125*/
    IL_003e: div
    IL_003f: stfld float TargetPriority::range  /*0x040010D2*/
    IL_0044: ldloc.1
    IL_0045: ldc.i4.1
    IL_0046: add
    IL_0047: stloc.1
    IL_0048: ldloc.1
    IL_0049: ldloc.0
    IL_004a: ldlen
    IL_004b: conv.i4
    IL_004c: blt.s IL_000b
    IL_004e: ret

  .method TemplePrayers::.ctor()  // token 0x06000ECF rva 0x42bff attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.5f
    IL_0006: stfld float TemplePrayers::rangeMulti  /*0x04001125*/
    IL_000b: ldarg.0
    IL_000c: call void TempleUpgrade::.ctor()  /*0x06000EE7*/
    IL_0011: ret

// ===== TemplePrayers/<MarkShrineAsKnockedOut>d__4  (token 0x020002B2) =====
  .method TemplePrayers.<MarkShrineAsKnockedOut>d__4::.ctor(int)  // token 0x06000ED0 rva 0x42c12 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>1__state  /*0x04001127*/
    IL_000d: ret

  .method TemplePrayers.<MarkShrineAsKnockedOut>d__4::System.IDisposable.Dispose()  // token 0x06000ED1 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method TemplePrayers.<MarkShrineAsKnockedOut>d__4::MoveNext()  // token 0x06000ED2 rva 0x42c24 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 128 (0x80), max stack 2, init locals
    .locals ([0] int, [1] TemplePrayers, [2] Shrine[], [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>1__state  /*0x04001127*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld TemplePrayers TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>4__this  /*0x04001129*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_0022, IL_0039, IL_0050)
    IL_0020: ldc.i4.0
    IL_0021: ret
    IL_0022: ldarg.0
    IL_0023: ldc.i4.m1
    IL_0024: stfld int TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>1__state  /*0x04001127*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld object TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>2__current  /*0x04001128*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld int TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>1__state  /*0x04001127*/
    IL_0037: ldc.i4.1
    IL_0038: ret
    IL_0039: ldarg.0
    IL_003a: ldc.i4.m1
    IL_003b: stfld int TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>1__state  /*0x04001127*/
    IL_0040: ldarg.0
    IL_0041: ldnull
    IL_0042: stfld object TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>2__current  /*0x04001128*/
    IL_0047: ldarg.0
    IL_0048: ldc.i4.2
    IL_0049: stfld int TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>1__state  /*0x04001127*/
    IL_004e: ldc.i4.1
    IL_004f: ret
    IL_0050: ldarg.0
    IL_0051: ldc.i4.m1
    IL_0052: stfld int TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>1__state  /*0x04001127*/
    IL_0057: ldloc.1
    IL_0058: ldfld Shrine[] TemplePrayers::shrines  /*0x04001126*/
    IL_005d: stloc.2
    IL_005e: ldc.i4.0
    IL_005f: stloc.3
    IL_0060: br.s IL_0078
    IL_0062: ldloc.2
    IL_0063: ldloc.3
    IL_0064: ldelem.ref
    IL_0065: callvirt BuildSlot Shrine::get_ParentBuildSlot()  /*0x06000E13*/
    IL_006a: callvirt BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_006f: callvirt void BuildingInteractor::OnKnockOut()  /*0x06000BC1*/
    IL_0074: ldloc.3
    IL_0075: ldc.i4.1
    IL_0076: add
    IL_0077: stloc.3
    IL_0078: ldloc.3
    IL_0079: ldloc.2
    IL_007a: ldlen
    IL_007b: conv.i4
    IL_007c: blt.s IL_0062
    IL_007e: ldc.i4.0
    IL_007f: ret

  .method TemplePrayers.<MarkShrineAsKnockedOut>d__4::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000ED3 rva 0x42cb0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>2__current  /*0x04001128*/
    IL_0006: ret

  .method TemplePrayers.<MarkShrineAsKnockedOut>d__4::System.Collections.IEnumerator.Reset()  // token 0x06000ED4 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method TemplePrayers.<MarkShrineAsKnockedOut>d__4::System.Collections.IEnumerator.get_Current()  // token 0x06000ED5 rva 0x42cb0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object TemplePrayers.<MarkShrineAsKnockedOut>d__4::<>2__current  /*0x04001128*/
    IL_0006: ret

