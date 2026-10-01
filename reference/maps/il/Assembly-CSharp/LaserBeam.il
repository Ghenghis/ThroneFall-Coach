// ===== LaserBeam  (token 0x02000101) =====
  .method LaserBeam::DrawFirstPart(UnityEngine.Vector3,UnityEngine.Vector3)  // token 0x0600054E rva 0x171c3 attrs Public, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LineRenderer LaserBeam::_lineRenderer  /*0x040006E1*/
    IL_0006: ldc.i4.2
    IL_0007: callvirt void UnityEngine.LineRenderer::set_positionCount(int)  /*0x0A000232*/
    IL_000c: ldarg.0
    IL_000d: ldfld LineRenderer LaserBeam::_lineRenderer  /*0x040006E1*/
    IL_0012: ldc.i4.0
    IL_0013: ldarg.1
    IL_0014: callvirt void UnityEngine.LineRenderer::SetPosition(int,UnityEngine.Vector3)  /*0x0A000233*/
    IL_0019: ldarg.0
    IL_001a: ldfld LineRenderer LaserBeam::_lineRenderer  /*0x040006E1*/
    IL_001f: ldc.i4.1
    IL_0020: ldarg.2
    IL_0021: callvirt void UnityEngine.LineRenderer::SetPosition(int,UnityEngine.Vector3)  /*0x0A000233*/
    IL_0026: ldarg.0
    IL_0027: ldarg.0
    IL_0028: ldfld float LaserBeam::_laserDuration  /*0x040006E2*/
    IL_002d: stfld float LaserBeam::_laserTimer  /*0x040006E3*/
    IL_0032: ret

  .method LaserBeam::DrawSecondPart(UnityEngine.Vector3)  // token 0x0600054F rva 0x171f7 attrs Public, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld LineRenderer LaserBeam::_lineRenderer  /*0x040006E1*/
    IL_0006: ldc.i4.3
    IL_0007: callvirt void UnityEngine.LineRenderer::set_positionCount(int)  /*0x0A000232*/
    IL_000c: ldarg.0
    IL_000d: ldfld LineRenderer LaserBeam::_lineRenderer  /*0x040006E1*/
    IL_0012: ldc.i4.2
    IL_0013: ldarg.1
    IL_0014: callvirt void UnityEngine.LineRenderer::SetPosition(int,UnityEngine.Vector3)  /*0x0A000233*/
    IL_0019: ret

  .method LaserBeam::Update()  // token 0x06000550 rva 0x17212 attrs Family, HideBySig
    // code size 45 (0x2d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld float LaserBeam::_laserTimer  /*0x040006E3*/
    IL_0006: ldc.r4 0f
    IL_000b: ble.un.s IL_0020
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float LaserBeam::_laserTimer  /*0x040006E3*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: sub
    IL_001a: stfld float LaserBeam::_laserTimer  /*0x040006E3*/
    IL_001f: ret
    IL_0020: ldarg.0
    IL_0021: ldfld LineRenderer LaserBeam::_lineRenderer  /*0x040006E1*/
    IL_0026: ldc.i4.0
    IL_0027: callvirt void UnityEngine.LineRenderer::set_positionCount(int)  /*0x0A000232*/
    IL_002c: ret

  .method LaserBeam::.ctor()  // token 0x06000551 rva 0x17240 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 1f
    IL_0006: stfld float LaserBeam::_laserDuration  /*0x040006E2*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

