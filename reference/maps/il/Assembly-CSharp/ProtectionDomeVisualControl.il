// ===== ProtectionDomeVisualControl  (token 0x0200017C) =====
  .method ProtectionDomeVisualControl::Update()  // token 0x0600079F rva 0x25b4c attrs Private, HideBySig
    // code size 109 (0x6d), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool ProtectionDomeVisualControl::isDomeShowing  /*0x0400098F*/
    IL_0006: brtrue.s IL_0042
    IL_0008: ldarg.0
    IL_0009: ldfld bool ProtectionDomeVisualControl::destroyDome  /*0x0400098E*/
    IL_000e: brfalse.s IL_002a
    IL_0010: ldarg.0
    IL_0011: ldfld GameObject ProtectionDomeVisualControl::domeDestroyedVFX  /*0x0400098D*/
    IL_0016: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_001b: brtrue.s IL_0042
    IL_001d: ldarg.0
    IL_001e: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0023: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0028: br.s IL_0042
    IL_002a: ldarg.0
    IL_002b: ldfld GameObject ProtectionDomeVisualControl::domeDeactivateVFX  /*0x0400098C*/
    IL_0030: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0035: brtrue.s IL_0042
    IL_0037: ldarg.0
    IL_0038: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_003d: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0042: ldarg.0
    IL_0043: ldfld bool ProtectionDomeVisualControl::isDomeShowing  /*0x0400098F*/
    IL_0048: brfalse.s IL_005e
    IL_004a: ldarg.0
    IL_004b: ldfld GameObject ProtectionDomeVisualControl::mainDomeVFX  /*0x0400098B*/
    IL_0050: callvirt bool UnityEngine.GameObject::get_activeSelf()  /*0x0A0000BB*/
    IL_0055: brtrue.s IL_005e
    IL_0057: ldarg.0
    IL_0058: ldc.i4.0
    IL_0059: stfld bool ProtectionDomeVisualControl::isDomeShowing  /*0x0400098F*/
    IL_005e: ldarg.0
    IL_005f: ldfld bool ProtectionDomeVisualControl::destroyDome  /*0x0400098E*/
    IL_0064: brfalse.s IL_006c
    IL_0066: ldarg.0
    IL_0067: call void ProtectionDomeVisualControl::DestroyDomeVFX()  /*0x060007A0*/
    IL_006c: ret

  .method ProtectionDomeVisualControl::DestroyDomeVFX()  // token 0x060007A0 rva 0x25bc5 attrs Public, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ProtectionDomeVisualControl::isDomeShowing  /*0x0400098F*/
    IL_0006: brfalse.s IL_0027
    IL_0008: ldarg.0
    IL_0009: ldc.i4.0
    IL_000a: stfld bool ProtectionDomeVisualControl::isDomeShowing  /*0x0400098F*/
    IL_000f: ldarg.0
    IL_0010: ldfld GameObject ProtectionDomeVisualControl::domeDestroyedVFX  /*0x0400098D*/
    IL_0015: ldc.i4.1
    IL_0016: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001b: ldarg.0
    IL_001c: ldfld GameObject ProtectionDomeVisualControl::domeVFX  /*0x0400098A*/
    IL_0021: ldc.i4.0
    IL_0022: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0027: ret

  .method ProtectionDomeVisualControl::.ctor()  // token 0x060007A1 rva 0x25bee attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool ProtectionDomeVisualControl::isDomeShowing  /*0x0400098F*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

