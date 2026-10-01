// ===== EnemyScreenMarkerUIHelper  (token 0x02000303) =====
  .method EnemyScreenMarkerUIHelper::SetElite(bool)  // token 0x060010AC rva 0x4c9e0 attrs Public, HideBySig
    // code size 92 (0x5c), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MPImageBasic EnemyScreenMarkerUIHelper::defaultRegularBackground  /*0x040013C7*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: ldfld MPImageBasic EnemyScreenMarkerUIHelper::defaultRegularBackground  /*0x040013C7*/
    IL_0015: ldarg.1
    IL_0016: ldc.i4.0
    IL_0017: ceq
    IL_0019: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_001e: ldarg.0
    IL_001f: ldfld MPImageBasic EnemyScreenMarkerUIHelper::defaultEliteBackground  /*0x040013C8*/
    IL_0024: ldnull
    IL_0025: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_002a: brfalse.s IL_002d
    IL_002c: ret
    IL_002d: ldarg.0
    IL_002e: ldfld MPImageBasic EnemyScreenMarkerUIHelper::defaultEliteBackground  /*0x040013C8*/
    IL_0033: ldarg.1
    IL_0034: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0039: ldarg.0
    IL_003a: ldfld MPImageBasic EnemyScreenMarkerUIHelper::enemyIcon  /*0x040013C9*/
    IL_003f: ldnull
    IL_0040: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0045: brfalse.s IL_0048
    IL_0047: ret
    IL_0048: ldarg.1
    IL_0049: brfalse.s IL_005b
    IL_004b: ldarg.0
    IL_004c: ldfld MPImageBasic EnemyScreenMarkerUIHelper::enemyIcon  /*0x040013C9*/
    IL_0051: call Color UnityEngine.Color::get_yellow()  /*0x0A000181*/
    IL_0056: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_005b: ret

  .method EnemyScreenMarkerUIHelper::.ctor()  // token 0x060010AD rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

