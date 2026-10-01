// ===== TargetPriorityExt  (token 0x02000122) =====
  .method TargetPriorityExt::.ctor()  // token 0x06000601 rva 0x195c7 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 2f
    IL_0006: stfld float TargetPriorityExt::attackDistance  /*0x04000767*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 1f
    IL_0011: stfld float TargetPriorityExt::secondaryWeaponCooldownDuration  /*0x04000769*/
    IL_0016: ldarg.0
    IL_0017: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_001c: stfld UnityEvent TargetPriorityExt::secondaryWeaponOnAttack  /*0x0400076A*/
    IL_0021: ldarg.0
    IL_0022: call void TargetPriority::.ctor()  /*0x06000E80*/
    IL_0027: ret

