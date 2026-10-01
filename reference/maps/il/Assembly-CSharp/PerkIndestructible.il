// ===== PerkIndestructible  (token 0x02000224) =====
  .method PerkIndestructible::Start()  // token 0x06000B79 rva 0x36934 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 2, init locals
    .locals ([0] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld Equippable PerkIndestructible::indestructiblePerk  /*0x04000E56*/
    IL_0006: call bool PerkManager::IsEquipped(Equippable)  /*0x060009A4*/
    IL_000b: brfalse.s IL_0023
    IL_000d: ldarg.0
    IL_000e: call !!0 UnityEngine.Component::GetComponentInChildren()<TaggedObject>  /*0x2B000045*/
    IL_0013: stloc.0
    IL_0014: ldloc.0
    IL_0015: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001a: brfalse.s IL_0023
    IL_001c: ldloc.0
    IL_001d: ldc.i4.0
    IL_001e: callvirt void TaggedObject::RemoveTag(TagManager.ETag)  /*0x06000E4A*/
    IL_0023: ldarg.0
    IL_0024: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0029: ret

  .method PerkIndestructible::.ctor()  // token 0x06000B7A rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

