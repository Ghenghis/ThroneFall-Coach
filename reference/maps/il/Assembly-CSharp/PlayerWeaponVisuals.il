// ===== PlayerWeaponVisuals  (token 0x02000245) =====
  .method PlayerWeaponVisuals::Init(UnityEngine.GameObject,ManualAttack)  // token 0x06000C7E rva 0x39a63 attrs Public, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld GameObject PlayerWeaponVisuals::visuals  /*0x04000F2F*/
    IL_0007: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_000c: ldarg.0
    IL_000d: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_0012: ldarg.0
    IL_0013: ldfld GameObject PlayerWeaponVisuals::visuals  /*0x04000F2F*/
    IL_0018: callvirt !!0 UnityEngine.GameObject::GetComponent()<PlayerAttackAnimator>  /*0x2B0000B7*/
    IL_001d: ldarg.2
    IL_001e: callvirt void PlayerAttackAnimator::AssignAttack(ManualAttack)  /*0x060000D0*/
    IL_0023: ldsfld TutorialManager TutorialManager::instance  /*0x0400117F*/
    IL_0028: ldnull
    IL_0029: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002e: brfalse.s IL_003c
    IL_0030: ldarg.0
    IL_0031: ldfld GameObject PlayerWeaponVisuals::visuals  /*0x04000F2F*/
    IL_0036: ldc.i4.1
    IL_0037: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_003c: ret

  .method PlayerWeaponVisuals::OnDawn_AfterSunrise()  // token 0x06000C7F rva 0x39aa1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject PlayerWeaponVisuals::visuals  /*0x04000F2F*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method PlayerWeaponVisuals::OnDawn_BeforeSunrise()  // token 0x06000C80 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerWeaponVisuals::OnDusk()  // token 0x06000C81 rva 0x39aaf attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject PlayerWeaponVisuals::visuals  /*0x04000F2F*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method PlayerWeaponVisuals::OnDuskEarly()  // token 0x06000C82 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerWeaponVisuals::.ctor()  // token 0x06000C83 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

