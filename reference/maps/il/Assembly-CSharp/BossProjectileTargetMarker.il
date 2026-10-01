// ===== BossProjectileTargetMarker  (token 0x02000020) =====
  .method BossProjectileTargetMarker::Update()  // token 0x060000B8 rva 0x51ed attrs Private, HideBySig
    // code size 54 (0x36), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Transform BossProjectileTargetMarker::targetMarker  /*0x040000DA*/
    IL_0006: ldarg.0
    IL_0007: ldfld AimbotProjectile BossProjectileTargetMarker::projectile  /*0x040000D9*/
    IL_000c: ldfld Vector3 AimbotProjectile::rememberTarget  /*0x04000081*/
    IL_0011: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_0016: ldarg.0
    IL_0017: ldfld Transform BossProjectileTargetMarker::targetMarker  /*0x040000DA*/
    IL_001c: ldc.r4 -90f
    IL_0021: ldc.r4 0f
    IL_0026: ldc.r4 0f
    IL_002b: call Quaternion UnityEngine.Quaternion::Euler(float,float,float)  /*0x0A00007E*/
    IL_0030: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_0035: ret

  .method BossProjectileTargetMarker::.ctor()  // token 0x060000B9 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

