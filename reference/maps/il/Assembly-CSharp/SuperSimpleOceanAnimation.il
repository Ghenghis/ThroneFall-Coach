// ===== SuperSimpleOceanAnimation  (token 0x02000044) =====
  .method SuperSimpleOceanAnimation::Start()  // token 0x06000149 rva 0x72c1 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0007: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000c: stfld Vector3 SuperSimpleOceanAnimation::startPosition  /*0x040001A5*/
    IL_0011: ret

  .method SuperSimpleOceanAnimation::Update()  // token 0x0600014A rva 0x72d4 attrs Private, HideBySig
    // code size 150 (0x96), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float SuperSimpleOceanAnimation::time  /*0x040001A6*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: add
    IL_000d: stfld float SuperSimpleOceanAnimation::time  /*0x040001A6*/
    IL_0012: ldarg.0
    IL_0013: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0018: ldarg.0
    IL_0019: ldfld Vector3 SuperSimpleOceanAnimation::startPosition  /*0x040001A5*/
    IL_001e: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0023: ldarg.0
    IL_0024: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0029: dup
    IL_002a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002f: ldarg.0
    IL_0030: ldfld Vector3 SuperSimpleOceanAnimation::waveHeight  /*0x040001A7*/
    IL_0035: ldarg.0
    IL_0036: ldfld float SuperSimpleOceanAnimation::time  /*0x040001A6*/
    IL_003b: ldarg.0
    IL_003c: ldfld float SuperSimpleOceanAnimation::waveFrequency  /*0x040001A8*/
    IL_0041: mul
    IL_0042: ldc.r4 3.1415927f
    IL_0047: mul
    IL_0048: call float UnityEngine.Mathf::Sin(float)  /*0x0A0000AB*/
    IL_004d: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0052: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0057: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_005c: ldarg.0
    IL_005d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0062: dup
    IL_0063: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0068: ldarg.0
    IL_0069: ldfld Vector3 SuperSimpleOceanAnimation::waveSideways  /*0x040001A9*/
    IL_006e: ldarg.0
    IL_006f: ldfld float SuperSimpleOceanAnimation::time  /*0x040001A6*/
    IL_0074: ldarg.0
    IL_0075: ldfld float SuperSimpleOceanAnimation::waveSidewaysFrequency  /*0x040001AA*/
    IL_007a: mul
    IL_007b: ldc.r4 3.1415927f
    IL_0080: mul
    IL_0081: call float UnityEngine.Mathf::Sin(float)  /*0x0A0000AB*/
    IL_0086: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_008b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0090: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0095: ret

  .method SuperSimpleOceanAnimation::.ctor()  // token 0x0600014B rva 0x7376 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float SuperSimpleOceanAnimation::waveFrequency  /*0x040001A8*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.5f
    IL_0011: stfld float SuperSimpleOceanAnimation::waveSidewaysFrequency  /*0x040001AA*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

