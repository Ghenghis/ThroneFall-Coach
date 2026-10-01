// ===== PhysicalCoinAnimator  (token 0x0200032F) =====
  .method PhysicalCoinAnimator::Awake()  // token 0x0600118D rva 0x54425 attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_000b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0010: ret

  .method PhysicalCoinAnimator::Update()  // token 0x0600118E rva 0x54438 attrs Private, HideBySig
    // code size 100 (0x64), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float PhysicalCoinAnimator::clock  /*0x0400151D*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float PhysicalCoinAnimator::clock  /*0x0400151D*/
    IL_0012: ldarg.0
    IL_0013: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_001d: ldarg.0
    IL_001e: ldfld AnimationCurve PhysicalCoinAnimator::animationCurve  /*0x0400151C*/
    IL_0023: ldarg.0
    IL_0024: ldfld float PhysicalCoinAnimator::clock  /*0x0400151D*/
    IL_0029: ldarg.0
    IL_002a: ldfld float PhysicalCoinAnimator::animationTime  /*0x0400151B*/
    IL_002f: div
    IL_0030: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_0035: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_003a: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_003f: ldarg.0
    IL_0040: ldfld float PhysicalCoinAnimator::clock  /*0x0400151D*/
    IL_0045: ldarg.0
    IL_0046: ldfld float PhysicalCoinAnimator::animationTime  /*0x0400151B*/
    IL_004b: blt.un.s IL_0063
    IL_004d: ldarg.0
    IL_004e: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0053: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0058: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_005d: ldarg.0
    IL_005e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0063: ret

  .method PhysicalCoinAnimator::.ctor()  // token 0x0600118F rva 0x544a8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float PhysicalCoinAnimator::animationTime  /*0x0400151B*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

