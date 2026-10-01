// ===== KB.FogRTS.Examples.MapMarker  (token 0x02000006) =====
  .method KB.FogRTS.Examples.MapMarker::get_Sprite()  // token 0x06000009 rva 0x2372 attrs Assembly, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Sprite KB.FogRTS.Examples.MapMarker::sprite  /*0x0400000B*/
    IL_0006: ret

  .method KB.FogRTS.Examples.MapMarker::get_Size()  // token 0x0600000A rva 0x237a attrs Assembly, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float KB.FogRTS.Examples.MapMarker::size  /*0x0400000C*/
    IL_0006: ret

  .method KB.FogRTS.Examples.MapMarker::get_WorldPosition()  // token 0x0600000B rva 0x2382 attrs Assembly, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform KB.FogRTS.Examples.MapMarker::tr  /*0x0400000D*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A00000F*/
    IL_000b: ret

  .method KB.FogRTS.Examples.MapMarker::Awake()  // token 0x0600000C rva 0x238f attrs Private, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call Transform UnityEngine.Component::get_transform()  /*0x0A00000E*/
    IL_0007: stfld Transform KB.FogRTS.Examples.MapMarker::tr  /*0x0400000D*/
    IL_000c: ret

  .method KB.FogRTS.Examples.MapMarker::OnEnable()  // token 0x0600000D rva 0x239d attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void KB.FogRTS.Examples.MapMarkersManager::RegisterMarker(KB.FogRTS.Examples.MapMarker)  /*0x06000010*/
    IL_0006: ret

  .method KB.FogRTS.Examples.MapMarker::OnDisable()  // token 0x0600000E rva 0x23a5 attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void KB.FogRTS.Examples.MapMarkersManager::UnregisterMarker(KB.FogRTS.Examples.MapMarker)  /*0x06000011*/
    IL_0006: ret

  .method KB.FogRTS.Examples.MapMarker::.ctor()  // token 0x0600000F rva 0x23ad attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float KB.FogRTS.Examples.MapMarker::size  /*0x0400000C*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000018*/
    IL_0011: ret

