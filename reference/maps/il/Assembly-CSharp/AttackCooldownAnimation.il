// ===== AttackCooldownAnimation  (token 0x020002D4) =====
  .method AttackCooldownAnimation::Start()  // token 0x06000FA4 rva 0x4729b attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject AttackCooldownAnimation::parent  /*0x04001269*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_000c: ret

  .method AttackCooldownAnimation::SetCurrentCooldownPercentage(float)  // token 0x06000FA5 rva 0x472ac attrs Public, HideBySig
    // code size 130 (0x82), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float AttackCooldownAnimation::currentCooldownPercentage  /*0x0400126D*/
    IL_0007: ldarg.0
    IL_0008: ldfld bool AttackCooldownAnimation::inCooldown  /*0x0400126E*/
    IL_000d: brfalse.s IL_0044
    IL_000f: ldarg.0
    IL_0010: ldfld float AttackCooldownAnimation::currentCooldownPercentage  /*0x0400126D*/
    IL_0015: ldc.r4 0f
    IL_001a: bgt.un.s IL_0044
    IL_001c: ldarg.0
    IL_001d: ldfld MMF_Player AttackCooldownAnimation::onShow  /*0x0400126B*/
    IL_0022: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_0027: ldarg.0
    IL_0028: ldfld MMF_Player AttackCooldownAnimation::onHide  /*0x0400126C*/
    IL_002d: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_0032: ldarg.0
    IL_0033: ldfld MMF_Player AttackCooldownAnimation::onHide  /*0x0400126C*/
    IL_0038: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_003d: ldarg.0
    IL_003e: ldc.i4.0
    IL_003f: stfld bool AttackCooldownAnimation::inCooldown  /*0x0400126E*/
    IL_0044: ldarg.0
    IL_0045: ldfld bool AttackCooldownAnimation::inCooldown  /*0x0400126E*/
    IL_004a: brtrue.s IL_0081
    IL_004c: ldarg.0
    IL_004d: ldfld float AttackCooldownAnimation::currentCooldownPercentage  /*0x0400126D*/
    IL_0052: ldc.r4 0f
    IL_0057: ble.un.s IL_0081
    IL_0059: ldarg.0
    IL_005a: ldfld MMF_Player AttackCooldownAnimation::onShow  /*0x0400126B*/
    IL_005f: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_0064: ldarg.0
    IL_0065: ldfld MMF_Player AttackCooldownAnimation::onHide  /*0x0400126C*/
    IL_006a: callvirt void MoreMountains.Feedbacks.MMFeedbacks::StopFeedbacks()  /*0x0A00060A*/
    IL_006f: ldarg.0
    IL_0070: ldfld MMF_Player AttackCooldownAnimation::onShow  /*0x0400126B*/
    IL_0075: callvirt void MoreMountains.Feedbacks.MMFeedbacks::PlayFeedbacks()  /*0x0A000113*/
    IL_007a: ldarg.0
    IL_007b: ldc.i4.1
    IL_007c: stfld bool AttackCooldownAnimation::inCooldown  /*0x0400126E*/
    IL_0081: ret

  .method AttackCooldownAnimation::Update()  // token 0x06000FA6 rva 0x4733a attrs Private, HideBySig
    // code size 37 (0x25), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float AttackCooldownAnimation::currentCooldownPercentage  /*0x0400126D*/
    IL_0006: ldc.r4 0f
    IL_000b: ble.un.s IL_0024
    IL_000d: ldarg.0
    IL_000e: ldfld MPImage AttackCooldownAnimation::cooldownIndicator  /*0x0400126A*/
    IL_0013: ldc.r4 1f
    IL_0018: ldarg.0
    IL_0019: ldfld float AttackCooldownAnimation::currentCooldownPercentage  /*0x0400126D*/
    IL_001e: sub
    IL_001f: callvirt void UnityEngine.UI.Image::set_fillAmount(float)  /*0x0A0003B2*/
    IL_0024: ret

  .method AttackCooldownAnimation::.ctor()  // token 0x06000FA7 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

