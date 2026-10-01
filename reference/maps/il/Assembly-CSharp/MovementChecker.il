// ===== MovementChecker  (token 0x020000DC) =====
  .method MovementChecker::get_IsMoving()  // token 0x060004A1 rva 0x1476d attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool MovementChecker::<IsMoving>k__BackingField  /*0x040005F1*/
    IL_0006: ret

  .method MovementChecker::set_IsMoving(bool)  // token 0x060004A2 rva 0x14775 attrs Private, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld bool MovementChecker::<IsMoving>k__BackingField  /*0x040005F1*/
    IL_0007: ret

  .method MovementChecker::Update()  // token 0x060004A3 rva 0x1477e attrs Private, HideBySig
    // code size 22 (0x16), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovementEnemy MovementChecker::movement  /*0x040005F0*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_000f
    IL_000e: ret
    IL_000f: ldarg.0
    IL_0010: call void MovementChecker::CheckMoving()  /*0x060004A4*/
    IL_0015: ret

  .method MovementChecker::CheckMoving()  // token 0x060004A4 rva 0x14798 attrs Private, HideBySig
    // code size 81 (0x51), max stack 3, init locals
    .locals ([0] Vector3, [1] Vector3, [2] float)
    IL_0000: ldarg.0
    IL_0001: ldfld PathfindMovementEnemy MovementChecker::movement  /*0x040005F0*/
    IL_0006: callvirt RVOController PathfindMovement::get_RVO()  /*0x06000B0A*/
    IL_000b: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0010: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0015: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_001a: stloc.0
    IL_001b: ldloc.0
    IL_001c: ldarg.0
    IL_001d: ldfld Vector3 MovementChecker::lastPosition  /*0x040005F2*/
    IL_0022: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0027: call float TimeUtils::get_InverseDeltaTime()  /*0x060013C2*/
    IL_002c: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0031: stloc.1
    IL_0032: ldloca.s 1
    IL_0034: call float UnityEngine.Vector3::get_sqrMagnitude()  /*0x0A0000B0*/
    IL_0039: stloc.2
    IL_003a: ldarg.0
    IL_003b: ldloc.0
    IL_003c: stfld Vector3 MovementChecker::lastPosition  /*0x040005F2*/
    IL_0041: ldarg.0
    IL_0042: ldloc.2
    IL_0043: ldarg.0
    IL_0044: ldfld float MovementChecker::minSqVelocity  /*0x040005F3*/
    IL_0049: cgt
    IL_004b: call void MovementChecker::set_IsMoving(bool)  /*0x060004A2*/
    IL_0050: ret

  .method MovementChecker::.ctor()  // token 0x060004A5 rva 0x147f5 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1.5f
    IL_0006: stfld float MovementChecker::minSqVelocity  /*0x040005F3*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

