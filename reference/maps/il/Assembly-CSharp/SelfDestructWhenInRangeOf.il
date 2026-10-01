// ===== SelfDestructWhenInRangeOf  (token 0x02000269) =====
  .method SelfDestructWhenInRangeOf::Start()  // token 0x06000D55 rva 0x3d15b attrs Private, HideBySig
    // code size 25 (0x19), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: call !!0 UnityEngine.Component::GetComponent()<Hp>  /*0x2B000014*/
    IL_0007: stfld Hp SelfDestructWhenInRangeOf::hp  /*0x04000FD9*/
    IL_000c: ldarg.0
    IL_000d: ldarg.0
    IL_000e: ldfld float SelfDestructWhenInRangeOf::checkInterval  /*0x04000FD7*/
    IL_0013: stfld float SelfDestructWhenInRangeOf::timeTillNextCheck  /*0x04000FD8*/
    IL_0018: ret

  .method SelfDestructWhenInRangeOf::Update()  // token 0x06000D56 rva 0x3d178 attrs Private, HideBySig
    // code size 107 (0x6b), max stack 5, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld float SelfDestructWhenInRangeOf::timeTillNextCheck  /*0x04000FD8*/
    IL_0007: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_000c: sub
    IL_000d: stfld float SelfDestructWhenInRangeOf::timeTillNextCheck  /*0x04000FD8*/
    IL_0012: ldarg.0
    IL_0013: ldfld float SelfDestructWhenInRangeOf::timeTillNextCheck  /*0x04000FD8*/
    IL_0018: ldc.r4 0f
    IL_001d: bgt.un.s IL_006a
    IL_001f: ldarg.0
    IL_0020: ldarg.0
    IL_0021: ldfld float SelfDestructWhenInRangeOf::checkInterval  /*0x04000FD7*/
    IL_0026: stfld float SelfDestructWhenInRangeOf::timeTillNextCheck  /*0x04000FD8*/
    IL_002b: ldarg.0
    IL_002c: ldfld TargetPriority SelfDestructWhenInRangeOf::selfDestructIfInRangeOf  /*0x04000FD6*/
    IL_0031: ldarg.0
    IL_0032: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0037: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003c: callvirt TaggedObject TargetPriority::FindClosestTaggedObject(UnityEngine.Vector3)  /*0x06000E6F*/
    IL_0041: ldnull
    IL_0042: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0047: brfalse.s IL_006a
    IL_0049: ldarg.0
    IL_004a: ldfld Hp SelfDestructWhenInRangeOf::hp  /*0x04000FD9*/
    IL_004f: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0054: brfalse.s IL_006a
    IL_0056: ldarg.0
    IL_0057: ldfld Hp SelfDestructWhenInRangeOf::hp  /*0x04000FD9*/
    IL_005c: ldc.r4 1E+09f
    IL_0061: ldnull
    IL_0062: ldc.i4.0
    IL_0063: ldc.i4.1
    IL_0064: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0069: pop
    IL_006a: ret

  .method SelfDestructWhenInRangeOf::.ctor()  // token 0x06000D57 rva 0x3d1ef attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.5f
    IL_0006: stfld float SelfDestructWhenInRangeOf::checkInterval  /*0x04000FD7*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

