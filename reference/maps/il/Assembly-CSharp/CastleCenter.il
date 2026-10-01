// ===== CastleCenter  (token 0x02000099) =====
  .method CastleCenter::Awake()  // token 0x06000339 rva 0xe5fc attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: stsfld CastleCenter CastleCenter::instance  /*0x040003F7*/
    IL_0006: ret

  .method CastleCenter::Start()  // token 0x0600033A rva 0xe604 attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: stsfld Vector3 CastleCenter::CastleCenterPosition  /*0x040003F6*/
    IL_0010: ldarg.0
    IL_0011: call !!0 UnityEngine.Component::GetComponentInParent()<BuildSlot>  /*0x2B000004*/
    IL_0016: stsfld BuildSlot CastleCenter::castleBuilding  /*0x040003F8*/
    IL_001b: ret

  .method CastleCenter::get_IsCastleBuilt()  // token 0x0600033B rva 0xe621 attrs Public, HideBySig, SpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldsfld BuildSlot CastleCenter::castleBuilding  /*0x040003F8*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brtrue.s IL_000f
    IL_000d: ldc.i4.0
    IL_000e: ret
    IL_000f: ldsfld BuildSlot CastleCenter::castleBuilding  /*0x040003F8*/
    IL_0014: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0019: ldc.i4.0
    IL_001a: cgt
    IL_001c: ret

  .method CastleCenter::.ctor()  // token 0x0600033C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

