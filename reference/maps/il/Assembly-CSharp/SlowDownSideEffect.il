// ===== SlowDownSideEffect  (token 0x0200012A) =====
  .method SlowDownSideEffect::Effect(Hp,TaggedObject,TaggedObject,Weapon,float,bool,float)  // token 0x0600063A rva 0x1a317 attrs Public, Virtual, HideBySig
    // code size 44 (0x2c), max stack 8
    IL_0000: ldarg.1
    IL_0001: callvirt PathfindMovement Hp::get_PathfindMovement()  /*0x06000818*/
    IL_0006: ldarg.0
    IL_0007: ldfld float SlowDownSideEffect::_sideEffectDuration  /*0x04000794*/
    IL_000c: callvirt void PathfindMovement::Slow(float)  /*0x06000B07*/
    IL_0011: ldarg.0
    IL_0012: ldfld GameObject SlowDownSideEffect::_fxSpawnOnVictim  /*0x04000795*/
    IL_0017: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_001c: brfalse.s IL_002b
    IL_001e: ldarg.0
    IL_001f: ldarg.0
    IL_0020: ldfld GameObject SlowDownSideEffect::_fxSpawnOnVictim  /*0x04000795*/
    IL_0025: ldarg.2
    IL_0026: call void SlowDownSideEffect::SpawnEffectFx(UnityEngine.GameObject,TaggedObject)  /*0x0600063B*/
    IL_002b: ret

  .method SlowDownSideEffect::SpawnEffectFx(UnityEngine.GameObject,TaggedObject)  // token 0x0600063B rva 0x1a344 attrs Private, HideBySig
    // code size 126 (0x7e), max stack 2, init locals
    .locals ([0] Vector3, [1] Quaternion, [2] GameObject)
    IL_0000: ldarg.2
    IL_0001: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: stloc.0
    IL_000c: ldarg.2
    IL_000d: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0012: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0017: stloc.1
    IL_0018: ldloca.s 0
    IL_001a: ldc.r4 0.1f
    IL_001f: stfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0024: ldarg.0
    IL_0025: ldfld GameObject SlowDownSideEffect::_fxSpawnOnVictim  /*0x04000795*/
    IL_002a: call GameObject ObjectPools::GetPooledItemByObject(UnityEngine.GameObject)  /*0x06000E9A*/
    IL_002f: stloc.2
    IL_0030: ldloc.2
    IL_0031: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0036: brfalse.s IL_007d
    IL_0038: ldloc.2
    IL_0039: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_003e: ldloc.0
    IL_003f: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0044: ldloc.2
    IL_0045: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_004a: ldloc.1
    IL_004b: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0050: ldarg.0
    IL_0051: ldfld bool SlowDownSideEffect::_followFxVictim  /*0x04000796*/
    IL_0056: brfalse.s IL_0076
    IL_0058: ldloc.2
    IL_0059: callvirt !!0 UnityEngine.GameObject::GetComponent()<CustomPositionConstraint>  /*0x2B00004C*/
    IL_005e: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0063: brfalse.s IL_0076
    IL_0065: ldloc.2
    IL_0066: callvirt !!0 UnityEngine.GameObject::GetComponent()<CustomPositionConstraint>  /*0x2B00004C*/
    IL_006b: ldarg.2
    IL_006c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0071: stfld Transform CustomPositionConstraint::followTransform  /*0x040004A5*/
    IL_0076: ldloc.2
    IL_0077: ldc.i4.1
    IL_0078: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_007d: ret

  .method SlowDownSideEffect::.ctor()  // token 0x0600063C rva 0x1a3ce attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float SlowDownSideEffect::_sideEffectDuration  /*0x04000794*/
    IL_000b: ldarg.0
    IL_000c: call void AdditionalWeaponEffectScript::.ctor()  /*0x06000028*/
    IL_0011: ret

