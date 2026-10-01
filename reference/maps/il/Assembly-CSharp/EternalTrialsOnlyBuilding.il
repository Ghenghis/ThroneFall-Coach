// ===== EternalTrialsOnlyBuilding  (token 0x02000161) =====
  .method EternalTrialsOnlyBuilding::get_IsGoingToBeDestroyed()  // token 0x06000737 rva 0x24680 attrs Public, Virtual, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: call LocalGamestate.GameMode LocalGamestate::get_SelectedGameMode()  /*0x060008FA*/
    IL_0005: ldc.i4.1
    IL_0006: ceq
    IL_0008: ldc.i4.0
    IL_0009: ceq
    IL_000b: ret

  .method EternalTrialsOnlyBuilding::Start()  // token 0x06000738 rva 0x2468d attrs Public, Virtual, HideBySig
    // code size 20 (0x14), max stack 8
    IL_0000: ldarg.0
    IL_0001: callvirt bool PerkDestroyGameObjectModifyer::get_IsGoingToBeDestroyed()  /*0x06000B68*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0013: ret

  .method EternalTrialsOnlyBuilding::.ctor()  // token 0x06000739 rva 0x246a2 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void PerkDestroyGameObjectModifyer::.ctor()  /*0x06000B6A*/
    IL_0006: ret

