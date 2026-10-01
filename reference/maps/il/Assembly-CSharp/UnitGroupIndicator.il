// ===== UnitGroupIndicator  (token 0x020003A2) =====
  .method UnitGroupIndicator::Start()  // token 0x060013DB rva 0x5e71c attrs Private, HideBySig
    // code size 103 (0x67), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.SpriteRenderer>  /*0x2B00011D*/
    IL_0007: stfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: callvirt !!0 UnityEngine.GameObject::GetComponentInParent()<TaggedObject>  /*0x2B00011E*/
    IL_0018: stfld TaggedObject UnitGroupIndicator::taggedObject  /*0x04001842*/
    IL_001d: ldarg.0
    IL_001e: ldfld TaggedObject UnitGroupIndicator::taggedObject  /*0x04001842*/
    IL_0023: ldfld UnityEvent TaggedObject::onUnitGroupChanged  /*0x04001086*/
    IL_0028: ldarg.0
    IL_0029: ldftn void UnitGroupIndicator::OnUnitGroupChanged()  /*0x060013DD*/
    IL_002f: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0034: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0039: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_003e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0043: brfalse.s IL_0060
    IL_0045: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_004a: ldfld UnityEvent SettingsManager::onEnableControlGroupsChange  /*0x04000FFA*/
    IL_004f: ldarg.0
    IL_0050: ldftn void UnitGroupIndicator::Refresh()  /*0x060013DC*/
    IL_0056: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_005b: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0060: ldarg.0
    IL_0061: call void UnitGroupIndicator::OnUnitGroupChanged()  /*0x060013DD*/
    IL_0066: ret

  .method UnitGroupIndicator::Refresh()  // token 0x060013DC rva 0x5e78f attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_0006: callvirt bool SettingsManager::get_EnableControlGroups()  /*0x06000DAC*/
    IL_000b: call void UnitGroupIndicator::SetUnitGroupIndicatorVisible(bool)  /*0x060013E0*/
    IL_0010: ret

  .method UnitGroupIndicator::OnUnitGroupChanged()  // token 0x060013DD rva 0x5e7a4 attrs Private, HideBySig
    // code size 176 (0xb0), max stack 2, init locals
    .locals ([0] List.Enumerator<UnitGroupIndicator.GroupIcon>, [1] UnitGroupIndicator.GroupIcon)
    IL_0000: ldarg.0
    IL_0001: ldfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldsfld ControlGroupUIHelper ControlGroupUIHelper::instance  /*0x04000009*/
    IL_0014: callvirt void ControlGroupUIHelper::RefreshGroupFlags()  /*0x0600000B*/
    IL_0019: call SettingsManager SettingsManager::get_Instance()  /*0x06000D9A*/
    IL_001e: callvirt bool SettingsManager::get_EnableControlGroups()  /*0x06000DAC*/
    IL_0023: brfalse.s IL_00a3
    IL_0025: ldarg.0
    IL_0026: ldfld List<UnitGroupIndicator.GroupIcon> UnitGroupIndicator::groups  /*0x04001844*/
    IL_002b: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnitGroupIndicator.GroupIcon>::GetEnumerator()  /*0x0A000785*/
    IL_0030: stloc.0
    IL_0031: br.s IL_0083
    IL_0033: ldloca.s 0
    IL_0035: call !0 System.Collections.Generic.List.Enumerator<UnitGroupIndicator.GroupIcon>::get_Current()  /*0x0A000786*/
    IL_003a: stloc.1
    IL_003b: ldarg.0
    IL_003c: ldfld TaggedObject UnitGroupIndicator::taggedObject  /*0x04001842*/
    IL_0041: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0046: ldloc.1
    IL_0047: ldfld TagManager.ETag UnitGroupIndicator.GroupIcon::groupTag  /*0x04001846*/
    IL_004c: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_0051: brfalse.s IL_0083
    IL_0053: ldarg.0
    IL_0054: ldfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_0059: ldc.i4.1
    IL_005a: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_005f: ldarg.0
    IL_0060: ldfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_0065: ldloc.1
    IL_0066: ldfld Sprite UnitGroupIndicator.GroupIcon::sprite  /*0x04001847*/
    IL_006b: callvirt void UnityEngine.SpriteRenderer::set_sprite(UnityEngine.Sprite)  /*0x0A000787*/
    IL_0070: ldarg.0
    IL_0071: ldfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_0076: ldloc.1
    IL_0077: ldfld Material UnitGroupIndicator.GroupIcon::mat  /*0x04001848*/
    IL_007c: callvirt void UnityEngine.Renderer::set_material(UnityEngine.Material)  /*0x0A000788*/
    IL_0081: leave.s IL_00af
    IL_0083: ldloca.s 0
    IL_0085: call bool System.Collections.Generic.List.Enumerator<UnitGroupIndicator.GroupIcon>::MoveNext()  /*0x0A000789*/
    IL_008a: brtrue.s IL_0033
    IL_008c: leave.s IL_009c
    IL_008e: ldloca.s 0
    IL_0090: constrained. System.Collections.Generic.List.Enumerator<UnitGroupIndicator.GroupIcon>  /*0x1B000166*/
    IL_0096: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_009b: endfinally
    IL_009c: ldarg.0
    IL_009d: call void UnitGroupIndicator::RemoveGroupIndicator()  /*0x060013DE*/
    IL_00a2: ret
    IL_00a3: ldarg.0
    IL_00a4: ldfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_00a9: ldc.i4.0
    IL_00aa: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_00af: ret
    .try IL_0031-IL_008e finally handler IL_008e-IL_009c

  .method UnitGroupIndicator::RemoveGroupIndicator()  // token 0x060013DE rva 0x5e870 attrs Private, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call IEnumerator UnitGroupIndicator::DoRemoveGroupIndicator()  /*0x060013DF*/
    IL_000d: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0012: pop
    IL_0013: ret

  .method UnitGroupIndicator::DoRemoveGroupIndicator()  // token 0x060013DF rva 0x5e885 attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::.ctor(int)  /*0x060013E2*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld UnitGroupIndicator UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>4__this  /*0x0400184B*/
    IL_000d: ret

  .method UnitGroupIndicator::SetUnitGroupIndicatorVisible(bool)  // token 0x060013E0 rva 0x5e894 attrs Public, HideBySig
    // code size 38 (0x26), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.1
    IL_0010: brfalse.s IL_0019
    IL_0012: ldarg.0
    IL_0013: call void UnitGroupIndicator::OnUnitGroupChanged()  /*0x060013DD*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_001f: ldc.i4.0
    IL_0020: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_0025: ret

  .method UnitGroupIndicator::.ctor()  // token 0x060013E1 rva 0x5e8bb attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<UnitGroupIndicator.GroupIcon>::.ctor()  /*0x0A00078A*/
    IL_0006: stfld List<UnitGroupIndicator.GroupIcon> UnitGroupIndicator::groups  /*0x04001844*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.5f
    IL_0011: stfld float UnitGroupIndicator::removeTime  /*0x04001845*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

// ===== UnitGroupIndicator/GroupIcon  (token 0x020003A3) =====
// ===== UnitGroupIndicator/<DoRemoveGroupIndicator>d__9  (token 0x020003A4) =====
  .method UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::.ctor(int)  // token 0x060013E2 rva 0x5e8d9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>1__state  /*0x04001849*/
    IL_000d: ret

  .method UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::System.IDisposable.Dispose()  // token 0x060013E3 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::MoveNext()  // token 0x060013E4 rva 0x5e8e8 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 112 (0x70), max stack 3, init locals
    .locals ([0] int, [1] UnitGroupIndicator)
    IL_0000: ldarg.0
    IL_0001: ldfld int UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>1__state  /*0x04001849*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld UnitGroupIndicator UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>4__this  /*0x0400184B*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_004d
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>1__state  /*0x04001849*/
    IL_001e: ldarg.0
    IL_001f: ldc.r4 0f
    IL_0024: stfld float UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<elapsedTime>5__2  /*0x0400184C*/
    IL_0029: br.s IL_0054
    IL_002b: ldarg.0
    IL_002c: ldarg.0
    IL_002d: ldfld float UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<elapsedTime>5__2  /*0x0400184C*/
    IL_0032: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0037: add
    IL_0038: stfld float UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<elapsedTime>5__2  /*0x0400184C*/
    IL_003d: ldarg.0
    IL_003e: ldnull
    IL_003f: stfld object UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>2__current  /*0x0400184A*/
    IL_0044: ldarg.0
    IL_0045: ldc.i4.1
    IL_0046: stfld int UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>1__state  /*0x04001849*/
    IL_004b: ldc.i4.1
    IL_004c: ret
    IL_004d: ldarg.0
    IL_004e: ldc.i4.m1
    IL_004f: stfld int UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>1__state  /*0x04001849*/
    IL_0054: ldarg.0
    IL_0055: ldfld float UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<elapsedTime>5__2  /*0x0400184C*/
    IL_005a: ldloc.1
    IL_005b: ldfld float UnitGroupIndicator::removeTime  /*0x04001845*/
    IL_0060: blt.s IL_002b
    IL_0062: ldloc.1
    IL_0063: ldfld SpriteRenderer UnitGroupIndicator::groupIndicator  /*0x04001843*/
    IL_0068: ldc.i4.0
    IL_0069: callvirt void UnityEngine.Renderer::set_enabled(bool)  /*0x0A000364*/
    IL_006e: ldc.i4.0
    IL_006f: ret

  .method UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060013E5 rva 0x5e964 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>2__current  /*0x0400184A*/
    IL_0006: ret

  .method UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::System.Collections.IEnumerator.Reset()  // token 0x060013E6 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::System.Collections.IEnumerator.get_Current()  // token 0x060013E7 rva 0x5e964 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object UnitGroupIndicator.<DoRemoveGroupIndicator>d__9::<>2__current  /*0x0400184A*/
    IL_0006: ret

