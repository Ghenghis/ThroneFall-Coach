// ===== UnitProductionSelector  (token 0x02000390) =====
  .method UnitProductionSelector::Clear()  // token 0x06001397 rva 0x5ccce attrs Public, Static, HideBySig
    // code size 11 (0xb), max stack 8
    IL_0000: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_0005: callvirt void System.Collections.Generic.List<UnitProductionSelector>::Clear()  /*0x0A000770*/
    IL_000a: ret

  .method UnitProductionSelector::OnEnable()  // token 0x06001398 rva 0x5ccdc attrs Private, HideBySig
    // code size 85 (0x55), max stack 3, init locals
    IL_0000: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void System.Collections.Generic.List<UnitProductionSelector>::Add(!0)  /*0x0A000771*/
    IL_000b: ldarg.0
    IL_000c: ldfld SelectUnitUI UnitProductionSelector::mySelectUnitUI  /*0x040017D2*/
    IL_0011: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0016: brtrue.s IL_0054
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: ldfld GameObject UnitProductionSelector::selectUnitUIPrefab  /*0x040017CD*/
    IL_001f: ldarg.0
    IL_0020: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0025: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B000019*/
    IL_002a: callvirt !!0 UnityEngine.GameObject::GetComponent()<SelectUnitUI>  /*0x2B000110*/
    IL_002f: stfld SelectUnitUI UnitProductionSelector::mySelectUnitUI  /*0x040017D2*/
    IL_0034: ldarg.0
    IL_0035: ldfld SelectUnitUI UnitProductionSelector::mySelectUnitUI  /*0x040017D2*/
    IL_003a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003f: ldarg.0
    IL_0040: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0045: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_004a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004f: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0054: ret

  .method UnitProductionSelector::OnDisable()  // token 0x06001399 rva 0x5cd3d attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void System.Collections.Generic.List<UnitProductionSelector>::Add(!0)  /*0x0A000771*/
    IL_000b: ret

  .method UnitProductionSelector::FindClosestToPoint(UnityEngine.Vector3,ref float)  // token 0x0600139A rva 0x5cd4c attrs Public, Static, HideBySig
    // code size 143 (0x8f), max stack 3, init locals
    .locals ([0] UnitProductionSelector, [1] int, [2] float)
    IL_0000: ldnull
    IL_0001: stloc.0
    IL_0002: ldarg.1
    IL_0003: ldc.r4 3.4028235E+38f
    IL_0008: stind.r4
    IL_0009: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_000e: callvirt int System.Collections.Generic.List<UnitProductionSelector>::get_Count()  /*0x0A000772*/
    IL_0013: ldc.i4.1
    IL_0014: sub
    IL_0015: stloc.1
    IL_0016: br.s IL_0089
    IL_0018: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_001d: ldloc.1
    IL_001e: callvirt !0 System.Collections.Generic.List<UnitProductionSelector>::get_Item(int)  /*0x0A000773*/
    IL_0023: ldnull
    IL_0024: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0029: brfalse.s IL_0038
    IL_002b: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_0030: ldloc.1
    IL_0031: callvirt void System.Collections.Generic.List<UnitProductionSelector>::RemoveAt(int)  /*0x0A000774*/
    IL_0036: br.s IL_0085
    IL_0038: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_003d: ldloc.1
    IL_003e: callvirt !0 System.Collections.Generic.List<UnitProductionSelector>::get_Item(int)  /*0x0A000773*/
    IL_0043: ldfld Collider UnitProductionSelector::measureDistanceCollider  /*0x040017CE*/
    IL_0048: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_004d: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0052: brfalse.s IL_0085
    IL_0054: ldarg.0
    IL_0055: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_005a: ldloc.1
    IL_005b: callvirt !0 System.Collections.Generic.List<UnitProductionSelector>::get_Item(int)  /*0x0A000773*/
    IL_0060: ldfld Collider UnitProductionSelector::measureDistanceCollider  /*0x040017CE*/
    IL_0065: ldarg.0
    IL_0066: callvirt Vector3 UnityEngine.Collider::ClosestPoint(UnityEngine.Vector3)  /*0x0A000066*/
    IL_006b: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_0070: stloc.2
    IL_0071: ldloc.2
    IL_0072: ldarg.1
    IL_0073: ldind.r4
    IL_0074: bge.un.s IL_0085
    IL_0076: ldarg.1
    IL_0077: ldloc.2
    IL_0078: stind.r4
    IL_0079: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_007e: ldloc.1
    IL_007f: callvirt !0 System.Collections.Generic.List<UnitProductionSelector>::get_Item(int)  /*0x0A000773*/
    IL_0084: stloc.0
    IL_0085: ldloc.1
    IL_0086: ldc.i4.1
    IL_0087: sub
    IL_0088: stloc.1
    IL_0089: ldloc.1
    IL_008a: ldc.i4.0
    IL_008b: bge.s IL_0018
    IL_008d: ldloc.0
    IL_008e: ret

  .method UnitProductionSelector::CustomUpdate(UnitProductionSelector,bool,bool)  // token 0x0600139B rva 0x5cde8 attrs Public, Static, HideBySig
    // code size 255 (0xff), max stack 4, init locals
    .locals ([0] List.Enumerator<UnitProductionSelector>, [1] UnitProductionSelector, [2] bool)
    IL_0000: ldsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_0005: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnitProductionSelector>::GetEnumerator()  /*0x0A000775*/
    IL_000a: stloc.0
    IL_000b: br IL_00e2
    IL_0010: ldloca.s 0
    IL_0012: call !0 System.Collections.Generic.List.Enumerator<UnitProductionSelector>::get_Current()  /*0x0A000776*/
    IL_0017: stloc.1
    IL_0018: ldloc.1
    IL_0019: ldnull
    IL_001a: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001f: brtrue IL_00e2
    IL_0024: ldloc.1
    IL_0025: ldarg.0
    IL_0026: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002b: brfalse IL_00c5
    IL_0030: ldarg.1
    IL_0031: brfalse.s IL_0077
    IL_0033: ldloc.1
    IL_0034: ldfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_0039: ldc.r4 1f
    IL_003e: clt
    IL_0040: stloc.2
    IL_0041: ldloc.1
    IL_0042: dup
    IL_0043: ldfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_0048: ldloc.1
    IL_0049: ldfld float UnitProductionSelector::selectSpeed  /*0x040017CF*/
    IL_004e: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0053: mul
    IL_0054: add
    IL_0055: stfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_005a: ldloc.1
    IL_005b: ldfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_0060: ldc.r4 1f
    IL_0065: clt.un
    IL_0067: ldc.i4.0
    IL_0068: ceq
    IL_006a: ldloc.2
    IL_006b: and
    IL_006c: brfalse.s IL_0090
    IL_006e: ldloc.1
    IL_006f: ldarg.2
    IL_0070: callvirt void UnitProductionSelector::CommandAllMyUnits(bool)  /*0x0600139C*/
    IL_0075: br.s IL_0090
    IL_0077: ldloc.1
    IL_0078: dup
    IL_0079: ldfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_007e: ldloc.1
    IL_007f: ldfld float UnitProductionSelector::deselectSpeed  /*0x040017D0*/
    IL_0084: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0089: mul
    IL_008a: sub
    IL_008b: stfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_0090: ldloc.1
    IL_0091: ldloc.1
    IL_0092: ldfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_0097: ldc.r4 0f
    IL_009c: ldc.r4 1f
    IL_00a1: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_00a6: stfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_00ab: ldloc.1
    IL_00ac: ldfld SelectUnitUI UnitProductionSelector::mySelectUnitUI  /*0x040017D2*/
    IL_00b1: ldc.i4.1
    IL_00b2: ldloc.1
    IL_00b3: ldfld Sprite UnitProductionSelector::unitSprite  /*0x040017CC*/
    IL_00b8: ldloc.1
    IL_00b9: ldfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_00be: callvirt void SelectUnitUI::UpdateState(bool,UnityEngine.Sprite,float)  /*0x060011B8*/
    IL_00c3: br.s IL_00e2
    IL_00c5: ldloc.1
    IL_00c6: ldc.r4 0f
    IL_00cb: stfld float UnitProductionSelector::currentSelectProgress  /*0x040017D3*/
    IL_00d0: ldloc.1
    IL_00d1: ldfld SelectUnitUI UnitProductionSelector::mySelectUnitUI  /*0x040017D2*/
    IL_00d6: ldc.i4.0
    IL_00d7: ldnull
    IL_00d8: ldc.r4 0f
    IL_00dd: callvirt void SelectUnitUI::UpdateState(bool,UnityEngine.Sprite,float)  /*0x060011B8*/
    IL_00e2: ldloca.s 0
    IL_00e4: call bool System.Collections.Generic.List.Enumerator<UnitProductionSelector>::MoveNext()  /*0x0A000777*/
    IL_00e9: brtrue IL_0010
    IL_00ee: leave.s IL_00fe
    IL_00f0: ldloca.s 0
    IL_00f2: constrained. System.Collections.Generic.List.Enumerator<UnitProductionSelector>  /*0x1B000162*/
    IL_00f8: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00fd: endfinally
    IL_00fe: ret
    .try IL_000b-IL_00f0 finally handler IL_00f0-IL_00fe

  .method UnitProductionSelector::CommandAllMyUnits(bool)  // token 0x0600139C rva 0x5cf04 attrs Private, HideBySig
    // code size 68 (0x44), max stack 3, init locals
    .locals ([0] int, [1] Transform, [2] TaggedObject)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_0035
    IL_0004: ldarg.0
    IL_0005: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000a: ldloc.0
    IL_000b: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0010: stloc.1
    IL_0011: ldloc.1
    IL_0012: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0017: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_001c: brfalse.s IL_0031
    IL_001e: ldloc.1
    IL_001f: callvirt !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_0024: stloc.2
    IL_0025: ldsfld CommandUnits CommandUnits::instance  /*0x04000DAD*/
    IL_002a: ldloc.2
    IL_002b: ldarg.1
    IL_002c: callvirt void CommandUnits::OnUnitAdd(TaggedObject,bool)  /*0x06000B02*/
    IL_0031: ldloc.0
    IL_0032: ldc.i4.1
    IL_0033: add
    IL_0034: stloc.0
    IL_0035: ldloc.0
    IL_0036: ldarg.0
    IL_0037: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003c: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0041: blt.s IL_0004
    IL_0043: ret

  .method UnitProductionSelector::.ctor()  // token 0x0600139D rva 0x5cf54 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float UnitProductionSelector::selectSpeed  /*0x040017CF*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1.5f
    IL_0011: stfld float UnitProductionSelector::deselectSpeed  /*0x040017D0*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

  .method UnitProductionSelector::.cctor()  // token 0x0600139E rva 0x5cf72 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void System.Collections.Generic.List<UnitProductionSelector>::.ctor()  /*0x0A000778*/
    IL_0005: stsfld List<UnitProductionSelector> UnitProductionSelector::allUnitProductionSelectors  /*0x040017D1*/
    IL_000a: ret

