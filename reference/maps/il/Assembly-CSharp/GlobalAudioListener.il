// ===== GlobalAudioListener  (token 0x02000053) =====
  .method GlobalAudioListener::Awake()  // token 0x060001EE rva 0x806c attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldsfld GlobalAudioListener GlobalAudioListener::instance  /*0x04000243*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldarg.0
    IL_000e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0013: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: stsfld GlobalAudioListener GlobalAudioListener::instance  /*0x04000243*/
    IL_001f: ldarg.0
    IL_0020: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0025: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_002a: ret

  .method GlobalAudioListener::Update()  // token 0x060001EF rva 0x8098 attrs Private, HideBySig
    // code size 123 (0x7b), max stack 3, init locals
    .locals ([0] PlayerInteraction)
    IL_0000: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_0005: stloc.0
    IL_0006: ldarg.0
    IL_0007: ldfld PlayerInteraction GlobalAudioListener::bufferedPlayerInteraction  /*0x04000244*/
    IL_000c: ldloc.0
    IL_000d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0012: brfalse.s IL_0032
    IL_0014: ldloc.0
    IL_0015: ldnull
    IL_0016: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_001b: brfalse.s IL_0026
    IL_001d: ldarg.0
    IL_001e: ldnull
    IL_001f: stfld Transform GlobalAudioListener::bufferedTargetTransform  /*0x04000245*/
    IL_0024: br.s IL_0032
    IL_0026: ldarg.0
    IL_0027: ldloc.0
    IL_0028: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002d: stfld Transform GlobalAudioListener::bufferedTargetTransform  /*0x04000245*/
    IL_0032: ldarg.0
    IL_0033: ldfld Transform GlobalAudioListener::bufferedTargetTransform  /*0x04000245*/
    IL_0038: ldnull
    IL_0039: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_003e: brfalse.s IL_0063
    IL_0040: ldarg.0
    IL_0041: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0046: ldarg.0
    IL_0047: ldfld Transform GlobalAudioListener::bufferedTargetTransform  /*0x04000245*/
    IL_004c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0051: ldarg.0
    IL_0052: ldfld Vector3 GlobalAudioListener::offset  /*0x04000246*/
    IL_0057: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_005c: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0061: br.s IL_0073
    IL_0063: ldarg.0
    IL_0064: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0069: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_006e: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0073: ldarg.0
    IL_0074: ldloc.0
    IL_0075: stfld PlayerInteraction GlobalAudioListener::bufferedPlayerInteraction  /*0x04000244*/
    IL_007a: ret

  .method GlobalAudioListener::.ctor()  // token 0x060001F0 rva 0x811f attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0f
    IL_0006: ldc.r4 2f
    IL_000b: ldc.r4 0f
    IL_0010: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0015: stfld Vector3 GlobalAudioListener::offset  /*0x04000246*/
    IL_001a: ldarg.0
    IL_001b: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0020: ret

