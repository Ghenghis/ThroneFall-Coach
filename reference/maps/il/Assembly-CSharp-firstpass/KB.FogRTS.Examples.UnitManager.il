// ===== KB.FogRTS.Examples.UnitManager  (token 0x0200000A) =====
  .method KB.FogRTS.Examples.UnitManager::Start()  // token 0x0600001E rva 0x27b0 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Camera UnityEngine.Camera::get_main()  /*0x0A00005C*/
    IL_0006: stfld Camera KB.FogRTS.Examples.UnitManager::mainCamera  /*0x04000023*/
    IL_000b: ret

  .method KB.FogRTS.Examples.UnitManager::Update()  // token 0x0600001F rva 0x27c0 attrs Private, HideBySig
    // code size 263 (0x107), max stack 5, init locals
    .locals ([0] RaycastHit, [1] Unit)
    IL_0000: ldc.i4.0
    IL_0001: call bool UnityEngine.Input::GetMouseButtonDown(int)  /*0x0A00005D*/
    IL_0006: brfalse IL_0106
    IL_000b: ldarg.0
    IL_000c: ldfld Camera KB.FogRTS.Examples.UnitManager::mainCamera  /*0x04000023*/
    IL_0011: call Vector3 UnityEngine.Input::get_mousePosition()  /*0x0A00005E*/
    IL_0016: callvirt Ray UnityEngine.Camera::ScreenPointToRay(UnityEngine.Vector3)  /*0x0A00005F*/
    IL_001b: ldloca.s 0
    IL_001d: ldc.r4 Infinityf
    IL_0022: ldc.i4.m1
    IL_0023: ldc.i4.1
    IL_0024: call bool UnityEngine.Physics::Raycast(UnityEngine.Ray,ref UnityEngine.RaycastHit,float,int,UnityEngine.QueryTriggerInteraction)  /*0x0A000060*/
    IL_0029: brfalse IL_0106
    IL_002e: ldloca.s 0
    IL_0030: call Collider UnityEngine.RaycastHit::get_collider()  /*0x0A000061*/
    IL_0035: callvirt !!0 UnityEngine.Component::GetComponent()<KB.FogRTS.Examples.Unit>  /*0x2B000005*/
    IL_003a: stloc.1
    IL_003b: ldloc.1
    IL_003c: ldnull
    IL_003d: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00002B*/
    IL_0042: brfalse.s IL_004c
    IL_0044: ldarg.0
    IL_0045: ldloc.1
    IL_0046: call void KB.FogRTS.Examples.UnitManager::SelectNewUnit(KB.FogRTS.Examples.Unit)  /*0x06000020*/
    IL_004b: ret
    IL_004c: ldarg.0
    IL_004d: ldfld Unit KB.FogRTS.Examples.UnitManager::selectedUnit  /*0x04000024*/
    IL_0052: ldnull
    IL_0053: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00002B*/
    IL_0058: brfalse IL_0106
    IL_005d: ldloca.s 0
    IL_005f: call Collider UnityEngine.RaycastHit::get_collider()  /*0x0A000061*/
    IL_0064: callvirt !!0 UnityEngine.Component::GetComponent()<KB.FogRTS.Examples.Floor>  /*0x2B000006*/
    IL_0069: ldnull
    IL_006a: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00002B*/
    IL_006f: brfalse IL_0106
    IL_0074: ldloca.s 0
    IL_0076: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000062*/
    IL_007b: ldfld float UnityEngine.Vector3::x  /*0x0A000014*/
    IL_0080: ldarg.0
    IL_0081: ldfld float KB.FogRTS.Examples.UnitManager::xMin  /*0x0400001F*/
    IL_0086: blt.s IL_00c4
    IL_0088: ldloca.s 0
    IL_008a: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000062*/
    IL_008f: ldfld float UnityEngine.Vector3::x  /*0x0A000014*/
    IL_0094: ldarg.0
    IL_0095: ldfld float KB.FogRTS.Examples.UnitManager::xMax  /*0x04000020*/
    IL_009a: bgt.s IL_00c4
    IL_009c: ldloca.s 0
    IL_009e: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000062*/
    IL_00a3: ldfld float UnityEngine.Vector3::z  /*0x0A000016*/
    IL_00a8: ldarg.0
    IL_00a9: ldfld float KB.FogRTS.Examples.UnitManager::zMin  /*0x04000021*/
    IL_00ae: blt.s IL_00c4
    IL_00b0: ldloca.s 0
    IL_00b2: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000062*/
    IL_00b7: ldfld float UnityEngine.Vector3::z  /*0x0A000016*/
    IL_00bc: ldarg.0
    IL_00bd: ldfld float KB.FogRTS.Examples.UnitManager::zMax  /*0x04000022*/
    IL_00c2: ble.un.s IL_00c5
    IL_00c4: ret
    IL_00c5: ldarg.0
    IL_00c6: ldfld Unit KB.FogRTS.Examples.UnitManager::selectedUnit  /*0x04000024*/
    IL_00cb: ldloca.s 0
    IL_00cd: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000062*/
    IL_00d2: ldfld float UnityEngine.Vector3::x  /*0x0A000014*/
    IL_00d7: ldloca.s 0
    IL_00d9: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000062*/
    IL_00de: ldfld float UnityEngine.Vector3::y  /*0x0A000017*/
    IL_00e3: ldc.r4 1f
    IL_00e8: add
    IL_00e9: ldloca.s 0
    IL_00eb: call Vector3 UnityEngine.RaycastHit::get_point()  /*0x0A000062*/
    IL_00f0: ldfld float UnityEngine.Vector3::z  /*0x0A000016*/
    IL_00f5: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A00000D*/
    IL_00fa: callvirt void KB.FogRTS.Examples.Unit::SetTargetPosition(UnityEngine.Vector3)  /*0x0600001A*/
    IL_00ff: ldarg.0
    IL_0100: ldnull
    IL_0101: call void KB.FogRTS.Examples.UnitManager::SelectNewUnit(KB.FogRTS.Examples.Unit)  /*0x06000020*/
    IL_0106: ret

  .method KB.FogRTS.Examples.UnitManager::SelectNewUnit(KB.FogRTS.Examples.Unit)  // token 0x06000020 rva 0x28d4 attrs Private, HideBySig
    // code size 97 (0x61), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld Unit KB.FogRTS.Examples.UnitManager::selectedUnit  /*0x04000024*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00002B*/
    IL_000c: brfalse.s IL_0024
    IL_000e: ldarg.0
    IL_000f: ldfld Unit KB.FogRTS.Examples.UnitManager::selectedUnit  /*0x04000024*/
    IL_0014: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.Renderer>  /*0x2B000007*/
    IL_0019: ldarg.0
    IL_001a: ldfld Material KB.FogRTS.Examples.UnitManager::ally  /*0x0400001D*/
    IL_001f: callvirt void UnityEngine.Renderer::set_material(UnityEngine.Material)  /*0x0A000063*/
    IL_0024: ldarg.0
    IL_0025: ldarg.0
    IL_0026: ldfld Unit KB.FogRTS.Examples.UnitManager::selectedUnit  /*0x04000024*/
    IL_002b: ldarg.1
    IL_002c: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000064*/
    IL_0031: brtrue.s IL_0036
    IL_0033: ldarg.1
    IL_0034: br.s IL_0037
    IL_0036: ldnull
    IL_0037: stfld Unit KB.FogRTS.Examples.UnitManager::selectedUnit  /*0x04000024*/
    IL_003c: ldarg.0
    IL_003d: ldfld Unit KB.FogRTS.Examples.UnitManager::selectedUnit  /*0x04000024*/
    IL_0042: ldnull
    IL_0043: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A00002B*/
    IL_0048: brfalse.s IL_0060
    IL_004a: ldarg.0
    IL_004b: ldfld Unit KB.FogRTS.Examples.UnitManager::selectedUnit  /*0x04000024*/
    IL_0050: callvirt !!0 UnityEngine.Component::GetComponent()<UnityEngine.Renderer>  /*0x2B000007*/
    IL_0055: ldarg.0
    IL_0056: ldfld Material KB.FogRTS.Examples.UnitManager::selectedAlly  /*0x0400001E*/
    IL_005b: callvirt void UnityEngine.Renderer::set_material(UnityEngine.Material)  /*0x0A000063*/
    IL_0060: ret

  .method KB.FogRTS.Examples.UnitManager::.ctor()  // token 0x06000021 rva 0x2941 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 -10f
    IL_0006: stfld float KB.FogRTS.Examples.UnitManager::xMin  /*0x0400001F*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float KB.FogRTS.Examples.UnitManager::xMax  /*0x04000020*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 -10f
    IL_001c: stfld float KB.FogRTS.Examples.UnitManager::zMin  /*0x04000021*/
    IL_0021: ldarg.0
    IL_0022: ldc.r4 10f
    IL_0027: stfld float KB.FogRTS.Examples.UnitManager::zMax  /*0x04000022*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000018*/
    IL_0032: ret

