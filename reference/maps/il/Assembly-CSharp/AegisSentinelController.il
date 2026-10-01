// ===== AegisSentinelController  (token 0x020000BB) =====
  .method AegisSentinelController::Update()  // token 0x060003F0 rva 0x112c4 attrs Private, HideBySig
    // code size 129 (0x81), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AegisSentinelController::shieldTimer  /*0x04000512*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float AegisSentinelController::shieldTimer  /*0x04000512*/
    IL_0012: ldarg.0
    IL_0013: ldfld float AegisSentinelController::shieldTimer  /*0x04000512*/
    IL_0018: ldc.r4 0f
    IL_001d: bge.un.s IL_0080
    IL_001f: ldarg.0
    IL_0020: ldfld bool AegisSentinelController::shieldIsActive  /*0x04000513*/
    IL_0025: brfalse.s IL_0051
    IL_0027: ldarg.0
    IL_0028: ldc.i4.0
    IL_0029: stfld bool AegisSentinelController::shieldIsActive  /*0x04000513*/
    IL_002e: ldarg.0
    IL_002f: ldarg.0
    IL_0030: ldfld float AegisSentinelController::shieldCooldown  /*0x04000511*/
    IL_0035: stfld float AegisSentinelController::shieldTimer  /*0x04000512*/
    IL_003a: ldarg.0
    IL_003b: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0040: call void ProjectileBlock::RemoveSphereArea(UnityEngine.Transform)  /*0x060005CD*/
    IL_0045: ldarg.0
    IL_0046: ldfld UnityEvent AegisSentinelController::OnShieldDeactivated  /*0x04000515*/
    IL_004b: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0050: ret
    IL_0051: ldarg.0
    IL_0052: ldc.i4.1
    IL_0053: stfld bool AegisSentinelController::shieldIsActive  /*0x04000513*/
    IL_0058: ldarg.0
    IL_0059: ldarg.0
    IL_005a: ldfld float AegisSentinelController::shieldDuration  /*0x04000510*/
    IL_005f: stfld float AegisSentinelController::shieldTimer  /*0x04000512*/
    IL_0064: ldarg.0
    IL_0065: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006a: ldarg.0
    IL_006b: ldfld float AegisSentinelController::shieldRadius  /*0x0400050F*/
    IL_0070: call void ProjectileBlock::AddSphereArea(UnityEngine.Transform,float)  /*0x060005CC*/
    IL_0075: ldarg.0
    IL_0076: ldfld UnityEvent AegisSentinelController::OnShieldActivated  /*0x04000514*/
    IL_007b: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0080: ret

  .method AegisSentinelController::OnDisable()  // token 0x060003F1 rva 0x11351 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: call void ProjectileBlock::RemoveSphereArea(UnityEngine.Transform)  /*0x060005CD*/
    IL_000b: ret

  .method AegisSentinelController::.ctor()  // token 0x060003F2 rva 0x1135e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 62 (0x3e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 6f
    IL_0006: stfld float AegisSentinelController::shieldRadius  /*0x0400050F*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 3f
    IL_0011: stfld float AegisSentinelController::shieldDuration  /*0x04000510*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 3f
    IL_001c: stfld float AegisSentinelController::shieldCooldown  /*0x04000511*/
    IL_0021: ldarg.0
    IL_0022: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0027: stfld UnityEvent AegisSentinelController::OnShieldActivated  /*0x04000514*/
    IL_002c: ldarg.0
    IL_002d: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0032: stfld UnityEvent AegisSentinelController::OnShieldDeactivated  /*0x04000515*/
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_003d: ret

