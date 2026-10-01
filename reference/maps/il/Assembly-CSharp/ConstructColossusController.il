// ===== ConstructColossusController  (token 0x020000F2) =====
  .method ConstructColossusController::GoToNextTarget(ConstructColossusController.TargetItem)  // token 0x0600051D rva 0x167b0 attrs Public, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0014
    IL_0003: ldarg.1
    IL_0004: ldfld AutoAttack ConstructColossusController.TargetItem::Attack  /*0x040006B1*/
    IL_0009: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000e: ldc.i4.1
    IL_000f: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0014: ldarg.0
    IL_0015: ldfld UnityEvent<ConstructColossusController.TargetItem> ConstructColossusController::OnTargetPickupFinished  /*0x040006A6*/
    IL_001a: dup
    IL_001b: brtrue.s IL_0020
    IL_001d: pop
    IL_001e: br.s IL_0026
    IL_0020: ldarg.1
    IL_0021: call void UnityEngine.Events.UnityEvent<ConstructColossusController.TargetItem>::Invoke(!0)  /*0x0A000220*/
    IL_0026: ldarg.0
    IL_0027: call void ConstructColossusController::SetNewTarget()  /*0x0600051E*/
    IL_002c: ldarg.0
    IL_002d: ldc.i4.0
    IL_002e: stfld bool ConstructColossusController::_targetInvoked  /*0x040006AE*/
    IL_0033: ret

  .method ConstructColossusController::SetNewTarget()  // token 0x0600051E rva 0x167e8 attrs Private, HideBySig
    // code size 189 (0xbd), max stack 8, init locals
    .locals ([0] TargetPriority, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TargetPriority> ConstructColossusController::_targetPriority  /*0x040006AB*/
    IL_0006: dup
    IL_0007: brtrue.s IL_000c
    IL_0009: pop
    IL_000a: br.s IL_0011
    IL_000c: call void System.Collections.Generic.List<TargetPriority>::Clear()  /*0x0A000207*/
    IL_0011: ldarg.0
    IL_0012: ldfld List<TargetPriority> ConstructColossusController::_targetPriority  /*0x040006AB*/
    IL_0017: brfalse IL_00ab
    IL_001c: ldarg.0
    IL_001d: ldfld int ConstructColossusController::_nextTargetIdx  /*0x040006AD*/
    IL_0022: ldarg.0
    IL_0023: ldfld List<ConstructColossusController.TargetItem> ConstructColossusController::_targets  /*0x040006A9*/
    IL_0028: callvirt int System.Collections.Generic.List<ConstructColossusController.TargetItem>::get_Count()  /*0x0A000221*/
    IL_002d: bge.s IL_00ab
    IL_002f: ldarg.0
    IL_0030: ldfld UnityEvent<ConstructColossusController.TargetItem> ConstructColossusController::OnSetNewTarget  /*0x040006A7*/
    IL_0035: dup
    IL_0036: brtrue.s IL_003b
    IL_0038: pop
    IL_0039: br.s IL_0051
    IL_003b: ldarg.0
    IL_003c: ldfld List<ConstructColossusController.TargetItem> ConstructColossusController::_targets  /*0x040006A9*/
    IL_0041: ldarg.0
    IL_0042: ldfld int ConstructColossusController::_nextTargetIdx  /*0x040006AD*/
    IL_0047: callvirt !0 System.Collections.Generic.List<ConstructColossusController.TargetItem>::get_Item(int)  /*0x0A000222*/
    IL_004c: call void UnityEngine.Events.UnityEvent<ConstructColossusController.TargetItem>::Invoke(!0)  /*0x0A000220*/
    IL_0051: newobj void TargetPriority::.ctor()  /*0x06000E80*/
    IL_0056: dup
    IL_0057: newobj void System.Collections.Generic.List<TagManager.ETag>::.ctor()  /*0x0A00001E*/
    IL_005c: dup
    IL_005d: ldarg.0
    IL_005e: ldfld List<ConstructColossusController.TargetItem> ConstructColossusController::_targets  /*0x040006A9*/
    IL_0063: ldarg.0
    IL_0064: ldarg.0
    IL_0065: ldfld int ConstructColossusController::_nextTargetIdx  /*0x040006AD*/
    IL_006a: stloc.1
    IL_006b: ldloc.1
    IL_006c: ldc.i4.1
    IL_006d: add
    IL_006e: stfld int ConstructColossusController::_nextTargetIdx  /*0x040006AD*/
    IL_0073: ldloc.1
    IL_0074: callvirt !0 System.Collections.Generic.List<ConstructColossusController.TargetItem>::get_Item(int)  /*0x0A000222*/
    IL_0079: ldfld TaggedObject ConstructColossusController.TargetItem::Target  /*0x040006AF*/
    IL_007e: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_0083: ldc.i4.0
    IL_0084: callvirt !0 System.Collections.Generic.List<TagManager.ETag>::get_Item(int)  /*0x0A00019B*/
    IL_0089: callvirt void System.Collections.Generic.List<TagManager.ETag>::Add(!0)  /*0x0A000013*/
    IL_008e: stfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_0093: dup
    IL_0094: ldc.r4 10000f
    IL_0099: stfld float TargetPriority::range  /*0x040010D2*/
    IL_009e: stloc.0
    IL_009f: ldarg.0
    IL_00a0: ldfld List<TargetPriority> ConstructColossusController::_targetPriority  /*0x040006AB*/
    IL_00a5: ldloc.0
    IL_00a6: callvirt void System.Collections.Generic.List<TargetPriority>::Add(!0)  /*0x0A000208*/
    IL_00ab: ldarg.0
    IL_00ac: ldfld List<TargetPriority> ConstructColossusController::_targetPriority  /*0x040006AB*/
    IL_00b1: ldarg.0
    IL_00b2: ldfld List<TargetPriority> ConstructColossusController::_targetPriorityCache  /*0x040006AC*/
    IL_00b7: callvirt void System.Collections.Generic.List<TargetPriority>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00020B*/
    IL_00bc: ret

  .method ConstructColossusController::Awake()  // token 0x0600051F rva 0x168b4 attrs Private, HideBySig
    // code size 134 (0x86), max stack 3, init locals
    .locals ([0] List.Enumerator<ConstructColossusController.TargetItem>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<ConstructColossusController.TargetItem> ConstructColossusController::_targets  /*0x040006A9*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<ConstructColossusController.TargetItem>::GetEnumerator()  /*0x0A000223*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0025
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<ConstructColossusController.TargetItem>::get_Current()  /*0x0A000224*/
    IL_0015: ldfld AutoAttack ConstructColossusController.TargetItem::Attack  /*0x040006B1*/
    IL_001a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001f: ldc.i4.0
    IL_0020: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0025: ldloca.s 0
    IL_0027: call bool System.Collections.Generic.List.Enumerator<ConstructColossusController.TargetItem>::MoveNext()  /*0x0A000225*/
    IL_002c: brtrue.s IL_000e
    IL_002e: leave.s IL_003e
    IL_0030: ldloca.s 0
    IL_0032: constrained. System.Collections.Generic.List.Enumerator<ConstructColossusController.TargetItem>  /*0x1B000057*/
    IL_0038: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_003d: endfinally
    IL_003e: ldarg.0
    IL_003f: ldarg.0
    IL_0040: call !!0 UnityEngine.Component::GetComponent()<PathfindMovementEnemy>  /*0x2B00000E*/
    IL_0045: dup
    IL_0046: brtrue.s IL_004c
    IL_0048: pop
    IL_0049: ldnull
    IL_004a: br.s IL_0051
    IL_004c: ldfld List<TargetPriority> PathfindMovementEnemy::targetPriorities  /*0x04000DD9*/
    IL_0051: stfld List<TargetPriority> ConstructColossusController::_targetPriority  /*0x040006AB*/
    IL_0056: ldarg.0
    IL_0057: ldfld List<TargetPriority> ConstructColossusController::_targetPriorityCache  /*0x040006AC*/
    IL_005c: ldarg.0
    IL_005d: ldfld List<TargetPriority> ConstructColossusController::_targetPriority  /*0x040006AB*/
    IL_0062: callvirt void System.Collections.Generic.List<TargetPriority>::AddRange(System.Collections.Generic.IEnumerable<!0>)  /*0x0A00020B*/
    IL_0067: ldarg.0
    IL_0068: ldfld UnityEvent<ConstructColossusController.TargetItem> ConstructColossusController::OnTargetPickupStarted  /*0x040006A5*/
    IL_006d: ldarg.0
    IL_006e: ldftn void ConstructColossusController::<Awake>b__13_0(ConstructColossusController.TargetItem)  /*0x06000522*/
    IL_0074: newobj void UnityEngine.Events.UnityAction<ConstructColossusController.TargetItem>::.ctor(object,IntPtr)  /*0x0A000226*/
    IL_0079: callvirt void UnityEngine.Events.UnityEvent<ConstructColossusController.TargetItem>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A000227*/
    IL_007e: ldarg.0
    IL_007f: ldnull
    IL_0080: call void ConstructColossusController::GoToNextTarget(ConstructColossusController.TargetItem)  /*0x0600051D*/
    IL_0085: ret
    .try IL_000c-IL_0030 finally handler IL_0030-IL_003e

  .method ConstructColossusController::Update()  // token 0x06000520 rva 0x16958 attrs Private, HideBySig
    // code size 122 (0x7a), max stack 4, init locals
    .locals ([0] int, [1] ConstructColossusController.TargetItem, [2] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld int ConstructColossusController::_nextTargetIdx  /*0x040006AD*/
    IL_0006: ldc.i4.1
    IL_0007: sub
    IL_0008: ldc.i4.0
    IL_0009: ldarg.0
    IL_000a: ldfld List<ConstructColossusController.TargetItem> ConstructColossusController::_targets  /*0x040006A9*/
    IL_000f: callvirt int System.Collections.Generic.List<ConstructColossusController.TargetItem>::get_Count()  /*0x0A000221*/
    IL_0014: ldc.i4.1
    IL_0015: sub
    IL_0016: call int UnityEngine.Mathf::Clamp(int,int,int)  /*0x0A000228*/
    IL_001b: stloc.0
    IL_001c: ldarg.0
    IL_001d: ldfld List<ConstructColossusController.TargetItem> ConstructColossusController::_targets  /*0x040006A9*/
    IL_0022: ldloc.0
    IL_0023: callvirt !0 System.Collections.Generic.List<ConstructColossusController.TargetItem>::get_Item(int)  /*0x0A000222*/
    IL_0028: stloc.1
    IL_0029: ldloc.1
    IL_002a: ldfld TaggedObject ConstructColossusController.TargetItem::Target  /*0x040006AF*/
    IL_002f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0034: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0039: ldarg.0
    IL_003a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0044: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0049: stloc.2
    IL_004a: ldloca.s 2
    IL_004c: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0051: ldc.r4 9f
    IL_0056: bge.un.s IL_0079
    IL_0058: ldarg.0
    IL_0059: ldfld bool ConstructColossusController::_targetInvoked  /*0x040006AE*/
    IL_005e: brtrue.s IL_0079
    IL_0060: ldarg.0
    IL_0061: ldfld UnityEvent<ConstructColossusController.TargetItem> ConstructColossusController::OnTargetPickupStarted  /*0x040006A5*/
    IL_0066: dup
    IL_0067: brtrue.s IL_006c
    IL_0069: pop
    IL_006a: br.s IL_0072
    IL_006c: ldloc.1
    IL_006d: call void UnityEngine.Events.UnityEvent<ConstructColossusController.TargetItem>::Invoke(!0)  /*0x0A000220*/
    IL_0072: ldarg.0
    IL_0073: ldc.i4.1
    IL_0074: stfld bool ConstructColossusController::_targetInvoked  /*0x040006AE*/
    IL_0079: ret

  .method ConstructColossusController::.ctor()  // token 0x06000521 rva 0x169de attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TargetPriority>::.ctor()  /*0x0A0000E5*/
    IL_0006: stfld List<TargetPriority> ConstructColossusController::_targetPriorityCache  /*0x040006AC*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

  .method ConstructColossusController::<Awake>b__13_0(ConstructColossusController.TargetItem)  // token 0x06000522 rva 0x169f1 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld InstantEnemySpawn ConstructColossusController::_instantSpawner  /*0x040006A8*/
    IL_0006: callvirt void InstantEnemySpawn::SpawnWave()  /*0x06000859*/
    IL_000b: ret

// ===== ConstructColossusController/TargetItem  (token 0x020000F3) =====
  .method ConstructColossusController.TargetItem::.ctor()  // token 0x06000523 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

