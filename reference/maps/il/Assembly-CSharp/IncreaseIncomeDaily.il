// ===== IncreaseIncomeDaily  (token 0x02000197) =====
  .method IncreaseIncomeDaily::Initialize()  // token 0x06000843 rva 0x287b7 attrs Private, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool IncreaseIncomeDaily::initialized  /*0x04000A5F*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: call !!0 UnityEngine.Component::GetComponent()<BuildSlot>  /*0x2B00001A*/
    IL_0010: stfld BuildSlot IncreaseIncomeDaily::myBuildSlot  /*0x04000A5E*/
    IL_0015: ldarg.0
    IL_0016: ldfld BuildSlot IncreaseIncomeDaily::myBuildSlot  /*0x04000A5E*/
    IL_001b: callvirt BuildingInteractor BuildSlot::get_Interactor()  /*0x060002D6*/
    IL_0020: callvirt List<IncomeModifyer> BuildingInteractor::get_IncomeModifiers()  /*0x06000BA1*/
    IL_0025: ldarg.0
    IL_0026: callvirt void System.Collections.Generic.List<IncomeModifyer>::Add(!0)  /*0x0A000363*/
    IL_002b: ldarg.0
    IL_002c: ldc.i4.1
    IL_002d: stfld bool IncreaseIncomeDaily::initialized  /*0x04000A5F*/
    IL_0032: ret

  .method IncreaseIncomeDaily::Start()  // token 0x06000844 rva 0x287eb attrs Private, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void IncreaseIncomeDaily::Initialize()  /*0x06000843*/
    IL_0006: ret

  .method IncreaseIncomeDaily::OnDawn()  // token 0x06000845 rva 0x287f3 attrs Public, Virtual, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot IncreaseIncomeDaily::myBuildSlot  /*0x04000A5E*/
    IL_0006: dup
    IL_0007: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_000c: ldc.i4.1
    IL_000d: add
    IL_000e: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: ldfld int IncreaseIncomeDaily::incomeIncrease  /*0x04000A5D*/
    IL_001a: ldc.i4.1
    IL_001b: add
    IL_001c: stfld int IncreaseIncomeDaily::incomeIncrease  /*0x04000A5D*/
    IL_0021: ret

  .method IncreaseIncomeDaily::OnBeforeMainLoadPass(string)  // token 0x06000846 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method IncreaseIncomeDaily::OnLoad(string)  // token 0x06000847 rva 0x28816 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 60 (0x3c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void IncreaseIncomeDaily::Initialize()  /*0x06000843*/
    IL_0006: ldarg.0
    IL_0007: ldc.i4.0
    IL_0008: stfld int IncreaseIncomeDaily::incomeIncrease  /*0x04000A5D*/
    IL_000d: ldarg.1
    IL_000e: ldstr "incomeIncrease"
    IL_0013: ldarg.0
    IL_0014: ldflda int IncreaseIncomeDaily::incomeIncrease  /*0x04000A5D*/
    IL_0019: call bool MatchSaveLoadHandler::TryLoadValue(string,string,ref !!0)<int>  /*0x2B00001F*/
    IL_001e: pop
    IL_001f: ldarg.0
    IL_0020: ldfld BuildSlot IncreaseIncomeDaily::myBuildSlot  /*0x04000A5E*/
    IL_0025: ldfld UnityEvent BuildSlot::OnAfterDelayedLoadFinished  /*0x0400039E*/
    IL_002a: ldarg.0
    IL_002b: ldftn void IncreaseIncomeDaily::ExecuteDelayedLoad()  /*0x06000848*/
    IL_0031: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0036: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_003b: ret

  .method IncreaseIncomeDaily::ExecuteDelayedLoad()  // token 0x06000848 rva 0x28853 attrs Private, HideBySig
    // code size 31 (0x1f), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void IncreaseIncomeDaily::Initialize()  /*0x06000843*/
    IL_0006: ldarg.0
    IL_0007: ldfld BuildSlot IncreaseIncomeDaily::myBuildSlot  /*0x04000A5E*/
    IL_000c: dup
    IL_000d: callvirt int BuildSlot::get_GoldIncome()  /*0x060002DA*/
    IL_0012: ldarg.0
    IL_0013: ldfld int IncreaseIncomeDaily::incomeIncrease  /*0x04000A5D*/
    IL_0018: add
    IL_0019: callvirt void BuildSlot::set_GoldIncome(int)  /*0x060002DB*/
    IL_001e: ret

  .method IncreaseIncomeDaily::OnSave(string)  // token 0x06000849 rva 0x28873 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldstr "incomeIncrease"
    IL_0006: ldarg.0
    IL_0007: ldfld int IncreaseIncomeDaily::incomeIncrease  /*0x04000A5D*/
    IL_000c: call void MatchSaveLoadHandler::SaveValue(string,string,int)  /*0x06000CF6*/
    IL_0011: ret

  .method IncreaseIncomeDaily::OnAfterMainLoadPass(string)  // token 0x0600084A rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method IncreaseIncomeDaily::.ctor()  // token 0x0600084B rva 0x28886 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void IncomeModifyer::.ctor()  /*0x0600083B*/
    IL_0006: ret

