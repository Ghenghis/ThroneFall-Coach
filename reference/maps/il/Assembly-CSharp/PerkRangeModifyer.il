// ===== PerkRangeModifyer  (token 0x02000226) =====
  .method PerkRangeModifyer::get_IsActive()  // token 0x06000B82 rva 0x369b9 attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkRangeModifyer::requiredPerk  /*0x04000E5A*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: ret

  .method PerkRangeModifyer::Start()  // token 0x06000B83 rva 0x369c8 attrs Private, HideBySig
    // code size 126 (0x7e), max stack 3, init locals
    .locals ([0] List.Enumerator<TargetPriority>)
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkRangeModifyer::requiredPerk  /*0x04000E5A*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_0077
    IL_000d: ldarg.0
    IL_000e: ldfld AutoAttack PerkRangeModifyer::autoAttack  /*0x04000E5C*/
    IL_0013: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0018: callvirt List.Enumerator<!0> System.Collections.Generic.List<TargetPriority>::GetEnumerator()  /*0x0A0001D1*/
    IL_001d: stloc.0
    IL_001e: br.s IL_0039
    IL_0020: ldloca.s 0
    IL_0022: call !0 System.Collections.Generic.List.Enumerator<TargetPriority>::get_Current()  /*0x0A0001D2*/
    IL_0027: dup
    IL_0028: ldfld float TargetPriority::range  /*0x040010D2*/
    IL_002d: ldarg.0
    IL_002e: ldfld float PerkRangeModifyer::rangeMultiplyer  /*0x04000E5B*/
    IL_0033: mul
    IL_0034: stfld float TargetPriority::range  /*0x040010D2*/
    IL_0039: ldloca.s 0
    IL_003b: call bool System.Collections.Generic.List.Enumerator<TargetPriority>::MoveNext()  /*0x0A0001D6*/
    IL_0040: brtrue.s IL_0020
    IL_0042: leave.s IL_0052
    IL_0044: ldloca.s 0
    IL_0046: constrained. System.Collections.Generic.List.Enumerator<TargetPriority>  /*0x1B000040*/
    IL_004c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0051: endfinally
    IL_0052: ldarg.0
    IL_0053: ldfld PathfindMovementPlayerunit PerkRangeModifyer::pathfindMovement  /*0x04000E5D*/
    IL_0058: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_005d: brfalse.s IL_0077
    IL_005f: ldarg.0
    IL_0060: ldfld PathfindMovementPlayerunit PerkRangeModifyer::pathfindMovement  /*0x04000E5D*/
    IL_0065: dup
    IL_0066: ldfld float PathfindMovementPlayerunit::keepDistanceOf  /*0x04000DFF*/
    IL_006b: ldarg.0
    IL_006c: ldfld float PerkRangeModifyer::rangeMultiplyer  /*0x04000E5B*/
    IL_0071: mul
    IL_0072: stfld float PathfindMovementPlayerunit::keepDistanceOf  /*0x04000DFF*/
    IL_0077: ldarg.0
    IL_0078: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_007d: ret
    .try IL_001e-IL_0044 finally handler IL_0044-IL_0052

  .method PerkRangeModifyer::.ctor()  // token 0x06000B84 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

