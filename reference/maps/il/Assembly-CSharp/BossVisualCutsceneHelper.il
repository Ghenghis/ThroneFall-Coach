// ===== BossVisualCutsceneHelper  (token 0x020000EF) =====
  .method BossVisualCutsceneHelper::Update()  // token 0x06000513 rva 0x164da attrs Private, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float BossVisualCutsceneHelper::_duration  /*0x0400069B*/
    IL_0006: ldc.r4 0f
    IL_000b: blt.un.s IL_0020
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float BossVisualCutsceneHelper::_duration  /*0x0400069B*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: sub
    IL_001a: stfld float BossVisualCutsceneHelper::_duration  /*0x0400069B*/
    IL_001f: ret
    IL_0020: ldarg.0
    IL_0021: ldfld GameObject BossVisualCutsceneHelper::_bossGameObject  /*0x0400069A*/
    IL_0026: ldc.i4.1
    IL_0027: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0032: ret

  .method BossVisualCutsceneHelper::.ctor()  // token 0x06000514 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

