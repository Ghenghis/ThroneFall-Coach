// ===== GhostQueenDeath  (token 0x0200018A) =====
  .method GhostQueenDeath::Start()  // token 0x060007F6 rva 0x26fea attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float GhostQueenDeath::scale  /*0x040009F1*/
    IL_000b: ldarg.0
    IL_000c: ldarg.0
    IL_000d: ldfld Light GhostQueenDeath::nightLight  /*0x040009F3*/
    IL_0012: callvirt float UnityEngine.Light::get_intensity()  /*0x0A0003AF*/
    IL_0017: stfld float GhostQueenDeath::startLightIntensity  /*0x040009F2*/
    IL_001c: ret

  .method GhostQueenDeath::Update()  // token 0x060007F7 rva 0x27008 attrs Private, HideBySig
    // code size 150 (0x96), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float GhostQueenDeath::scale  /*0x040009F1*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: ldc.r4 2f
    IL_0011: div
    IL_0012: sub
    IL_0013: stfld float GhostQueenDeath::scale  /*0x040009F1*/
    IL_0018: ldarg.0
    IL_0019: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_001e: ldarg.0
    IL_001f: ldfld float GhostQueenDeath::scale  /*0x040009F1*/
    IL_0024: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0029: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_002e: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0033: ldarg.0
    IL_0034: ldfld Light GhostQueenDeath::nightLight  /*0x040009F3*/
    IL_0039: ldarg.0
    IL_003a: ldfld float GhostQueenDeath::scale  /*0x040009F1*/
    IL_003f: ldarg.0
    IL_0040: ldfld float GhostQueenDeath::startLightIntensity  /*0x040009F2*/
    IL_0045: mul
    IL_0046: callvirt void UnityEngine.Light::set_intensity(float)  /*0x0A0003B0*/
    IL_004b: ldarg.0
    IL_004c: ldfld float GhostQueenDeath::scale  /*0x040009F1*/
    IL_0051: ldc.r4 0f
    IL_0056: bgt.un.s IL_0095
    IL_0058: ldarg.0
    IL_0059: ldfld Light GhostQueenDeath::nightLight  /*0x040009F3*/
    IL_005e: ldc.r4 0f
    IL_0063: callvirt void UnityEngine.Light::set_intensity(float)  /*0x0A0003B0*/
    IL_0068: ldc.i4.0
    IL_0069: stloc.0
    IL_006a: br.s IL_0087
    IL_006c: ldarg.0
    IL_006d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0072: ldloc.0
    IL_0073: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0078: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_007d: ldc.i4.0
    IL_007e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0083: ldloc.0
    IL_0084: ldc.i4.1
    IL_0085: add
    IL_0086: stloc.0
    IL_0087: ldloc.0
    IL_0088: ldarg.0
    IL_0089: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_008e: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0093: blt.s IL_006c
    IL_0095: ret

  .method GhostQueenDeath::.ctor()  // token 0x060007F8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

