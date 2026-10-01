// ===== LaunchableDefenseMechanismInteractor  (token 0x02000235) =====
  .method LaunchableDefenseMechanismInteractor::Start()  // token 0x06000BEF rva 0x38005 attrs Private, HideBySig
    // code size 42 (0x2a), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: call void LaunchableDefenseMechanismInteractor::Reload()  /*0x06000BF6*/
    IL_0011: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0016: callvirt DayNightCycle.Timestate DayNightCycle::get_CurrentTimestate()  /*0x060003A2*/
    IL_001b: brtrue.s IL_0029
    IL_001d: ldarg.0
    IL_001e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0023: ldc.i4.0
    IL_0024: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0029: ret

  .method LaunchableDefenseMechanismInteractor::Focus(PlayerInteraction)  // token 0x06000BF0 rva 0x38030 attrs Public, Virtual, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LaunchableProjectile LaunchableDefenseMechanismInteractor::currentProjectile  /*0x04000EBD*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject LaunchableDefenseMechanismInteractor::focusIndicator  /*0x04000EB9*/
    IL_0014: ldc.i4.1
    IL_0015: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001a: ret

  .method LaunchableDefenseMechanismInteractor::InteractionBegin(PlayerInteraction)  // token 0x06000BF1 rva 0x3804c attrs Public, Virtual, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LaunchableProjectile LaunchableDefenseMechanismInteractor::currentProjectile  /*0x04000EBD*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brfalse.s IL_0037
    IL_000d: ldarg.0
    IL_000e: ldfld LaunchableProjectile LaunchableDefenseMechanismInteractor::currentProjectile  /*0x04000EBD*/
    IL_0013: callvirt void LaunchableProjectile::Launch()  /*0x06000891*/
    IL_0018: ldarg.0
    IL_0019: ldfld LaunchableProjectile LaunchableDefenseMechanismInteractor::currentProjectile  /*0x04000EBD*/
    IL_001e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0023: ldnull
    IL_0024: callvirt void UnityEngine.Transform::set_parent(UnityEngine.Transform)  /*0x0A0000E2*/
    IL_0029: ldarg.0
    IL_002a: ldnull
    IL_002b: stfld LaunchableProjectile LaunchableDefenseMechanismInteractor::currentProjectile  /*0x04000EBD*/
    IL_0030: ldarg.0
    IL_0031: ldarg.1
    IL_0032: callvirt void InteractorBase::Unfocus(PlayerInteraction)  /*0x06000BED*/
    IL_0037: ret

  .method LaunchableDefenseMechanismInteractor::OnDawn_AfterSunrise()  // token 0x06000BF2 rva 0x38085 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ldarg.0
    IL_000d: ldfld bool LaunchableDefenseMechanismInteractor::autoReloadOnDawn  /*0x04000EBC*/
    IL_0012: brfalse.s IL_001a
    IL_0014: ldarg.0
    IL_0015: call void LaunchableDefenseMechanismInteractor::Reload()  /*0x06000BF6*/
    IL_001a: ret

  .method LaunchableDefenseMechanismInteractor::OnDawn_BeforeSunrise()  // token 0x06000BF3 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LaunchableDefenseMechanismInteractor::OnDusk()  // token 0x06000BF4 rva 0x32e5c attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method LaunchableDefenseMechanismInteractor::Unfocus(PlayerInteraction)  // token 0x06000BF5 rva 0x380a1 attrs Public, Virtual, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject LaunchableDefenseMechanismInteractor::focusIndicator  /*0x04000EB9*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method LaunchableDefenseMechanismInteractor::Reload()  // token 0x06000BF6 rva 0x380b0 attrs Public, HideBySig
    // code size 74 (0x4a), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld LaunchableProjectile LaunchableDefenseMechanismInteractor::currentProjectile  /*0x04000EBD*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_0049
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld LaunchableProjectile LaunchableDefenseMechanismInteractor::projectilePrefab  /*0x04000EBA*/
    IL_0014: ldarg.0
    IL_0015: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_001a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0024: ldarg.0
    IL_0025: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_002a: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002f: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0034: ldarg.0
    IL_0035: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003a: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_003f: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<LaunchableProjectile>  /*0x2B0000AD*/
    IL_0044: stfld LaunchableProjectile LaunchableDefenseMechanismInteractor::currentProjectile  /*0x04000EBD*/
    IL_0049: ret

  .method LaunchableDefenseMechanismInteractor::OnDrawGizmos()  // token 0x06000BF7 rva 0x38108 attrs Private, HideBySig
    // code size 181 (0xb5), max stack 5, init locals
    IL_0000: call Color UnityEngine.Color::get_black()  /*0x0A0004BF*/
    IL_0005: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_000a: ldarg.0
    IL_000b: ldfld LaunchableProjectile LaunchableDefenseMechanismInteractor::projectilePrefab  /*0x04000EBA*/
    IL_0010: callvirt !!0 UnityEngine.Component::GetComponentInChildren()<UnityEngine.MeshFilter>  /*0x2B0000AE*/
    IL_0015: callvirt Mesh UnityEngine.MeshFilter::get_sharedMesh()  /*0x0A00040E*/
    IL_001a: ldc.i4.0
    IL_001b: ldarg.0
    IL_001c: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_0021: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0026: ldarg.0
    IL_0027: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_002c: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0031: ldarg.0
    IL_0032: ldfld LaunchableProjectile LaunchableDefenseMechanismInteractor::projectilePrefab  /*0x04000EBA*/
    IL_0037: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_003c: callvirt Vector3 UnityEngine.Transform::get_localScale()  /*0x0A00007A*/
    IL_0041: call void UnityEngine.Gizmos::DrawWireMesh(UnityEngine.Mesh,int,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Vector3)  /*0x0A000503*/
    IL_0046: call Color UnityEngine.Color::get_magenta()  /*0x0A0003C3*/
    IL_004b: call void UnityEngine.Gizmos::set_color(UnityEngine.Color)  /*0x0A0003AB*/
    IL_0050: ldarg.0
    IL_0051: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_0056: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_005b: ldarg.0
    IL_005c: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_0061: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0066: ldarg.0
    IL_0067: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_006c: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_0071: ldc.r4 15f
    IL_0076: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_007b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0080: call void UnityEngine.Gizmos::DrawLine(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000504*/
    IL_0085: ldarg.0
    IL_0086: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_008b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0090: ldarg.0
    IL_0091: ldfld Transform LaunchableDefenseMechanismInteractor::projectileSpawn  /*0x04000EBB*/
    IL_0096: callvirt Vector3 UnityEngine.Transform::get_forward()  /*0x0A0000AC*/
    IL_009b: ldc.r4 15f
    IL_00a0: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_00a5: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_00aa: ldc.r4 0.3f
    IL_00af: call void UnityEngine.Gizmos::DrawWireSphere(UnityEngine.Vector3,float)  /*0x0A0003AC*/
    IL_00b4: ret

  .method LaunchableDefenseMechanismInteractor::OnDuskEarly()  // token 0x06000BF8 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LaunchableDefenseMechanismInteractor::.ctor()  // token 0x06000BF9 rva 0x381c9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool LaunchableDefenseMechanismInteractor::autoReloadOnDawn  /*0x04000EBC*/
    IL_0007: ldarg.0
    IL_0008: call void InteractorBase::.ctor()  /*0x06000BEE*/
    IL_000d: ret

