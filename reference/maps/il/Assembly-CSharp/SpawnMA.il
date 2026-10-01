// ===== SpawnMA  (token 0x020001EC) =====
  .method SpawnMA::Attack()  // token 0x06000A2A rva 0x301b4 attrs Public, Virtual, HideBySig
    // code size 67 (0x43), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldfld bool SpawnMA::enableBaseAttack  /*0x04000CF5*/
    IL_0006: brfalse.s IL_000e
    IL_0008: ldarg.0
    IL_0009: call void ManualAttack::Attack()  /*0x06000A07*/
    IL_000e: ldarg.0
    IL_000f: ldfld GameObject SpawnMA::spawnHere  /*0x04000CF4*/
    IL_0014: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0019: brfalse.s IL_0042
    IL_001b: ldarg.0
    IL_001c: ldfld GameObject SpawnMA::spawnHere  /*0x04000CF4*/
    IL_0021: ldarg.0
    IL_0022: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0027: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_002c: ldarg.0
    IL_002d: ldfld GameObject SpawnMA::spawnHere  /*0x04000CF4*/
    IL_0032: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0037: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_003c: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Vector3,UnityEngine.Quaternion)<UnityEngine.GameObject>  /*0x2B00000A*/
    IL_0041: pop
    IL_0042: ret

  .method SpawnMA::.ctor()  // token 0x06000A2B rva 0x2fda0 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void ManualAttack::.ctor()  /*0x06000A0A*/
    IL_0006: ret

