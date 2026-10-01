// ===== GiveRandomPhysicsImpulseOnEnable  (token 0x02000026) =====
  .method GiveRandomPhysicsImpulseOnEnable::Start()  // token 0x060000CC rva 0x55d4 attrs Private, HideBySig
    // code size 128 (0x80), max stack 4, init locals
    .locals ([0] Vector3, [1] Vector3, [2] Vector3)
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.Rigidbody>  /*0x2B00000F*/
    IL_0006: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_000b: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0010: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0015: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_001a: stloc.2
    IL_001b: ldloca.s 2
    IL_001d: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_0022: stloc.0
    IL_0023: ldloc.0
    IL_0024: ldarg.0
    IL_0025: ldfld float GiveRandomPhysicsImpulseOnEnable::velRange  /*0x040000F7*/
    IL_002a: neg
    IL_002b: ldarg.0
    IL_002c: ldfld float GiveRandomPhysicsImpulseOnEnable::velRange  /*0x040000F7*/
    IL_0031: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0036: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_003b: stloc.0
    IL_003c: dup
    IL_003d: ldloc.0
    IL_003e: callvirt void UnityEngine.Rigidbody::set_velocity(UnityEngine.Vector3)  /*0x0A000098*/
    IL_0043: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0048: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_004d: call float UnityEngine.Random::get_value()  /*0x0A00007C*/
    IL_0052: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0057: stloc.2
    IL_0058: ldloca.s 2
    IL_005a: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_005f: stloc.1
    IL_0060: ldloc.1
    IL_0061: ldarg.0
    IL_0062: ldfld float GiveRandomPhysicsImpulseOnEnable::angVelRange  /*0x040000F8*/
    IL_0067: neg
    IL_0068: ldarg.0
    IL_0069: ldfld float GiveRandomPhysicsImpulseOnEnable::angVelRange  /*0x040000F8*/
    IL_006e: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_0073: call Vector3 UnityEngine.Vector3::op_Multiply(UnityEngine.Vector3,float)  /*0x0A00006D*/
    IL_0078: stloc.1
    IL_0079: ldloc.1
    IL_007a: callvirt void UnityEngine.Rigidbody::set_angularVelocity(UnityEngine.Vector3)  /*0x0A000099*/
    IL_007f: ret

  .method GiveRandomPhysicsImpulseOnEnable::.ctor()  // token 0x060000CD rva 0x5660 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 10f
    IL_0006: stfld float GiveRandomPhysicsImpulseOnEnable::velRange  /*0x040000F7*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 90f
    IL_0011: stfld float GiveRandomPhysicsImpulseOnEnable::angVelRange  /*0x040000F8*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

