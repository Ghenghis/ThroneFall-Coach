// ===== AutoAttackDrone  (token 0x020000C7) =====
  .method AutoAttackDrone::Start()  // token 0x0600041C rva 0x11aa0 attrs Public, Virtual, HideBySig
    // code size 96 (0x60), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_000d: stfld Hp AutoAttackDrone::hp  /*0x04000554*/
    IL_0012: ldarg.0
    IL_0013: ldfld Hp AutoAttackDrone::hp  /*0x04000554*/
    IL_0018: ldnull
    IL_0019: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001e: brfalse.s IL_003c
    IL_0020: ldarg.0
    IL_0021: ldfld Hp AutoAttackDrone::hp  /*0x04000554*/
    IL_0026: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_002b: ldarg.0
    IL_002c: ldftn void AutoAttackDrone::OnDeath()  /*0x0600041E*/
    IL_0032: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0037: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_003c: ldarg.0
    IL_003d: ldarg.0
    IL_003e: ldfld float AutoAttackDrone::droneConstructionTime  /*0x0400054B*/
    IL_0043: stfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_0048: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_004d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0052: brfalse.s IL_005f
    IL_0054: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_0059: ldarg.0
    IL_005a: callvirt void DayNightCycle::RegisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B3*/
    IL_005f: ret

  .method AutoAttackDrone::OnDestroy()  // token 0x0600041D rva 0x11b0c attrs Public, HideBySig
    // code size 66 (0x42), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Hp AutoAttackDrone::hp  /*0x04000554*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000c: brfalse.s IL_002a
    IL_000e: ldarg.0
    IL_000f: ldfld Hp AutoAttackDrone::hp  /*0x04000554*/
    IL_0014: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_0019: ldarg.0
    IL_001a: ldftn void AutoAttackDrone::OnDeath()  /*0x0600041E*/
    IL_0020: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0025: callvirt void UnityEngine.Events.UnityEvent::RemoveListener(UnityEngine.Events.UnityAction)  /*0x0A0000B2*/
    IL_002a: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_002f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0034: brfalse.s IL_0041
    IL_0036: call DayNightCycle DayNightCycle::get_Instance()  /*0x060003A1*/
    IL_003b: ldarg.0
    IL_003c: callvirt void DayNightCycle::UnregisterDaytimeSensitiveObject(DayNightCycle.IDaytimeSensitive)  /*0x060003B4*/
    IL_0041: ret

  .method AutoAttackDrone::OnDeath()  // token 0x0600041E rva 0x11b5c attrs Private, HideBySig
    // code size 128 (0x80), max stack 2, init locals
    .locals ([0] List.Enumerator<GameObject>, [1] GameObject)
    IL_0000: ldarg.0
    IL_0001: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<UnityEngine.GameObject>::GetEnumerator()  /*0x0A000129*/
    IL_000b: stloc.0
    IL_000c: br.s IL_0029
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::get_Current()  /*0x0A00012A*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: ldc.i4.0
    IL_0018: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001d: ldarg.0
    IL_001e: ldfld Queue<GameObject> AutoAttackDrone::dronePool  /*0x04000550*/
    IL_0023: ldloc.1
    IL_0024: callvirt void System.Collections.Generic.Queue<UnityEngine.GameObject>::Enqueue(!0)  /*0x0A0001BC*/
    IL_0029: ldloca.s 0
    IL_002b: call bool System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>::MoveNext()  /*0x0A00012B*/
    IL_0030: brtrue.s IL_000e
    IL_0032: leave.s IL_0042
    IL_0034: ldloca.s 0
    IL_0036: constrained. System.Collections.Generic.List.Enumerator<UnityEngine.GameObject>  /*0x1B000025*/
    IL_003c: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0041: endfinally
    IL_0042: ldarg.0
    IL_0043: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_0048: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Clear()  /*0x0A0001BD*/
    IL_004d: ldarg.0
    IL_004e: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_0053: ldnull
    IL_0054: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0059: brfalse.s IL_0078
    IL_005b: ldarg.0
    IL_005c: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_0061: ldc.i4.0
    IL_0062: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0067: ldarg.0
    IL_0068: ldfld Queue<GameObject> AutoAttackDrone::dronePool  /*0x04000550*/
    IL_006d: ldarg.0
    IL_006e: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_0073: callvirt void System.Collections.Generic.Queue<UnityEngine.GameObject>::Enqueue(!0)  /*0x0A0001BC*/
    IL_0078: ldarg.0
    IL_0079: ldnull
    IL_007a: stfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_007f: ret
    .try IL_000c-IL_0034 finally handler IL_0034-IL_0042

  .method AutoAttackDrone::UpdateOrbitState(float)  // token 0x0600041F rva 0x11bf8 attrs Private, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttackDrone::currentOrbitRotationDeg  /*0x04000553*/
    IL_0007: ldarg.0
    IL_0008: ldfld float AutoAttackDrone::droneOrbitAngularSpeedDeg  /*0x0400054D*/
    IL_000d: ldarg.1
    IL_000e: mul
    IL_000f: add
    IL_0010: stfld float AutoAttackDrone::currentOrbitRotationDeg  /*0x04000553*/
    IL_0015: ldarg.0
    IL_0016: ldarg.0
    IL_0017: ldfld float AutoAttackDrone::currentOrbitRotationDeg  /*0x04000553*/
    IL_001c: ldc.r4 360f
    IL_0021: call float UnityEngine.Mathf::Repeat(float,float)  /*0x0A0001BE*/
    IL_0026: stfld float AutoAttackDrone::currentOrbitRotationDeg  /*0x04000553*/
    IL_002b: ret

  .method AutoAttackDrone::GetDronePositionAndAngle(int)  // token 0x06000420 rva 0x11c28 attrs Private, HideBySig
    // code size 115 (0x73), max stack 4, init locals
    .locals ([0] int, [1] float, [2] float, [3] float)
    IL_0000: ldarg.0
    IL_0001: ldfld int AutoAttackDrone::droneMaxCount  /*0x0400054A*/
    IL_0006: ldarg.1
    IL_0007: sub
    IL_0008: stloc.0
    IL_0009: ldarg.0
    IL_000a: ldfld float AutoAttackDrone::currentOrbitRotationDeg  /*0x04000553*/
    IL_000f: ldloc.0
    IL_0010: conv.r4
    IL_0011: ldc.r4 360f
    IL_0016: ldarg.0
    IL_0017: ldfld int AutoAttackDrone::droneMaxCount  /*0x0400054A*/
    IL_001c: conv.r4
    IL_001d: div
    IL_001e: mul
    IL_001f: add
    IL_0020: stloc.1
    IL_0021: ldloc.1
    IL_0022: ldc.r4 360f
    IL_0027: call float UnityEngine.Mathf::Repeat(float,float)  /*0x0A0001BE*/
    IL_002c: stloc.1
    IL_002d: ldc.r4 0.017453292f
    IL_0032: ldloc.1
    IL_0033: mul
    IL_0034: stloc.2
    IL_0035: ldarg.0
    IL_0036: ldfld float AutoAttackDrone::droneOrbitRadius  /*0x0400054C*/
    IL_003b: ldloc.2
    IL_003c: call float UnityEngine.Mathf::Cos(float)  /*0x0A0001BF*/
    IL_0041: mul
    IL_0042: ldarg.0
    IL_0043: ldfld float AutoAttackDrone::droneOrbitRadius  /*0x0400054C*/
    IL_0048: ldloc.2
    IL_0049: call float UnityEngine.Mathf::Sin(float)  /*0x0A0000AB*/
    IL_004e: mul
    IL_004f: stloc.3
    IL_0050: ldarg.0
    IL_0051: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_0056: ldloc.3
    IL_0057: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_005c: ldarg.0
    IL_005d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0062: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0067: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_006c: ldloc.1
    IL_006d: newobj void System.ValueTuple<UnityEngine.Vector3, float>::.ctor(!0,!1)  /*0x0A0001C0*/
    IL_0072: ret

  .method AutoAttackDrone::UpdateDronePositionsAndAngles()  // token 0x06000421 rva 0x11ca8 attrs Private, HideBySig
    // code size 251 (0xfb), max stack 4, init locals
    .locals ([0] int, [1] Vector3, [2] float, [3] int, [4] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int AutoAttackDrone::droneUnderConstructionIndex  /*0x04000552*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_000c: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_0011: sub
    IL_0012: stloc.0
    IL_0013: ldloc.0
    IL_0014: ldc.i4.0
    IL_0015: bge.s IL_0020
    IL_0017: ldarg.0
    IL_0018: ldfld int AutoAttackDrone::droneMaxCount  /*0x0400054A*/
    IL_001d: ldloc.0
    IL_001e: add
    IL_001f: stloc.0
    IL_0020: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0025: stloc.1
    IL_0026: ldc.r4 0f
    IL_002b: stloc.2
    IL_002c: ldc.i4.0
    IL_002d: stloc.3
    IL_002e: br.s IL_0093
    IL_0030: ldloc.0
    IL_0031: ldloc.3
    IL_0032: add
    IL_0033: ldarg.0
    IL_0034: ldfld int AutoAttackDrone::droneMaxCount  /*0x0400054A*/
    IL_0039: rem
    IL_003a: stloc.s 4
    IL_003c: ldarg.0
    IL_003d: ldloc.s 4
    IL_003f: call ValueTuple<Vector3, float> AutoAttackDrone::GetDronePositionAndAngle(int)  /*0x06000420*/
    IL_0044: dup
    IL_0045: ldfld !0 System.ValueTuple<UnityEngine.Vector3, float>::Item1  /*0x0A0001C3*/
    IL_004a: stloc.1
    IL_004b: ldfld !1 System.ValueTuple<UnityEngine.Vector3, float>::Item2  /*0x0A0001C4*/
    IL_0050: stloc.2
    IL_0051: ldarg.0
    IL_0052: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_0057: ldloc.3
    IL_0058: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_005d: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0062: ldloc.1
    IL_0063: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0068: ldarg.0
    IL_0069: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_006e: ldloc.3
    IL_006f: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_0074: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0079: ldc.r4 0f
    IL_007e: ldloc.2
    IL_007f: neg
    IL_0080: ldc.r4 0f
    IL_0085: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_008a: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_008f: ldloc.3
    IL_0090: ldc.i4.1
    IL_0091: add
    IL_0092: stloc.3
    IL_0093: ldloc.3
    IL_0094: ldarg.0
    IL_0095: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_009a: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_009f: blt.s IL_0030
    IL_00a1: ldarg.0
    IL_00a2: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_00a7: ldnull
    IL_00a8: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00ad: brfalse.s IL_00fa
    IL_00af: ldarg.0
    IL_00b0: ldarg.0
    IL_00b1: ldfld int AutoAttackDrone::droneUnderConstructionIndex  /*0x04000552*/
    IL_00b6: call ValueTuple<Vector3, float> AutoAttackDrone::GetDronePositionAndAngle(int)  /*0x06000420*/
    IL_00bb: dup
    IL_00bc: ldfld !0 System.ValueTuple<UnityEngine.Vector3, float>::Item1  /*0x0A0001C3*/
    IL_00c1: stloc.1
    IL_00c2: ldfld !1 System.ValueTuple<UnityEngine.Vector3, float>::Item2  /*0x0A0001C4*/
    IL_00c7: stloc.2
    IL_00c8: ldarg.0
    IL_00c9: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_00ce: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00d3: ldloc.1
    IL_00d4: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_00d9: ldarg.0
    IL_00da: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_00df: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00e4: ldc.r4 0f
    IL_00e9: ldloc.2
    IL_00ea: neg
    IL_00eb: ldc.r4 0f
    IL_00f0: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_00f5: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_00fa: ret

  .method AutoAttackDrone::IncrementNextDroneIndex()  // token 0x06000422 rva 0x11daf attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int AutoAttackDrone::droneUnderConstructionIndex  /*0x04000552*/
    IL_0007: ldc.i4.1
    IL_0008: add
    IL_0009: ldarg.0
    IL_000a: ldfld int AutoAttackDrone::droneMaxCount  /*0x0400054A*/
    IL_000f: rem
    IL_0010: stfld int AutoAttackDrone::droneUnderConstructionIndex  /*0x04000552*/
    IL_0015: ret

  .method AutoAttackDrone::CompleteDroneConstruction()  // token 0x06000423 rva 0x11dc6 attrs Private, HideBySig
    // code size 52 (0x34), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_0006: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_000b: call Vector3 UnityEngine.Vector3::get_one()  /*0x0A000083*/
    IL_0010: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_0015: ldarg.0
    IL_0016: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_001b: ldarg.0
    IL_001c: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_0021: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::Add(!0)  /*0x0A0001C6*/
    IL_0026: ldarg.0
    IL_0027: call void AutoAttackDrone::IncrementNextDroneIndex()  /*0x06000422*/
    IL_002c: ldarg.0
    IL_002d: ldnull
    IL_002e: stfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_0033: ret

  .method AutoAttackDrone::ConstructDrone()  // token 0x06000424 rva 0x11dfc attrs Private, HideBySig
    // code size 230 (0xe6), max stack 4, init locals
    .locals ([0] float)
    IL_0000: ldarg.0
    IL_0001: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_0006: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_000b: ldarg.0
    IL_000c: ldfld int AutoAttackDrone::droneMaxCount  /*0x0400054A*/
    IL_0011: bge IL_00d9
    IL_0016: ldarg.0
    IL_0017: ldarg.0
    IL_0018: ldfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_001d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0022: sub
    IL_0023: stfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_0028: ldarg.0
    IL_0029: ldfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_002e: ldc.r4 0f
    IL_0033: bgt.un.s IL_005d
    IL_0035: ldarg.0
    IL_0036: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_003b: ldnull
    IL_003c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0041: brfalse.s IL_005d
    IL_0043: ldarg.0
    IL_0044: ldarg.0
    IL_0045: ldfld float AutoAttackDrone::droneConstructionTime  /*0x0400054B*/
    IL_004a: ldarg.0
    IL_004b: ldfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_0050: add
    IL_0051: stfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_0056: ldarg.0
    IL_0057: call void AutoAttackDrone::CompleteDroneConstruction()  /*0x06000423*/
    IL_005c: ret
    IL_005d: ldarg.0
    IL_005e: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_0063: ldnull
    IL_0064: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0069: brfalse.s IL_00a8
    IL_006b: ldarg.0
    IL_006c: ldfld float AutoAttackDrone::droneConstructionTime  /*0x0400054B*/
    IL_0071: ldarg.0
    IL_0072: ldfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_0077: sub
    IL_0078: ldarg.0
    IL_0079: ldfld float AutoAttackDrone::droneConstructionTime  /*0x0400054B*/
    IL_007e: div
    IL_007f: ldc.r4 0.1f
    IL_0084: ldc.r4 1f
    IL_0089: call float UnityEngine.Mathf::Clamp(float,float,float)  /*0x0A00010B*/
    IL_008e: stloc.0
    IL_008f: ldarg.0
    IL_0090: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_0095: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_009a: ldloc.0
    IL_009b: ldloc.0
    IL_009c: ldloc.0
    IL_009d: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00a2: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00a7: ret
    IL_00a8: ldarg.0
    IL_00a9: ldarg.0
    IL_00aa: call GameObject AutoAttackDrone::GetDroneGameObject()  /*0x06000428*/
    IL_00af: stfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_00b4: ldarg.0
    IL_00b5: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_00ba: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_00bf: ldc.r4 0.1f
    IL_00c4: ldc.r4 0.1f
    IL_00c9: ldc.r4 0.1f
    IL_00ce: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00d3: callvirt void UnityEngine.Transform::set_localScale(UnityEngine.Vector3)  /*0x0A000036*/
    IL_00d8: ret
    IL_00d9: ldarg.0
    IL_00da: ldarg.0
    IL_00db: ldfld float AutoAttackDrone::droneConstructionTime  /*0x0400054B*/
    IL_00e0: stfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_00e5: ret

  .method AutoAttackDrone::ConstructAllDronesImmediately()  // token 0x06000425 rva 0x11ef0 attrs Public, HideBySig
    // code size 102 (0x66), max stack 2, init locals
    .locals ([0] int, [1] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int AutoAttackDrone::droneMaxCount  /*0x0400054A*/
    IL_0006: ldarg.0
    IL_0007: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_000c: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_0011: sub
    IL_0012: stloc.0
    IL_0013: ldloc.0
    IL_0014: ldc.i4.0
    IL_0015: ble.s IL_004d
    IL_0017: ldarg.0
    IL_0018: ldfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_001d: ldnull
    IL_001e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0023: brfalse.s IL_002f
    IL_0025: ldarg.0
    IL_0026: call void AutoAttackDrone::CompleteDroneConstruction()  /*0x06000423*/
    IL_002b: ldloc.0
    IL_002c: ldc.i4.1
    IL_002d: sub
    IL_002e: stloc.0
    IL_002f: ldc.i4.0
    IL_0030: stloc.1
    IL_0031: br.s IL_0049
    IL_0033: ldarg.0
    IL_0034: ldarg.0
    IL_0035: call GameObject AutoAttackDrone::GetDroneGameObject()  /*0x06000428*/
    IL_003a: stfld GameObject AutoAttackDrone::droneUnderConstruction  /*0x04000551*/
    IL_003f: ldarg.0
    IL_0040: call void AutoAttackDrone::CompleteDroneConstruction()  /*0x06000423*/
    IL_0045: ldloc.1
    IL_0046: ldc.i4.1
    IL_0047: add
    IL_0048: stloc.1
    IL_0049: ldloc.1
    IL_004a: ldloc.0
    IL_004b: blt.s IL_0033
    IL_004d: ldarg.0
    IL_004e: ldarg.0
    IL_004f: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_0054: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0059: ldarg.0
    IL_005a: ldarg.0
    IL_005b: ldfld float AutoAttackDrone::droneConstructionTime  /*0x0400054B*/
    IL_0060: stfld float AutoAttackDrone::constructionCooldown  /*0x0400054E*/
    IL_0065: ret

  .method AutoAttackDrone::ExtractOldestCompletedDrone()  // token 0x06000426 rva 0x11f62 attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_0006: ldc.i4.0
    IL_0007: callvirt !0 System.Collections.Generic.List<UnityEngine.GameObject>::get_Item(int)  /*0x0A0001C5*/
    IL_000c: ldarg.0
    IL_000d: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_0012: ldc.i4.0
    IL_0013: callvirt void System.Collections.Generic.List<UnityEngine.GameObject>::RemoveAt(int)  /*0x0A0001C7*/
    IL_0018: ret

  .method AutoAttackDrone::Update()  // token 0x06000427 rva 0x11f7c attrs Public, Virtual, HideBySig
    // code size 255 (0xff), max stack 7, init locals
    .locals ([0] TaggedObject, [1] GameObject, [2] Transform)
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0012: ldarg.0
    IL_0013: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un IL_00e7
    IL_0022: ldarg.0
    IL_0023: ldfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_0028: callvirt int System.Collections.Generic.List<UnityEngine.GameObject>::get_Count()  /*0x0A0001C2*/
    IL_002d: ldc.i4.0
    IL_002e: ble IL_00e7
    IL_0033: ldarg.0
    IL_0034: ldc.i4.0
    IL_0035: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_003a: ldarg.0
    IL_003b: callvirt TaggedObject AutoAttack::FindAutoAttackTarget()  /*0x06000236*/
    IL_0040: stloc.0
    IL_0041: ldloc.0
    IL_0042: ldnull
    IL_0043: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0048: brfalse IL_00d4
    IL_004d: ldarg.0
    IL_004e: ldarg.0
    IL_004f: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0054: ldarg.0
    IL_0055: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_005a: add
    IL_005b: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0060: ldarg.0
    IL_0061: call GameObject AutoAttackDrone::ExtractOldestCompletedDrone()  /*0x06000426*/
    IL_0066: stloc.1
    IL_0067: ldloc.1
    IL_0068: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_006d: stloc.2
    IL_006e: ldarg.0
    IL_006f: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0074: ldloc.2
    IL_0075: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007a: ldloc.0
    IL_007b: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0080: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0085: ldarg.0
    IL_0086: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_008b: ldarg.0
    IL_008c: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0091: ldarg.0
    IL_0092: ldfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_0097: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_009c: ldarg.0
    IL_009d: ldloc.0
    IL_009e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_00a3: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_00a8: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_00ad: ldarg.0
    IL_00ae: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_00b3: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00b8: ldarg.0
    IL_00b9: ldc.i4.1
    IL_00ba: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_00bf: ldloc.1
    IL_00c0: ldc.i4.0
    IL_00c1: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c6: ldarg.0
    IL_00c7: ldfld Queue<GameObject> AutoAttackDrone::dronePool  /*0x04000550*/
    IL_00cc: ldloc.1
    IL_00cd: callvirt void System.Collections.Generic.Queue<UnityEngine.GameObject>::Enqueue(!0)  /*0x0A0001BC*/
    IL_00d2: br.s IL_00e7
    IL_00d4: ldarg.0
    IL_00d5: ldarg.0
    IL_00d6: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00db: ldarg.0
    IL_00dc: ldfld float AutoAttack::recheckTargetInterval  /*0x04000301*/
    IL_00e1: add
    IL_00e2: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_00e7: ldarg.0
    IL_00e8: call void AutoAttackDrone::ConstructDrone()  /*0x06000424*/
    IL_00ed: ldarg.0
    IL_00ee: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00f3: call void AutoAttackDrone::UpdateOrbitState(float)  /*0x0600041F*/
    IL_00f8: ldarg.0
    IL_00f9: call void AutoAttackDrone::UpdateDronePositionsAndAngles()  /*0x06000421*/
    IL_00fe: ret

  .method AutoAttackDrone::GetDroneGameObject()  // token 0x06000428 rva 0x12088 attrs Private, HideBySig
    // code size 93 (0x5d), max stack 4, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Queue<GameObject> AutoAttackDrone::dronePool  /*0x04000550*/
    IL_0006: callvirt int System.Collections.Generic.Queue<UnityEngine.GameObject>::get_Count()  /*0x0A0001C8*/
    IL_000b: ldc.i4.0
    IL_000c: ble.s IL_0041
    IL_000e: ldarg.0
    IL_000f: ldfld Queue<GameObject> AutoAttackDrone::dronePool  /*0x04000550*/
    IL_0014: callvirt !0 System.Collections.Generic.Queue<UnityEngine.GameObject>::Dequeue()  /*0x0A0001C9*/
    IL_0019: dup
    IL_001a: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_001f: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0024: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0029: dup
    IL_002a: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_002f: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0034: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0039: dup
    IL_003a: ldc.i4.1
    IL_003b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0040: ret
    IL_0041: ldarg.0
    IL_0042: ldfld GameObject AutoAttackDrone::dronePrefab  /*0x04000555*/
    IL_0047: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_004c: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_0051: ldarg.0
    IL_0052: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0057: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion,UnityEngine.Transform)<UnityEngine.GameObject>  /*0x2B00000C*/
    IL_005c: ret

  .method AutoAttackDrone::OnDuskEarly()  // token 0x06000429 rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoAttackDrone::OnDusk()  // token 0x0600042A rva 0x120f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttackDrone::ConstructAllDronesImmediately()  /*0x06000425*/
    IL_0006: ret

  .method AutoAttackDrone::OnDawn_AfterSunrise()  // token 0x0600042B rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoAttackDrone::OnDawn_BeforeSunrise()  // token 0x0600042C rva 0x25f1 attrs Public, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method AutoAttackDrone::.ctor()  // token 0x0600042D rva 0x120fc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 69 (0x45), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldc.i4.5
    IL_0002: stfld int AutoAttackDrone::droneMaxCount  /*0x0400054A*/
    IL_0007: ldarg.0
    IL_0008: ldc.r4 2f
    IL_000d: stfld float AutoAttackDrone::droneConstructionTime  /*0x0400054B*/
    IL_0012: ldarg.0
    IL_0013: ldc.r4 2f
    IL_0018: stfld float AutoAttackDrone::droneOrbitRadius  /*0x0400054C*/
    IL_001d: ldarg.0
    IL_001e: ldc.r4 90f
    IL_0023: stfld float AutoAttackDrone::droneOrbitAngularSpeedDeg  /*0x0400054D*/
    IL_0028: ldarg.0
    IL_0029: newobj void System.Collections.Generic.List<UnityEngine.GameObject>::.ctor()  /*0x0A000133*/
    IL_002e: stfld List<GameObject> AutoAttackDrone::drones  /*0x0400054F*/
    IL_0033: ldarg.0
    IL_0034: newobj void System.Collections.Generic.Queue<UnityEngine.GameObject>::.ctor()  /*0x0A0001CA*/
    IL_0039: stfld Queue<GameObject> AutoAttackDrone::dronePool  /*0x04000550*/
    IL_003e: ldarg.0
    IL_003f: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0044: ret

