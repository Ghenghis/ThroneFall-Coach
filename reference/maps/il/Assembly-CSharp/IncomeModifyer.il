// ===== IncomeModifyer  (token 0x02000195) =====
  .method IncomeModifyer::Start()  // token 0x06000839 rva 0x286f2 attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildingInteractor IncomeModifyer::buildingInteractor  /*0x04000A57*/
    IL_0006: callvirt List<IncomeModifyer> BuildingInteractor::get_IncomeModifiers()  /*0x06000BA1*/
    IL_000b: ldarg.0
    IL_000c: callvirt void System.Collections.Generic.List<IncomeModifyer>::Add(!0)  /*0x0A000363*/
    IL_0011: ret

  .method IncomeModifyer::OnDawn()  // token 0x0600083A rva 0x25f1 attrs Public, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method IncomeModifyer::.ctor()  // token 0x0600083B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

