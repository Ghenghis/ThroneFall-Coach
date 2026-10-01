// ===== PracticeTargetCoinDrop  (token 0x02000248) =====
  .method PracticeTargetCoinDrop::Start()  // token 0x06000C89 rva 0x39c52 attrs Private, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0007: stfld Hp PracticeTargetCoinDrop::hp  /*0x04000F3A*/
    IL_000c: ldarg.0
    IL_000d: ldsfld TagManager TagManager::instance  /*0x0400108C*/
    IL_0012: stfld TagManager PracticeTargetCoinDrop::tagManager  /*0x04000F3B*/
    IL_0017: ret

  .method PracticeTargetCoinDrop::Update()  // token 0x06000C8A rva 0x39c6b attrs Private, HideBySig
    // code size 34 (0x22), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld TagManager PracticeTargetCoinDrop::tagManager  /*0x04000F3B*/
    IL_0006: ldc.i4.s 15
    IL_0008: callvirt int TagManager::CountAllTaggedObjectsWithTag(TagManager.ETag)  /*0x06000E65*/
    IL_000d: ldarg.0
    IL_000e: ldfld int PracticeTargetCoinDrop::totalCoinsToDrop  /*0x04000F3C*/
    IL_0013: bgt.s IL_0021
    IL_0015: ldarg.0
    IL_0016: ldfld Hp PracticeTargetCoinDrop::hp  /*0x04000F3A*/
    IL_001b: ldc.i4.1
    IL_001c: stfld int Hp::coinCount  /*0x04000A4B*/
    IL_0021: ret

  .method PracticeTargetCoinDrop::OnDestroy()  // token 0x06000C8B rva 0x39c8e attrs Private, HideBySig
    // code size 39 (0x27), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp PracticeTargetCoinDrop::hp  /*0x04000F3A*/
    IL_0006: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000b: brtrue.s IL_000e
    IL_000d: ret
    IL_000e: ldarg.0
    IL_000f: ldfld Hp PracticeTargetCoinDrop::hp  /*0x04000F3A*/
    IL_0014: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0019: ldc.r4 0f
    IL_001e: bgt.un.s IL_0026
    IL_0020: ldc.i4.0
    IL_0021: call void AchievementManager::UnlockAchievement(AchievementManager.Achievements)  /*0x06000911*/
    IL_0026: ret

  .method PracticeTargetCoinDrop::.ctor()  // token 0x06000C8C rva 0x39cb6 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.3
    IL_0002: stfld int PracticeTargetCoinDrop::totalCoinsToDrop  /*0x04000F3C*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

