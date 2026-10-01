// ===== Choice  (token 0x020001C6) =====
  .method Choice::get_CanBePicked()  // token 0x0600092A rva 0x2b9fe attrs Public, HideBySig, SpecialName
    // code size 42 (0x2a), max stack 8
    IL_0000: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0005: callvirt bool LevelProgressManager::AreAllBuildOptionsUnlockedInThisLevel()  /*0x06000948*/
    IL_000a: brtrue.s IL_0028
    IL_000c: ldarg.0
    IL_000d: ldfld EquippableBuildingUpgrade Choice::requiresUnlocked  /*0x04000B96*/
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0018: brtrue.s IL_0026
    IL_001a: ldarg.0
    IL_001b: ldfld EquippableBuildingUpgrade Choice::requiresUnlocked  /*0x04000B96*/
    IL_0020: callvirt bool Equippable::get_IsUnlocked()  /*0x06000B54*/
    IL_0025: ret
    IL_0026: ldc.i4.1
    IL_0027: ret
    IL_0028: ldc.i4.1
    IL_0029: ret

  .method Choice::.ctor(string,string,UnityEngine.Sprite)  // token 0x0600092B rva 0x2ba29 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "<nameHere>"
    IL_0006: stfld string Choice::name  /*0x04000B92*/
    IL_000b: ldarg.0
    IL_000c: ldstr "<tooltipHere>"
    IL_0011: stfld string Choice::tooltip  /*0x04000B93*/
    IL_0016: ldarg.0
    IL_0017: call void System.Object::.ctor()  /*0x0A000038*/
    IL_001c: ldarg.0
    IL_001d: ldarg.1
    IL_001e: stfld string Choice::name  /*0x04000B92*/
    IL_0023: ldarg.0
    IL_0024: ldarg.2
    IL_0025: stfld string Choice::tooltip  /*0x04000B93*/
    IL_002a: ldarg.0
    IL_002b: ldnull
    IL_002c: stfld Sprite Choice::icon  /*0x04000B94*/
    IL_0031: ret

