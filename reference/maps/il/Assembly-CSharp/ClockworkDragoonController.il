// ===== ClockworkDragoonController  (token 0x020000F1) =====
  .method ClockworkDragoonController::OnEnable()  // token 0x06000519 rva 0x166c0 attrs Private, HideBySig
    // code size 86 (0x56), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld ExplosionWeapon ClockworkDragoonController::explosionWeapon  /*0x040006A2*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldstr "[ClockworkDragoonController] requires explosionWeapon to be set"
    IL_0013: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldfld Hp ClockworkDragoonController::hp  /*0x040006A1*/
    IL_001f: ldnull
    IL_0020: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0025: brfalse.s IL_0032
    IL_0027: ldstr "[ClockworkDragoonController] requires hp to be set"
    IL_002c: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_0031: ret
    IL_0032: ldarg.0
    IL_0033: ldfld Hp ClockworkDragoonController::hp  /*0x040006A1*/
    IL_0038: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_003d: ldarg.0
    IL_003e: ldftn void ClockworkDragoonController::OnDeathExplosion()  /*0x0600051B*/
    IL_0044: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0049: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_004e: ldarg.0
    IL_004f: ldc.i4.1
    IL_0050: stfld bool ClockworkDragoonController::inited  /*0x040006A4*/
    IL_0055: ret

  .method ClockworkDragoonController::OnDisable()  // token 0x0600051A rva 0x16722 attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool ClockworkDragoonController::inited  /*0x040006A4*/
    IL_0006: brfalse.s IL_002b
    IL_0008: ldarg.0
    IL_0009: ldfld Hp ClockworkDragoonController::hp  /*0x040006A1*/
    IL_000e: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0013: ldarg.0
    IL_0014: ldftn void ClockworkDragoonController::OnDeathExplosion()  /*0x0600051B*/
    IL_001a: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_001f: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_0024: ldarg.0
    IL_0025: ldc.i4.0
    IL_0026: stfld bool ClockworkDragoonController::inited  /*0x040006A4*/
    IL_002b: ret

  .method ClockworkDragoonController::OnDeathExplosion()  // token 0x0600051B rva 0x16750 attrs Private, HideBySig
    // code size 84 (0x54), max stack 4, init locals
    .locals ([0] GameObject)
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ClockworkDragoonController::explosionEffectPrefab  /*0x040006A3*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_0040
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject ClockworkDragoonController::explosionEffectPrefab  /*0x040006A3*/
    IL_0014: call GameObject ObjectPools::GetPooledItemByObject(UnityEngine.GameObject)  /*0x06000E9A*/
    IL_0019: stloc.0
    IL_001a: ldloc.0
    IL_001b: ldnull
    IL_001c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0021: brfalse.s IL_0040
    IL_0023: ldloc.0
    IL_0024: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0029: ldarg.0
    IL_002a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_002f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0034: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0039: ldloc.0
    IL_003a: ldc.i4.1
    IL_003b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0040: ldarg.0
    IL_0041: ldfld ExplosionWeapon ClockworkDragoonController::explosionWeapon  /*0x040006A2*/
    IL_0046: ldarg.0
    IL_0047: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_004c: ldnull
    IL_004d: ldnull
    IL_004e: callvirt void ExplosionWeapon::Explode(UnityEngine.Transform,System.Action,System.Action)  /*0x06000530*/
    IL_0053: ret

  .method ClockworkDragoonController::.ctor()  // token 0x0600051C rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

