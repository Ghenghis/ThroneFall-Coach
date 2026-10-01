// ===== ConstructColossusPickUpHandler  (token 0x020000F4) =====
  .method ConstructColossusPickUpHandler::Awake()  // token 0x06000524 rva 0x169fe attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponentInParent()<ConstructColossusController>  /*0x2B00003B*/
    IL_0007: stfld ConstructColossusController ConstructColossusPickUpHandler::_controller  /*0x040006B5*/
    IL_000c: ret

  .method ConstructColossusPickUpHandler::PickupStartedHandler(ConstructColossusController.TargetItem)  // token 0x06000525 rva 0x16a0c attrs Public, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld ConstructColossusController.TargetItem ConstructColossusPickUpHandler::_currentTarget  /*0x040006B7*/
    IL_0007: ldarg.0
    IL_0008: ldarg.0
    IL_0009: ldfld float ConstructColossusPickUpHandler::_partPickupDuration  /*0x040006B2*/
    IL_000e: stfld float ConstructColossusPickUpHandler::_partPickupTimer  /*0x040006B6*/
    IL_0013: ret

  .method ConstructColossusPickUpHandler::PickupFinishedHandler(ConstructColossusController.TargetItem)  // token 0x06000526 rva 0x16a24 attrs Public, HideBySig
    // code size 61 (0x3d), max stack 2, init locals
    .locals ([0] Transform)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_003c
    IL_0003: ldarg.1
    IL_0004: ldfld TaggedObject ConstructColossusController.TargetItem::Target  /*0x040006AF*/
    IL_0009: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000e: stloc.0
    IL_000f: ldarg.0
    IL_0010: ldfld ParticleSystem ConstructColossusPickUpHandler::_finishPickUpVFX  /*0x040006B3*/
    IL_0015: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001a: ldloc.0
    IL_001b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0020: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0025: ldarg.0
    IL_0026: ldfld ParticleSystem ConstructColossusPickUpHandler::_finishPickUpVFX  /*0x040006B3*/
    IL_002b: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_0030: ldloc.0
    IL_0031: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0036: ldc.i4.0
    IL_0037: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003c: ret

  .method ConstructColossusPickUpHandler::SetNewTargetHandler(ConstructColossusController.TargetItem)  // token 0x06000527 rva 0x16a70 attrs Public, HideBySig
    // code size 39 (0x27), max stack 2, init locals
    .locals ([0] MeshRenderer[], [1] int)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0026
    IL_0003: ldarg.1
    IL_0004: ldfld MeshRenderer[] ConstructColossusController.TargetItem::TargetRenderers  /*0x040006B0*/
    IL_0009: stloc.0
    IL_000a: ldc.i4.0
    IL_000b: stloc.1
    IL_000c: br.s IL_0020
    IL_000e: ldloc.0
    IL_000f: ldloc.1
    IL_0010: ldelem.ref
    IL_0011: ldarg.0
    IL_0012: ldfld Material ConstructColossusPickUpHandler::_targetMaterial  /*0x040006B4*/
    IL_0017: callvirt void UnityEngine.Renderer::set_sharedMaterial(UnityEngine.Material)  /*0x0A000229*/
    IL_001c: ldloc.1
    IL_001d: ldc.i4.1
    IL_001e: add
    IL_001f: stloc.1
    IL_0020: ldloc.1
    IL_0021: ldloc.0
    IL_0022: ldlen
    IL_0023: conv.i4
    IL_0024: blt.s IL_000e
    IL_0026: ret

  .method ConstructColossusPickUpHandler::Update()  // token 0x06000528 rva 0x16aa4 attrs Private, HideBySig
    // code size 83 (0x53), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld float ConstructColossusPickUpHandler::_partPickupTimer  /*0x040006B6*/
    IL_0006: ldc.r4 0f
    IL_000b: ble.un.s IL_001f
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float ConstructColossusPickUpHandler::_partPickupTimer  /*0x040006B6*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: sub
    IL_001a: stfld float ConstructColossusPickUpHandler::_partPickupTimer  /*0x040006B6*/
    IL_001f: ldarg.0
    IL_0020: ldfld float ConstructColossusPickUpHandler::_partPickupTimer  /*0x040006B6*/
    IL_0025: ldc.r4 0f
    IL_002a: bgt.un.s IL_0052
    IL_002c: ldarg.0
    IL_002d: ldfld ConstructColossusController.TargetItem ConstructColossusPickUpHandler::_currentTarget  /*0x040006B7*/
    IL_0032: brfalse.s IL_0052
    IL_0034: ldarg.0
    IL_0035: ldfld ConstructColossusController ConstructColossusPickUpHandler::_controller  /*0x040006B5*/
    IL_003a: dup
    IL_003b: brtrue.s IL_0040
    IL_003d: pop
    IL_003e: br.s IL_004b
    IL_0040: ldarg.0
    IL_0041: ldfld ConstructColossusController.TargetItem ConstructColossusPickUpHandler::_currentTarget  /*0x040006B7*/
    IL_0046: call void ConstructColossusController::GoToNextTarget(ConstructColossusController.TargetItem)  /*0x0600051D*/
    IL_004b: ldarg.0
    IL_004c: ldnull
    IL_004d: stfld ConstructColossusController.TargetItem ConstructColossusPickUpHandler::_currentTarget  /*0x040006B7*/
    IL_0052: ret

  .method ConstructColossusPickUpHandler::.ctor()  // token 0x06000529 rva 0x16b03 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 3f
    IL_0006: stfld float ConstructColossusPickUpHandler::_partPickupDuration  /*0x040006B2*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 -1f
    IL_0011: stfld float ConstructColossusPickUpHandler::_partPickupTimer  /*0x040006B6*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

