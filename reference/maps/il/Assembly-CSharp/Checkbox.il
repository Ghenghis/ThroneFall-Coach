// ===== Checkbox  (token 0x020002E0) =====
  .method Checkbox::SetState(bool)  // token 0x06000FD6 rva 0x48679 attrs Public, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool Checkbox::state  /*0x040012AB*/
    IL_0007: ldarg.0
    IL_0008: call void Checkbox::UpdateDisplay()  /*0x06000FD8*/
    IL_000d: ret

  .method Checkbox::Toggle()  // token 0x06000FD7 rva 0x48688 attrs Public, HideBySig
    // code size 33 (0x21), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_0007: ldc.i4.0
    IL_0008: ceq
    IL_000a: stfld bool Checkbox::state  /*0x040012AB*/
    IL_000f: ldarg.0
    IL_0010: call void Checkbox::UpdateDisplay()  /*0x06000FD8*/
    IL_0015: ldarg.0
    IL_0016: ldfld UnityEvent Checkbox::onToggle  /*0x040012AA*/
    IL_001b: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0020: ret

  .method Checkbox::UpdateDisplay()  // token 0x06000FD8 rva 0x486aa attrs Private, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject Checkbox::checkObj  /*0x040012AC*/
    IL_0006: ldarg.0
    IL_0007: ldfld bool Checkbox::state  /*0x040012AB*/
    IL_000c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0011: ret

  .method Checkbox::.ctor()  // token 0x06000FD9 rva 0x486bd attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void UnityEngine.Events.UnityEvent::.ctor()  /*0x0A000079*/
    IL_0006: stfld UnityEvent Checkbox::onToggle  /*0x040012AA*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

