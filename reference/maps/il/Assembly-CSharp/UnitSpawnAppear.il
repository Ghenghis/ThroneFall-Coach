// ===== UnitSpawnAppear  (token 0x0200004A) =====
  .method UnitSpawnAppear::Awake()  // token 0x06000165 rva 0x766e attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform UnitSpawnAppear::target  /*0x040001BE*/
    IL_0006: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_000b: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0010: ret

  .method UnitSpawnAppear::Update()  // token 0x06000166 rva 0x7680 attrs Private, HideBySig
    // code size 143 (0x8f), max stack 6, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float UnitSpawnAppear::delay  /*0x040001C0*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float UnitSpawnAppear::delay  /*0x040001C0*/
    IL_0012: ldarg.0
    IL_0013: ldfld float UnitSpawnAppear::delay  /*0x040001C0*/
    IL_0018: ldarg.0
    IL_0019: ldfld float UnitSpawnAppear::initialDelay  /*0x040001BD*/
    IL_001e: bge.un.s IL_0021
    IL_0020: ret
    IL_0021: ldarg.0
    IL_0022: ldarg.0
    IL_0023: ldfld float UnitSpawnAppear::timer  /*0x040001BF*/
    IL_0028: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_002d: add
    IL_002e: stfld float UnitSpawnAppear::timer  /*0x040001BF*/
    IL_0033: ldarg.0
    IL_0034: ldfld Transform UnitSpawnAppear::target  /*0x040001BE*/
    IL_0039: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_003e: ldarg.0
    IL_003f: ldfld AnimationCurve UnitSpawnAppear::scaleCurve  /*0x040001BB*/
    IL_0044: ldc.r4 0f
    IL_0049: ldarg.0
    IL_004a: ldfld float UnitSpawnAppear::animationTime  /*0x040001BC*/
    IL_004f: ldarg.0
    IL_0050: ldfld float UnitSpawnAppear::timer  /*0x040001BF*/
    IL_0055: call float UnityEngine.Mathf::InverseLerp(float,float,float)  /*0x0A000084*/
    IL_005a: callvirt float UnityEngine.AnimationCurve::Evaluate(float)  /*0x0A00007B*/
    IL_005f: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0064: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0069: ldarg.0
    IL_006a: ldfld float UnitSpawnAppear::timer  /*0x040001BF*/
    IL_006f: ldarg.0
    IL_0070: ldfld float UnitSpawnAppear::animationTime  /*0x040001BC*/
    IL_0075: ble.un.s IL_008e
    IL_0077: ldarg.0
    IL_0078: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_007d: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0082: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0087: ldarg.0
    IL_0088: ldc.i4.0
    IL_0089: call void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_008e: ret

  .method UnitSpawnAppear::.ctor()  // token 0x06000167 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

