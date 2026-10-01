// ===== Coinslot  (token 0x020002E3) =====
  .method Coinslot::get_isFull()  // token 0x06000FE4 rva 0x48be5 attrs Public, HideBySig, SpecialName
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Coinslot::fill01  /*0x040012C3*/
    IL_0006: ldc.r4 1f
    IL_000b: clt.un
    IL_000d: ldc.i4.0
    IL_000e: ceq
    IL_0010: ret

  .method Coinslot::get_CurrentFill01()  // token 0x06000FE5 rva 0x48bf7 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float Coinslot::fill01  /*0x040012C3*/
    IL_0006: ret

  .method Coinslot::AddFill(float,bool)  // token 0x06000FE6 rva 0x48c00 attrs Public, HideBySig
    // code size 96 (0x60), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float Coinslot::fill01  /*0x040012C3*/
    IL_0007: ldarg.1
    IL_0008: add
    IL_0009: stfld float Coinslot::fill01  /*0x040012C3*/
    IL_000e: ldarg.0
    IL_000f: ldfld Transform Coinslot::fillTarget  /*0x040012BC*/
    IL_0014: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0019: ldarg.0
    IL_001a: ldfld AnimationCurve Coinslot::fillCurve  /*0x040012BD*/
    IL_001f: ldarg.0
    IL_0020: ldfld float Coinslot::fill01  /*0x040012C3*/
    IL_0025: call float UnityEngine.Mathf::Clamp01(float)  /*0x0A000185*/
    IL_002a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_002f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0034: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0039: ldarg.0
    IL_003a: call bool Coinslot::get_isFull()  /*0x06000FE4*/
    IL_003f: brfalse.s IL_005e
    IL_0041: ldarg.2
    IL_0042: brtrue.s IL_0051
    IL_0044: ldarg.0
    IL_0045: ldfld MMF_Player Coinslot::fullFeedback  /*0x040012BE*/
    IL_004a: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_004f: br.s IL_005c
    IL_0051: ldarg.0
    IL_0052: ldfld MMF_Player Coinslot::fullCompleteFeedback  /*0x040012C2*/
    IL_0057: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_005c: ldc.i4.1
    IL_005d: ret
    IL_005e: ldc.i4.0
    IL_005f: ret

  .method Coinslot::SetEmpty()  // token 0x06000FE7 rva 0x48c6c attrs Public, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: stfld float Coinslot::fill01  /*0x040012C3*/
    IL_000b: ldarg.0
    IL_000c: ldfld Transform Coinslot::fillTarget  /*0x040012BC*/
    IL_0011: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0016: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_001b: ret

  .method Coinslot::PlayDeny()  // token 0x06000FE8 rva 0x48c89 attrs Public, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MMF_Player Coinslot::deniedFeedback  /*0x040012BF*/
    IL_0006: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_000b: ret

  .method Coinslot::Appear()  // token 0x06000FE9 rva 0x48c98 attrs Public, HideBySig
    // code size 99 (0x63), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MMF_Player Coinslot::fullFeedback  /*0x040012BE*/
    IL_0006: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_000b: ldarg.0
    IL_000c: ldfld MMF_Player Coinslot::deniedFeedback  /*0x040012BF*/
    IL_0011: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_0016: ldarg.0
    IL_0017: ldfld MMF_Player Coinslot::appearFeedback  /*0x040012C0*/
    IL_001c: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_0021: ldarg.0
    IL_0022: ldfld MMF_Player Coinslot::disappearFeedback  /*0x040012C1*/
    IL_0027: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_002c: ldarg.0
    IL_002d: ldc.r4 0f
    IL_0032: stfld float Coinslot::fill01  /*0x040012C3*/
    IL_0037: ldarg.0
    IL_0038: ldfld Transform Coinslot::fillTarget  /*0x040012BC*/
    IL_003d: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0042: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0047: ldarg.0
    IL_0048: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004d: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0052: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0057: ldarg.0
    IL_0058: ldfld MMF_Player Coinslot::appearFeedback  /*0x040012C0*/
    IL_005d: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0062: ret

  .method Coinslot::Disappear()  // token 0x06000FEA rva 0x48d07 attrs Public, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld MMF_Player Coinslot::fullFeedback  /*0x040012BE*/
    IL_0006: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_000b: ldarg.0
    IL_000c: ldfld MMF_Player Coinslot::deniedFeedback  /*0x040012BF*/
    IL_0011: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_0016: ldarg.0
    IL_0017: ldfld MMF_Player Coinslot::appearFeedback  /*0x040012C0*/
    IL_001c: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_0021: ldarg.0
    IL_0022: ldfld MMF_Player Coinslot::disappearFeedback  /*0x040012C1*/
    IL_0027: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_002c: ldarg.0
    IL_002d: ldfld MMF_Player Coinslot::disappearFeedback  /*0x040012C1*/
    IL_0032: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_0037: ret

  .method Coinslot::.ctor()  // token 0x06000FEB rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

