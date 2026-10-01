// ===== ReverseSiegeManager  (token 0x02000253) =====
  .method ReverseSiegeManager::Start()  // token 0x06000CAD rva 0x3a390 attrs Private, HideBySig
    // code size 97 (0x61), max stack 2, init locals
    .locals ([0] List.Enumerator<GameObject>)
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: ldfld GameObject ReverseSiegeManager::uphillBlocker  /*0x04000F5A*/
    IL_0011: ldc.i4.1
    IL_0012: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0017: ldarg.0
    IL_0018: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_001d: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0022: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0027: stfld Vector3 ReverseSiegeManager::playerStartPos  /*0x04000F5C*/
    IL_002c: ldarg.0
    IL_002d: ldfld List<GameObject> ReverseSiegeManager::enemyBaseSetups  /*0x04000F5B*/
    IL_0032: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_0037: stloc.0
    IL_0038: br.s IL_0047
    IL_003a: ldloca.s 0
    IL_003c: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0041: ldc.i4.0
    IL_0042: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0047: ldloca.s 0
    IL_0049: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_004e: brtrue.s IL_003a
    IL_0050: leave.s IL_0060
    IL_0052: ldloca.s 0
    IL_0054: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_005a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_005f: endfinally
    IL_0060: ret
    .try IL_0038-IL_0052 finally handler IL_0052-IL_0060

  .method ReverseSiegeManager::OnDawn_BeforeSunrise()  // token 0x06000CAE rva 0x3a410 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 53 (0x35), max stack 2, init locals
    .locals ([0] List.Enumerator<GameObject>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<GameObject> ReverseSiegeManager::enemyBaseSetups  /*0x04000F5B*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_000b: stloc.0
    IL_000c: br.s IL_001b
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0015: ldc.i4.0
    IL_0016: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001b: ldloca.s 0
    IL_001d: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0022: brtrue.s IL_000e
    IL_0024: leave.s IL_0034
    IL_0026: ldloca.s 0
    IL_0028: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_002e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0033: endfinally
    IL_0034: ret
    .try IL_000c-IL_0026 finally handler IL_0026-IL_0034

  .method ReverseSiegeManager::OnDawn_AfterSunrise()  // token 0x06000CAF rva 0x3a464 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 130 (0x82), max stack 3, init locals
    .locals ([0] List<TaggedObject>, [1] List.Enumerator<TaggedObject>, [2] PathfindMovementPlayerunit)
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ReverseSiegeManager::uphillBlocker  /*0x04000F5A*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldsfld PlayerMovement PlayerMovement::instance  /*0x04000EF6*/
    IL_0011: ldarg.0
    IL_0012: ldfld Vector3 ReverseSiegeManager::playerStartPos  /*0x04000F5C*/
    IL_0017: callvirt void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_001c: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0021: stloc.0
    IL_0022: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0027: ldloc.0
    IL_0028: ldc.i4.7
    IL_0029: callvirt void TagManager::FindAllTaggedObjectsWithTag(System.Collections.Generic.List<TaggedObject>,TagManager.ETag)  /*0x06000E5C*/
    IL_002e: ldloc.0
    IL_002f: callvirt List.Enumerator<!0> System.Collections.Generic.List<TaggedObject>::GetEnumerator()  /*0x0A000049*/
    IL_0034: stloc.1
    IL_0035: br.s IL_0068
    IL_0037: ldloca.s 1
    IL_0039: call !0 System.Collections.Generic.List.Enumerator<TaggedObject>::get_Current()  /*0x0A00004A*/
    IL_003e: callvirt !!0 UnityEngine.Component::GetComponent()<PathfindMovementPlayerunit>  /*0x2B00008A*/
    IL_0043: stloc.2
    IL_0044: ldloc.2
    IL_0045: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004a: ldloc.2
    IL_004b: callvirt Vector3 PathfindMovementPlayerunit::get_HomePositionOriginal()  /*0x06000B29*/
    IL_0050: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0055: ldloc.2
    IL_0056: ldloc.2
    IL_0057: callvirt Vector3 PathfindMovementPlayerunit::get_HomePositionOriginal()  /*0x06000B29*/
    IL_005c: callvirt void PathfindMovementPlayerunit::set_HomePosition(UnityEngine.Vector3)  /*0x06000B2B*/
    IL_0061: ldloc.2
    IL_0062: ldc.i4.0
    IL_0063: callvirt void PathfindMovementPlayerunit::set_HoldPosition(bool)  /*0x06000B34*/
    IL_0068: ldloca.s 1
    IL_006a: call bool System.Collections.Generic.List.Enumerator<TaggedObject>::MoveNext()  /*0x0A00004C*/
    IL_006f: brtrue.s IL_0037
    IL_0071: leave.s IL_0081
    IL_0073: ldloca.s 1
    IL_0075: constrained. System.Collections.Generic.List.Enumerator<TaggedObject>  /*0x1B000008*/
    IL_007b: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0080: endfinally
    IL_0081: ret
    .try IL_0035-IL_0073 finally handler IL_0073-IL_0081

  .method ReverseSiegeManager::OnDusk()  // token 0x06000CB0 rva 0x3a504 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ReverseSiegeManager::uphillBlocker  /*0x04000F5A*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method ReverseSiegeManager::OnDuskEarly()  // token 0x06000CB1 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method ReverseSiegeManager::.ctor()  // token 0x06000CB2 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

