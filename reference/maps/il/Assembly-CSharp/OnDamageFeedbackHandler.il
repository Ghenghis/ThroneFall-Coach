// ===== OnDamageFeedbackHandler  (token 0x02000176) =====
  .method OnDamageFeedbackHandler::Start()  // token 0x0600078C rva 0x25790 attrs Private, HideBySig
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp OnDamageFeedbackHandler::target  /*0x04000972*/
    IL_0006: ldfld UnityEvent<bool> Hp::OnReceiveDamage  /*0x04000A3D*/
    IL_000b: ldarg.0
    IL_000c: ldftn void OnDamageFeedbackHandler::TakeDamage(bool)  /*0x0600078D*/
    IL_0012: newobj void UnityEngine.Events.UnityAction<bool>::.ctor(object,IntPtr)  /*0x0A0000CC*/
    IL_0017: callvirt void UnityEngine.Events.UnityEvent<bool>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0000CD*/
    IL_001c: ret

  .method OnDamageFeedbackHandler::TakeDamage(bool)  // token 0x0600078D rva 0x257b0 attrs Private, HideBySig
    // code size 111 (0x6f), max stack 4, init locals
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_005c
    IL_0003: ldarg.0
    IL_0004: ldfld GameObject OnDamageFeedbackHandler::onDmgByPlayerFX  /*0x04000974*/
    IL_0009: ldarg.0
    IL_000a: ldfld Hp OnDamageFeedbackHandler::target  /*0x04000972*/
    IL_000f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0014: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0019: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_001e: ldarg.0
    IL_001f: ldfld Hp OnDamageFeedbackHandler::target  /*0x04000972*/
    IL_0024: ldfld float Hp::hitFeedbackHeight  /*0x04000A32*/
    IL_0029: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_002e: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0033: ldarg.0
    IL_0034: ldfld GameObject OnDamageFeedbackHandler::onDmgByPlayerFX  /*0x04000974*/
    IL_0039: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_003e: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0043: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0048: pop
    IL_0049: ldarg.0
    IL_004a: ldfld MaterialFlasherFX OnDamageFeedbackHandler::flasher  /*0x04000973*/
    IL_004f: ldc.i4.1
    IL_0050: ldarg.0
    IL_0051: ldfld float OnDamageFeedbackHandler::flashDuration  /*0x04000975*/
    IL_0056: callvirt void MaterialFlasherFX::TriggerFlash(bool,float)  /*0x06000783*/
    IL_005b: ret
    IL_005c: ldarg.0
    IL_005d: ldfld MaterialFlasherFX OnDamageFeedbackHandler::flasher  /*0x04000973*/
    IL_0062: ldc.i4.0
    IL_0063: ldarg.0
    IL_0064: ldfld float OnDamageFeedbackHandler::flashDuration  /*0x04000975*/
    IL_0069: callvirt void MaterialFlasherFX::TriggerFlash(bool,float)  /*0x06000783*/
    IL_006e: ret

  .method OnDamageFeedbackHandler::.ctor()  // token 0x0600078E rva 0x2582b attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.25f
    IL_0006: stfld float OnDamageFeedbackHandler::flashDuration  /*0x04000975*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

