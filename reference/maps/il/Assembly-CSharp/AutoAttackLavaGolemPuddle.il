// ===== AutoAttackLavaGolemPuddle  (token 0x020000DD) =====
  .method AutoAttackLavaGolemPuddle::Update()  // token 0x060004A6 rva 0x14808 attrs Public, Virtual, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Update()  /*0x06000234*/
    IL_0006: ldarg.0
    IL_0007: ldarg.0
    IL_0008: ldfld float AutoAttackLavaGolemPuddle::checkTimer  /*0x040005F8*/
    IL_000d: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0012: add
    IL_0013: stfld float AutoAttackLavaGolemPuddle::checkTimer  /*0x040005F8*/
    IL_0018: ret

  .method AutoAttackLavaGolemPuddle::OnAttack(TaggedObject)  // token 0x060004A7 rva 0x14824 attrs Public, Virtual, HideBySig
    // code size 133 (0x85), max stack 2, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld MovementChecker AutoAttackLavaGolemPuddle::movementChecker  /*0x040005F6*/
    IL_0006: ldnull
    IL_0007: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000c: brfalse.s IL_0019
    IL_000e: ldstr "Provide MovementChecker reference."
    IL_0013: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0018: ret
    IL_0019: ldarg.0
    IL_001a: ldfld Vector3 AutoAttackLavaGolemPuddle::lastPuddlePosition  /*0x040005F7*/
    IL_001f: ldarg.0
    IL_0020: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0025: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002a: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_002f: ldarg.0
    IL_0030: ldfld float AutoAttackLavaGolemPuddle::minPuddleDistance  /*0x040005F5*/
    IL_0035: bgt.un.s IL_0045
    IL_0037: ldarg.0
    IL_0038: ldfld MovementChecker AutoAttackLavaGolemPuddle::movementChecker  /*0x040005F6*/
    IL_003d: callvirt bool MovementChecker::get_IsMoving()  /*0x060004A1*/
    IL_0042: brfalse.s IL_0045
    IL_0044: ret
    IL_0045: ldarg.0
    IL_0046: ldfld MovementChecker AutoAttackLavaGolemPuddle::movementChecker  /*0x040005F6*/
    IL_004b: callvirt bool MovementChecker::get_IsMoving()  /*0x060004A1*/
    IL_0050: brtrue.s IL_0061
    IL_0052: ldarg.0
    IL_0053: ldfld float AutoAttackLavaGolemPuddle::checkTimer  /*0x040005F8*/
    IL_0058: ldarg.0
    IL_0059: ldfld float AutoAttackLavaGolemPuddle::puddleLifeTime  /*0x040005F4*/
    IL_005e: bgt.un.s IL_0061
    IL_0060: ret
    IL_0061: ldarg.0
    IL_0062: ldarg.1
    IL_0063: call void AutoAttack::OnAttack(TaggedObject)  /*0x06000235*/
    IL_0068: ldarg.0
    IL_0069: ldarg.0
    IL_006a: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_006f: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0074: stfld Vector3 AutoAttackLavaGolemPuddle::lastPuddlePosition  /*0x040005F7*/
    IL_0079: ldarg.0
    IL_007a: ldc.r4 0f
    IL_007f: stfld float AutoAttackLavaGolemPuddle::checkTimer  /*0x040005F8*/
    IL_0084: ret

  .method AutoAttackLavaGolemPuddle::.ctor()  // token 0x060004A8 rva 0x148b5 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 55 (0x37), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 5f
    IL_0006: stfld float AutoAttackLavaGolemPuddle::puddleLifeTime  /*0x040005F4*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 10f
    IL_0011: stfld float AutoAttackLavaGolemPuddle::minPuddleDistance  /*0x040005F5*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1000f
    IL_001c: ldc.r4 1000f
    IL_0021: ldc.r4 1000f
    IL_0026: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_002b: stfld Vector3 AutoAttackLavaGolemPuddle::lastPuddlePosition  /*0x040005F7*/
    IL_0030: ldarg.0
    IL_0031: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0036: ret

