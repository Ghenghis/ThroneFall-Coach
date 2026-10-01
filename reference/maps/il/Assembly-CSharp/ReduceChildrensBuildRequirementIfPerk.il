// ===== ReduceChildrensBuildRequirementIfPerk  (token 0x02000252) =====
  .method ReduceChildrensBuildRequirementIfPerk::Update()  // token 0x06000CAB rva 0x3a2fc attrs Private, HideBySig
    // code size 118 (0x76), max stack 4, init locals
    .locals ([0] BuildSlot, [1] List.Enumerator<BuildSlot>, [2] BuildSlot)
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: callvirt List<Equippable> PerkManager::get_CurrentlyEquipped()  /*0x0600097A*/
    IL_000a: ldarg.0
    IL_000b: ldfld Equippable ReduceChildrensBuildRequirementIfPerk::perk  /*0x04000F59*/
    IL_0010: callvirt bool System.Collections.Generic.List<Equippable>::Contains(!0)  /*0x0A0001A0*/
    IL_0015: brfalse.s IL_006f
    IL_0017: ldarg.0
    IL_0018: call !!0 UnityEngine.Component::GetComponent()<BuildSlot>  /*0x2B00001A*/
    IL_001d: stloc.0
    IL_001e: ldloc.0
    IL_001f: callvirt List<BuildSlot> BuildSlot::get_IsRootOf()  /*0x060002C8*/
    IL_0024: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_0029: stloc.1
    IL_002a: br.s IL_0056
    IL_002c: ldloca.s 1
    IL_002e: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_0033: stloc.2
    IL_0034: ldloc.2
    IL_0035: callvirt BuildSlot BuildSlot::get_ActivatorBuilding()  /*0x060002CA*/
    IL_003a: ldloc.0
    IL_003b: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0040: brfalse.s IL_0056
    IL_0042: ldloc.2
    IL_0043: ldc.i4.0
    IL_0044: ldloc.2
    IL_0045: callvirt int BuildSlot::get_ActivatorLevel()  /*0x060002CE*/
    IL_004a: ldc.i4.1
    IL_004b: sub
    IL_004c: call int UnityEngine.Mathf::Max(int,int)  /*0x0A0002B2*/
    IL_0051: callvirt void BuildSlot::set_ActivatorLevel(int)  /*0x060002CF*/
    IL_0056: ldloca.s 1
    IL_0058: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_005d: brtrue.s IL_002c
    IL_005f: leave.s IL_006f
    IL_0061: ldloca.s 1
    IL_0063: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_0069: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006e: endfinally
    IL_006f: ldarg.0
    IL_0070: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0075: ret
    .try IL_002a-IL_0061 finally handler IL_0061-IL_006f

  .method ReduceChildrensBuildRequirementIfPerk::.ctor()  // token 0x06000CAC rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

