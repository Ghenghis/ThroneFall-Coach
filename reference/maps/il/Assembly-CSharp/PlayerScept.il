// ===== PlayerScept  (token 0x0200002B) =====
  .method PlayerScept::Start()  // token 0x060000DE rva 0x5a39 attrs Private, HideBySig
    // code size 46 (0x2e), max stack 8
    IL_0000: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0005: ldarg.0
    IL_0006: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_000b: ldarg.0
    IL_000c: call ReInput.PlayerHelper Rewired.ReInput::get_players()  /*0x0A000002*/
    IL_0011: ldc.i4.0
    IL_0012: callvirt Player Rewired.ReInput.PlayerHelper::GetPlayer(int)  /*0x0A000003*/
    IL_0017: stfld Player PlayerScept::input  /*0x04000110*/
    IL_001c: ldarg.0
    IL_001d: ldarg.0
    IL_001e: ldfld Transform PlayerScept::scept  /*0x0400010A*/
    IL_0023: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0028: stfld Vector3 PlayerScept::initPos  /*0x04000111*/
    IL_002d: ret

  .method PlayerScept::Update()  // token 0x060000DF rva 0x5a68 attrs Private, HideBySig
    // code size 75 (0x4b), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Player PlayerScept::input  /*0x04000110*/
    IL_0006: ldstr "Interact"
    IL_000b: callvirt bool Rewired.Player::GetButtonDown(string)  /*0x0A00003B*/
    IL_0010: brfalse.s IL_0025
    IL_0012: ldarg.0
    IL_0013: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_0018: ldarg.0
    IL_0019: ldarg.0
    IL_001a: call IEnumerator PlayerScept::AnimationIn()  /*0x060000E0*/
    IL_001f: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0024: pop
    IL_0025: ldarg.0
    IL_0026: ldfld Player PlayerScept::input  /*0x04000110*/
    IL_002b: ldstr "Interact"
    IL_0030: callvirt bool Rewired.Player::GetButtonUp(string)  /*0x0A0000A3*/
    IL_0035: brfalse.s IL_004a
    IL_0037: ldarg.0
    IL_0038: call void UnityEngine.MonoBehaviour::StopAllCoroutines()  /*0x0A00003C*/
    IL_003d: ldarg.0
    IL_003e: ldarg.0
    IL_003f: call IEnumerator PlayerScept::AnimationOut()  /*0x060000E1*/
    IL_0044: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0049: pop
    IL_004a: ret

  .method PlayerScept::AnimationIn()  // token 0x060000E0 rva 0x5abf attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PlayerScept.<AnimationIn>d__11::.ctor(int)  /*0x060000E7*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld PlayerScept PlayerScept.<AnimationIn>d__11::<>4__this  /*0x04000114*/
    IL_000d: ret

  .method PlayerScept::AnimationOut()  // token 0x060000E1 rva 0x5ace attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void PlayerScept.<AnimationOut>d__12::.ctor(int)  /*0x060000ED*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld PlayerScept PlayerScept.<AnimationOut>d__12::<>4__this  /*0x04000119*/
    IL_000d: ret

  .method PlayerScept::OnDawn_AfterSunrise()  // token 0x060000E2 rva 0x5add attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject PlayerScept::loadoutParent  /*0x04000109*/
    IL_0006: ldc.i4.1
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method PlayerScept::OnDawn_BeforeSunrise()  // token 0x060000E3 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerScept::OnDusk()  // token 0x060000E4 rva 0x5aeb attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject PlayerScept::loadoutParent  /*0x04000109*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method PlayerScept::OnDuskEarly()  // token 0x060000E5 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerScept::.ctor()  // token 0x060000E6 rva 0x5af9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.2f
    IL_0006: stfld float PlayerScept::inTime  /*0x0400010E*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.4f
    IL_0011: stfld float PlayerScept::outTime  /*0x0400010F*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

// ===== PlayerScept/<AnimationIn>d__11  (token 0x0200002C) =====
  .method PlayerScept.<AnimationIn>d__11::.ctor(int)  // token 0x060000E7 rva 0x5b17 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlayerScept.<AnimationIn>d__11::<>1__state  /*0x04000112*/
    IL_000d: ret

  .method PlayerScept.<AnimationIn>d__11::System.IDisposable.Dispose()  // token 0x060000E8 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerScept.<AnimationIn>d__11::MoveNext()  // token 0x060000E9 rva 0x5b28 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 208 (0xd0), max stack 7, init locals
    .locals ([0] int, [1] PlayerScept)
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerScept.<AnimationIn>d__11::<>1__state  /*0x04000112*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PlayerScept PlayerScept.<AnimationIn>d__11::<>4__this  /*0x04000114*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_00a3
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int PlayerScept.<AnimationIn>d__11::<>1__state  /*0x04000112*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0f
    IL_0027: stfld float PlayerScept.<AnimationIn>d__11::<timer>5__2  /*0x04000115*/
    IL_002c: ldarg.0
    IL_002d: ldloc.1
    IL_002e: ldfld Transform PlayerScept::scept  /*0x0400010A*/
    IL_0033: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0038: stfld Vector3 PlayerScept.<AnimationIn>d__11::<startPos>5__3  /*0x04000116*/
    IL_003d: br.s IL_00aa
    IL_003f: ldarg.0
    IL_0040: ldarg.0
    IL_0041: ldfld float PlayerScept.<AnimationIn>d__11::<timer>5__2  /*0x04000115*/
    IL_0046: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_004b: add
    IL_004c: stfld float PlayerScept.<AnimationIn>d__11::<timer>5__2  /*0x04000115*/
    IL_0051: ldloc.1
    IL_0052: ldfld Transform PlayerScept::scept  /*0x0400010A*/
    IL_0057: ldarg.0
    IL_0058: ldfld Vector3 PlayerScept.<AnimationIn>d__11::<startPos>5__3  /*0x04000116*/
    IL_005d: ldloc.1
    IL_005e: ldfld Transform PlayerScept::scepterInteractionTarget  /*0x0400010B*/
    IL_0063: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0068: ldloc.1
    IL_0069: ldfld AnimationCurve PlayerScept::inCurve  /*0x0400010C*/
    IL_006e: ldc.r4 0f
    IL_0073: ldloc.1
    IL_0074: ldfld float PlayerScept::inTime  /*0x0400010E*/
    IL_0079: ldarg.0
    IL_007a: ldfld float PlayerScept.<AnimationIn>d__11::<timer>5__2  /*0x04000115*/
    IL_007f: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_0084: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0089: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_008e: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_0093: ldarg.0
    IL_0094: ldnull
    IL_0095: stfld object PlayerScept.<AnimationIn>d__11::<>2__current  /*0x04000113*/
    IL_009a: ldarg.0
    IL_009b: ldc.i4.1
    IL_009c: stfld int PlayerScept.<AnimationIn>d__11::<>1__state  /*0x04000112*/
    IL_00a1: ldc.i4.1
    IL_00a2: ret
    IL_00a3: ldarg.0
    IL_00a4: ldc.i4.m1
    IL_00a5: stfld int PlayerScept.<AnimationIn>d__11::<>1__state  /*0x04000112*/
    IL_00aa: ldarg.0
    IL_00ab: ldfld float PlayerScept.<AnimationIn>d__11::<timer>5__2  /*0x04000115*/
    IL_00b0: ldloc.1
    IL_00b1: ldfld float PlayerScept::inTime  /*0x0400010E*/
    IL_00b6: blt.s IL_003f
    IL_00b8: ldloc.1
    IL_00b9: ldfld Transform PlayerScept::scept  /*0x0400010A*/
    IL_00be: ldloc.1
    IL_00bf: ldfld Transform PlayerScept::scepterInteractionTarget  /*0x0400010B*/
    IL_00c4: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_00c9: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_00ce: ldc.i4.0
    IL_00cf: ret

  .method PlayerScept.<AnimationIn>d__11::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060000EA rva 0x5c04 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerScept.<AnimationIn>d__11::<>2__current  /*0x04000113*/
    IL_0006: ret

  .method PlayerScept.<AnimationIn>d__11::System.Collections.IEnumerator.Reset()  // token 0x060000EB rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PlayerScept.<AnimationIn>d__11::System.Collections.IEnumerator.get_Current()  // token 0x060000EC rva 0x5c04 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerScept.<AnimationIn>d__11::<>2__current  /*0x04000113*/
    IL_0006: ret

// ===== PlayerScept/<AnimationOut>d__12  (token 0x0200002D) =====
  .method PlayerScept.<AnimationOut>d__12::.ctor(int)  // token 0x060000ED rva 0x5c0c attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlayerScept.<AnimationOut>d__12::<>1__state  /*0x04000117*/
    IL_000d: ret

  .method PlayerScept.<AnimationOut>d__12::System.IDisposable.Dispose()  // token 0x060000EE rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method PlayerScept.<AnimationOut>d__12::MoveNext()  // token 0x060000EF rva 0x5c1c attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 198 (0xc6), max stack 7, init locals
    .locals ([0] int, [1] PlayerScept)
    IL_0000: ldarg.0
    IL_0001: ldfld int PlayerScept.<AnimationOut>d__12::<>1__state  /*0x04000117*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld PlayerScept PlayerScept.<AnimationOut>d__12::<>4__this  /*0x04000119*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: brfalse.s IL_001a
    IL_0011: ldloc.0
    IL_0012: ldc.i4.1
    IL_0013: beq IL_009e
    IL_0018: ldc.i4.0
    IL_0019: ret
    IL_001a: ldarg.0
    IL_001b: ldc.i4.m1
    IL_001c: stfld int PlayerScept.<AnimationOut>d__12::<>1__state  /*0x04000117*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 0f
    IL_0027: stfld float PlayerScept.<AnimationOut>d__12::<timer>5__2  /*0x0400011A*/
    IL_002c: ldloc.1
    IL_002d: ldfld Transform PlayerScept::scept  /*0x0400010A*/
    IL_0032: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_0037: pop
    IL_0038: br.s IL_00a5
    IL_003a: ldarg.0
    IL_003b: ldarg.0
    IL_003c: ldfld float PlayerScept.<AnimationOut>d__12::<timer>5__2  /*0x0400011A*/
    IL_0041: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0046: add
    IL_0047: stfld float PlayerScept.<AnimationOut>d__12::<timer>5__2  /*0x0400011A*/
    IL_004c: ldloc.1
    IL_004d: ldfld Transform PlayerScept::scept  /*0x0400010A*/
    IL_0052: ldloc.1
    IL_0053: ldfld Transform PlayerScept::scept  /*0x0400010A*/
    IL_0058: callvirt Vector3 UnityEngine.Transform::get_localPosition()  /*0x0A00008C*/
    IL_005d: ldloc.1
    IL_005e: ldfld Vector3 PlayerScept::initPos  /*0x04000111*/
    IL_0063: ldloc.1
    IL_0064: ldfld AnimationCurve PlayerScept::outCurve  /*0x0400010D*/
    IL_0069: ldc.r4 0f
    IL_006e: ldloc.1
    IL_006f: ldfld float PlayerScept::outTime  /*0x0400010F*/
    IL_0074: ldarg.0
    IL_0075: ldfld float PlayerScept.<AnimationOut>d__12::<timer>5__2  /*0x0400011A*/
    IL_007a: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_007f: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0084: call Vector3 UnityEngine.Vector3::Lerp(UnityEngine.Vector3,UnityEngine.Vector3,float)  /*0x0A000091*/
    IL_0089: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_008e: ldarg.0
    IL_008f: ldnull
    IL_0090: stfld object PlayerScept.<AnimationOut>d__12::<>2__current  /*0x04000118*/
    IL_0095: ldarg.0
    IL_0096: ldc.i4.1
    IL_0097: stfld int PlayerScept.<AnimationOut>d__12::<>1__state  /*0x04000117*/
    IL_009c: ldc.i4.1
    IL_009d: ret
    IL_009e: ldarg.0
    IL_009f: ldc.i4.m1
    IL_00a0: stfld int PlayerScept.<AnimationOut>d__12::<>1__state  /*0x04000117*/
    IL_00a5: ldarg.0
    IL_00a6: ldfld float PlayerScept.<AnimationOut>d__12::<timer>5__2  /*0x0400011A*/
    IL_00ab: ldloc.1
    IL_00ac: ldfld float PlayerScept::outTime  /*0x0400010F*/
    IL_00b1: blt.s IL_003a
    IL_00b3: ldloc.1
    IL_00b4: ldfld Transform PlayerScept::scept  /*0x0400010A*/
    IL_00b9: ldloc.1
    IL_00ba: ldfld Vector3 PlayerScept::initPos  /*0x04000111*/
    IL_00bf: callvirt void UnityEngine.Transform::set_localPosition(UnityEngine.Vector3)  /*0x0A000037*/
    IL_00c4: ldc.i4.0
    IL_00c5: ret

  .method PlayerScept.<AnimationOut>d__12::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x060000F0 rva 0x5cee attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerScept.<AnimationOut>d__12::<>2__current  /*0x04000118*/
    IL_0006: ret

  .method PlayerScept.<AnimationOut>d__12::System.Collections.IEnumerator.Reset()  // token 0x060000F1 rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method PlayerScept.<AnimationOut>d__12::System.Collections.IEnumerator.get_Current()  // token 0x060000F2 rva 0x5cee attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object PlayerScept.<AnimationOut>d__12::<>2__current  /*0x04000118*/
    IL_0006: ret

