// ===== FishingHarbourUpgrade  (token 0x0200016A) =====
  .method FishingHarbourUpgrade::OnEnable()  // token 0x06000766 rva 0x25103 attrs Private, HideBySig
    // code size 56 (0x38), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld FishingHarbour FishingHarbourUpgrade::fishingHarbour  /*0x0400094C*/
    IL_0006: dup
    IL_0007: ldfld int FishingHarbour::maximumIncome  /*0x0400093D*/
    IL_000c: ldc.i4.2
    IL_000d: mul
    IL_000e: stfld int FishingHarbour::maximumIncome  /*0x0400093D*/
    IL_0013: ldarg.0
    IL_0014: ldfld FishingHarbour FishingHarbourUpgrade::fishingHarbour  /*0x0400094C*/
    IL_0019: dup
    IL_001a: ldfld int FishingHarbour::incomeIncreasePerTurn  /*0x0400093C*/
    IL_001f: ldc.i4.2
    IL_0020: mul
    IL_0021: stfld int FishingHarbour::incomeIncreasePerTurn  /*0x0400093C*/
    IL_0026: ldarg.0
    IL_0027: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_002c: ldarg.0
    IL_002d: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0032: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0037: ret

  .method FishingHarbourUpgrade::.ctor()  // token 0x06000767 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

