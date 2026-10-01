// ===== LavaGolemAnimationController  (token 0x020000E0) =====
  .method LavaGolemAnimationController::get__currentAnimator()  // token 0x060004B5 rva 0x14b9f attrs Private, HideBySig, SpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<Animator> LavaGolemAnimationController::_lavaGolemAnimators  /*0x0400060B*/
    IL_0006: ldarg.0
    IL_0007: ldfld int LavaGolemAnimationController::_phaseIndex  /*0x0400060F*/
    IL_000c: callvirt !0 System.Collections.Generic.List<UnityEngine.Animator>::get_Item(int)  /*0x0A00020D*/
    IL_0011: ret

  .method LavaGolemAnimationController::Start()  // token 0x060004B6 rva 0x14bb4 attrs Private, HideBySig
    // code size 146 (0x92), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Material LavaGolemAnimationController::_lavaGolemMaterial  /*0x04000616*/
    IL_0006: ldstr "_ColorDim"
    IL_000b: ldarg.0
    IL_000c: ldfld Color[] LavaGolemAnimationController::_phaseShadeColors  /*0x04000617*/
    IL_0011: ldarg.0
    IL_0012: ldfld int LavaGolemAnimationController::_phaseIndex  /*0x0400060F*/
    IL_0017: ldelem UnityEngine.Color  /*0x01000037*/
    IL_001c: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0021: ldarg.0
    IL_0022: ldfld LavaGolemPhasing LavaGolemAnimationController::lavaGolemPhasing  /*0x0400060A*/
    IL_0027: ldfld UnityEvent<int> LavaGolemPhasing::OnChangePhaseEvent  /*0x04000637*/
    IL_002c: ldarg.0
    IL_002d: ldftn void LavaGolemAnimationController::OnChangePhase(int)  /*0x060004BE*/
    IL_0033: newobj void UnityEngine.Events.UnityAction<int>::.ctor(object,IntPtr)  /*0x0A000204*/
    IL_0038: callvirt void UnityEngine.Events.UnityEvent<int>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A000205*/
    IL_003d: ldarg.0
    IL_003e: ldfld LavaGolemPhasing LavaGolemAnimationController::lavaGolemPhasing  /*0x0400060A*/
    IL_0043: ldfld UnityEvent<int> LavaGolemPhasing::ComboAttackTriggerEvent  /*0x04000634*/
    IL_0048: ldarg.0
    IL_0049: ldftn void LavaGolemAnimationController::OnComboAttackTrigger(int)  /*0x060004B8*/
    IL_004f: newobj void UnityEngine.Events.UnityAction<int>::.ctor(object,IntPtr)  /*0x0A000204*/
    IL_0054: callvirt void UnityEngine.Events.UnityEvent<int>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A000205*/
    IL_0059: ldarg.0
    IL_005a: ldfld LavaGolemPhasing LavaGolemAnimationController::lavaGolemPhasing  /*0x0400060A*/
    IL_005f: ldfld UnityEvent LavaGolemPhasing::PuddleAttackTriggerEvent  /*0x04000635*/
    IL_0064: ldarg.0
    IL_0065: ldftn void LavaGolemAnimationController::OnPuddleAttackTrigger()  /*0x060004B9*/
    IL_006b: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0070: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0075: ldarg.0
    IL_0076: ldfld LavaGolemPhasing LavaGolemAnimationController::lavaGolemPhasing  /*0x0400060A*/
    IL_007b: ldfld UnityEvent LavaGolemPhasing::LavaGolemJumpEvent  /*0x04000636*/
    IL_0080: ldarg.0
    IL_0081: ldftn void LavaGolemAnimationController::OnLavaGolemJump()  /*0x060004BA*/
    IL_0087: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_008c: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0091: ret

  .method LavaGolemAnimationController::Update()  // token 0x060004B7 rva 0x14c52 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void LavaGolemAnimationController::MovingAnimation()  /*0x060004BB*/
    IL_0006: ret

  .method LavaGolemAnimationController::OnComboAttackTrigger(int)  // token 0x060004B8 rva 0x14c5a attrs Private, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.1
    IL_0002: bne.un.s IL_002c
    IL_0004: ldarg.0
    IL_0005: call Animator LavaGolemAnimationController::get__currentAnimator()  /*0x060004B5*/
    IL_000a: ldstr "MeleeIdx"
    IL_000f: ldc.i4.1
    IL_0010: ldc.i4.3
    IL_0011: call int UnityEngine.Random::Range(int,int)  /*0x0A00008F*/
    IL_0016: callvirt void UnityEngine.Animator::SetInteger(string,int)  /*0x0A00020E*/
    IL_001b: ldarg.0
    IL_001c: call Animator LavaGolemAnimationController::get__currentAnimator()  /*0x060004B5*/
    IL_0021: ldstr "Melee"
    IL_0026: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_002b: ret
    IL_002c: ldarg.0
    IL_002d: call Animator LavaGolemAnimationController::get__currentAnimator()  /*0x060004B5*/
    IL_0032: ldstr "Vomit"
    IL_0037: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_003c: ret

  .method LavaGolemAnimationController::OnPuddleAttackTrigger()  // token 0x060004B9 rva 0x25f1 attrs Private, HideBySig
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LavaGolemAnimationController::OnLavaGolemJump()  // token 0x060004BA rva 0x14c98 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp LavaGolemAnimationController::_hp  /*0x0400060D*/
    IL_0006: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_000b: brtrue.s IL_001d
    IL_000d: ldarg.0
    IL_000e: call Animator LavaGolemAnimationController::get__currentAnimator()  /*0x060004B5*/
    IL_0013: ldstr "Enter"
    IL_0018: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_001d: ret

  .method LavaGolemAnimationController::MovingAnimation()  // token 0x060004BB rva 0x14cb8 attrs Private, HideBySig
    // code size 200 (0xc8), max stack 3, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld Hp LavaGolemAnimationController::_hp  /*0x0400060D*/
    IL_0006: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_000b: brfalse.s IL_0033
    IL_000d: ldarg.0
    IL_000e: ldfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_0013: brfalse.s IL_0032
    IL_0015: ldarg.0
    IL_0016: ldc.i4.0
    IL_0017: stfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_001c: ldarg.0
    IL_001d: call Animator LavaGolemAnimationController::get__currentAnimator()  /*0x060004B5*/
    IL_0022: ldstr "Walk"
    IL_0027: ldarg.0
    IL_0028: ldfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_002d: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_0032: ret
    IL_0033: ldarg.0
    IL_0034: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0039: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_003e: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0043: stloc.0
    IL_0044: ldloc.0
    IL_0045: ldarg.0
    IL_0046: ldfld Vector3 LavaGolemAnimationController::_lastPosition  /*0x04000619*/
    IL_004b: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0050: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_0055: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_005a: stloc.1
    IL_005b: ldloca.s 1
    IL_005d: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0062: stloc.2
    IL_0063: ldarg.0
    IL_0064: ldloc.0
    IL_0065: stfld Vector3 LavaGolemAnimationController::_lastPosition  /*0x04000619*/
    IL_006a: ldloc.2
    IL_006b: ldarg.0
    IL_006c: ldfld float LavaGolemAnimationController::_velocitySqrtDeadzone  /*0x04000618*/
    IL_0071: ble.un.s IL_0099
    IL_0073: ldarg.0
    IL_0074: ldfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_0079: brtrue.s IL_0099
    IL_007b: ldarg.0
    IL_007c: ldc.i4.1
    IL_007d: stfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_0082: ldarg.0
    IL_0083: call Animator LavaGolemAnimationController::get__currentAnimator()  /*0x060004B5*/
    IL_0088: ldstr "Walk"
    IL_008d: ldarg.0
    IL_008e: ldfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_0093: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_0098: ret
    IL_0099: ldloc.2
    IL_009a: ldarg.0
    IL_009b: ldfld float LavaGolemAnimationController::_velocitySqrtDeadzone  /*0x04000618*/
    IL_00a0: bgt.un.s IL_00c7
    IL_00a2: ldarg.0
    IL_00a3: ldfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_00a8: brfalse.s IL_00c7
    IL_00aa: ldarg.0
    IL_00ab: ldc.i4.0
    IL_00ac: stfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_00b1: ldarg.0
    IL_00b2: call Animator LavaGolemAnimationController::get__currentAnimator()  /*0x060004B5*/
    IL_00b7: ldstr "Walk"
    IL_00bc: ldarg.0
    IL_00bd: ldfld bool LavaGolemAnimationController::_isMoving  /*0x0400061A*/
    IL_00c2: callvirt void UnityEngine.Animator::SetBool(string,bool)  /*0x0A0001BA*/
    IL_00c7: ret

  .method LavaGolemAnimationController::OnEntering()  // token 0x060004BC rva 0x14d8c attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Animator LavaGolemAnimationController::get__currentAnimator()  /*0x060004B5*/
    IL_0006: ldstr "Enter"
    IL_000b: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0010: ret

  .method LavaGolemAnimationController::OnLeaving()  // token 0x060004BD rva 0x14d9e attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void LavaGolemAnimationController.<OnLeaving>d__26::.ctor(int)  /*0x060004C0*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld LavaGolemAnimationController LavaGolemAnimationController.<OnLeaving>d__26::<>4__this  /*0x0400061D*/
    IL_000d: ret

  .method LavaGolemAnimationController::OnChangePhase(int)  // token 0x060004BE rva 0x14dad attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int LavaGolemAnimationController::_phaseIndex  /*0x0400060F*/
    IL_0007: ldarg.0
    IL_0008: ldfld Material LavaGolemAnimationController::_lavaGolemMaterial  /*0x04000616*/
    IL_000d: ldstr "_ColorDim"
    IL_0012: ldarg.0
    IL_0013: ldfld Color[] LavaGolemAnimationController::_phaseShadeColors  /*0x04000617*/
    IL_0018: ldarg.0
    IL_0019: ldfld int LavaGolemAnimationController::_phaseIndex  /*0x0400060F*/
    IL_001e: ldelem UnityEngine.Color  /*0x01000037*/
    IL_0023: callvirt void UnityEngine.Material::SetColor(string,UnityEngine.Color)  /*0x0A000182*/
    IL_0028: ret

  .method LavaGolemAnimationController::.ctor()  // token 0x060004BF rva 0x14dd7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.15f
    IL_0006: stfld float LavaGolemAnimationController::_velocitySqrtDeadzone  /*0x04000618*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== LavaGolemAnimationController/<OnLeaving>d__26  (token 0x020000E1) =====
  .method LavaGolemAnimationController.<OnLeaving>d__26::.ctor(int)  // token 0x060004C0 rva 0x14dea attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int LavaGolemAnimationController.<OnLeaving>d__26::<>1__state  /*0x0400061B*/
    IL_000d: ret

  .method LavaGolemAnimationController.<OnLeaving>d__26::System.IDisposable.Dispose()  // token 0x060004C1 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method LavaGolemAnimationController.<OnLeaving>d__26::MoveNext()  // token 0x060004C2 rva 0x14dfc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 81 (0x51), max stack 2, init locals
    .locals ([0] int, [1] LavaGolemAnimationController)
    IL_0000: ldarg.0
    IL_0001: ldfld int LavaGolemAnimationController.<OnLeaving>d__26::<>1__state  /*0x0400061B*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld LavaGolemAnimationController LavaGolemAnimationController.<OnLeaving>d__26::<>4__this  /*0x0400061D*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_0017
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq.s IL_0038
    IL_0015: ldc.i4.0
    IL_0016: ret
    IL_0017: ldarg.0
    IL_0018: ldc.i4.m1
    IL_0019: stfld int LavaGolemAnimationController.<OnLeaving>d__26::<>1__state  /*0x0400061B*/
    IL_001e: ldarg.0
    IL_001f: ldloc.1
    IL_0020: ldfld float LavaGolemAnimationController::_delayLeaveAnimationDuration  /*0x0400060E*/
    IL_0025: newobj void UnityEngine.WaitForSeconds::.ctor(float)  /*0x0A00003A*/
    IL_002a: stfld object LavaGolemAnimationController.<OnLeaving>d__26::<>2__current  /*0x0400061C*/
    IL_002f: ldarg.0
    IL_0030: ldc.i4.1
    IL_0031: stfld int LavaGolemAnimationController.<OnLeaving>d__26::<>1__state  /*0x0400061B*/
    IL_0036: ldc.i4.1
    IL_0037: ret
    IL_0038: ldarg.0
    IL_0039: ldc.i4.m1
    IL_003a: stfld int LavaGolemAnimationController.<OnLeaving>d__26::<>1__state  /*0x0400061B*/
    IL_003f: ldloc.1
    IL_0040: ldfld Animator LavaGolemAnimationController::_knockOutAnimator  /*0x0400060C*/
    IL_0045: ldstr "Leave"
    IL_004a: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_004f: ldc.i4.0
    IL_0050: ret

  .method LavaGolemAnimationController.<OnLeaving>d__26::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060004C3 rva 0x14e59 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LavaGolemAnimationController.<OnLeaving>d__26::<>2__current  /*0x0400061C*/
    IL_0006: ret

  .method LavaGolemAnimationController.<OnLeaving>d__26::System.Collections.IEnumerator.Reset()  // token 0x060004C4 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method LavaGolemAnimationController.<OnLeaving>d__26::System.Collections.IEnumerator.get_Current()  // token 0x060004C5 rva 0x14e59 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object LavaGolemAnimationController.<OnLeaving>d__26::<>2__current  /*0x0400061C*/
    IL_0006: ret

