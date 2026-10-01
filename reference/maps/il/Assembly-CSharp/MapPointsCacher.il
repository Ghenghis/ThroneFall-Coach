// ===== MapPointsCacher  (token 0x020000E6) =====
  .method MapPointsCacher::get_LavaGolemToPhase1JumpPoint()  // token 0x060004E1 rva 0x156b9 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld Transform MapPointsCacher::<LavaGolemToPhase1JumpPoint>k__BackingField  /*0x04000657*/
    IL_0005: ret

  .method MapPointsCacher::set_LavaGolemToPhase1JumpPoint(UnityEngine.Transform)  // token 0x060004E2 rva 0x156c0 attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld Transform MapPointsCacher::<LavaGolemToPhase1JumpPoint>k__BackingField  /*0x04000657*/
    IL_0006: ret

  .method MapPointsCacher::get_LavaGolemToPhase2JumpPoint()  // token 0x060004E3 rva 0x156c8 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld Transform MapPointsCacher::<LavaGolemToPhase2JumpPoint>k__BackingField  /*0x04000658*/
    IL_0005: ret

  .method MapPointsCacher::set_LavaGolemToPhase2JumpPoint(UnityEngine.Transform)  // token 0x060004E4 rva 0x156cf attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld Transform MapPointsCacher::<LavaGolemToPhase2JumpPoint>k__BackingField  /*0x04000658*/
    IL_0006: ret

  .method MapPointsCacher::get_LavaGolemToPhase3JumpPoint()  // token 0x060004E5 rva 0x156d7 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld Transform MapPointsCacher::<LavaGolemToPhase3JumpPoint>k__BackingField  /*0x04000659*/
    IL_0005: ret

  .method MapPointsCacher::set_LavaGolemToPhase3JumpPoint(UnityEngine.Transform)  // token 0x060004E6 rva 0x156de attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld Transform MapPointsCacher::<LavaGolemToPhase3JumpPoint>k__BackingField  /*0x04000659*/
    IL_0006: ret

  .method MapPointsCacher::get_LavaGolemPhase1EndPoint()  // token 0x060004E7 rva 0x156e6 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld Transform MapPointsCacher::<LavaGolemPhase1EndPoint>k__BackingField  /*0x0400065A*/
    IL_0005: ret

  .method MapPointsCacher::set_LavaGolemPhase1EndPoint(UnityEngine.Transform)  // token 0x060004E8 rva 0x156ed attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld Transform MapPointsCacher::<LavaGolemPhase1EndPoint>k__BackingField  /*0x0400065A*/
    IL_0006: ret

  .method MapPointsCacher::get_LavaGolemPhase2EndPoint()  // token 0x060004E9 rva 0x156f5 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld Transform MapPointsCacher::<LavaGolemPhase2EndPoint>k__BackingField  /*0x0400065B*/
    IL_0005: ret

  .method MapPointsCacher::set_LavaGolemPhase2EndPoint(UnityEngine.Transform)  // token 0x060004EA rva 0x156fc attrs Private, Static, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld Transform MapPointsCacher::<LavaGolemPhase2EndPoint>k__BackingField  /*0x0400065B*/
    IL_0006: ret

  .method MapPointsCacher::Awake()  // token 0x060004EB rva 0x15704 attrs Private, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform MapPointsCacher::lavaGolemToPhase1JumpPoint  /*0x04000652*/
    IL_0006: call void MapPointsCacher::set_LavaGolemToPhase1JumpPoint(UnityEngine.Transform)  /*0x060004E2*/
    IL_000b: ldarg.0
    IL_000c: ldfld Transform MapPointsCacher::lavaGolemToPhase2JumpPoint  /*0x04000653*/
    IL_0011: call void MapPointsCacher::set_LavaGolemToPhase2JumpPoint(UnityEngine.Transform)  /*0x060004E4*/
    IL_0016: ldarg.0
    IL_0017: ldfld Transform MapPointsCacher::lavaGolemToPhase3JumpPoint  /*0x04000654*/
    IL_001c: call void MapPointsCacher::set_LavaGolemToPhase3JumpPoint(UnityEngine.Transform)  /*0x060004E6*/
    IL_0021: ldarg.0
    IL_0022: ldfld Transform MapPointsCacher::lavaGolemPhase1EndPoint  /*0x04000655*/
    IL_0027: call void MapPointsCacher::set_LavaGolemPhase1EndPoint(UnityEngine.Transform)  /*0x060004E8*/
    IL_002c: ldarg.0
    IL_002d: ldfld Transform MapPointsCacher::lavaGolemPhase2EndPoint  /*0x04000656*/
    IL_0032: call void MapPointsCacher::set_LavaGolemPhase2EndPoint(UnityEngine.Transform)  /*0x060004EA*/
    IL_0037: ret

  .method MapPointsCacher::.ctor()  // token 0x060004EC rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

