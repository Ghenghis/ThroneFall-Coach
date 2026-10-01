// ===== BuildingDestructionHandler  (token 0x02000084) =====
  .method BuildingDestructionHandler::Awake()  // token 0x0600029C rva 0xbaed attrs Private, HideBySig
    // code size 35 (0x23), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld ParticleSystem BuildingDestructionHandler::debrisParticles  /*0x04000373*/
    IL_0007: callvirt ParticleSystem.ShapeModule UnityEngine.ParticleSystem::get_shape()  /*0x0A0000E9*/
    IL_000c: stfld ParticleSystem.ShapeModule BuildingDestructionHandler::debrisShape  /*0x04000377*/
    IL_0011: ldarg.0
    IL_0012: ldarg.0
    IL_0013: ldfld ParticleSystem BuildingDestructionHandler::smokeParticles  /*0x04000374*/
    IL_0018: callvirt ParticleSystem.ShapeModule UnityEngine.ParticleSystem::get_shape()  /*0x0A0000E9*/
    IL_001d: stfld ParticleSystem.ShapeModule BuildingDestructionHandler::smokeShape  /*0x04000378*/
    IL_0022: ret

  .method BuildingDestructionHandler::OnEnable()  // token 0x0600029D rva 0xbb14 attrs Private, HideBySig
    // code size 352 (0x160), max stack 4, init locals
    .locals ([0] Bounds)
    IL_0000: ldarg.0
    IL_0001: ldfld bool BuildingDestructionHandler::shakeCamera  /*0x04000371*/
    IL_0006: brfalse.s IL_001e
    IL_0008: ldsfld CameraController CameraController::instance  /*0x040003D2*/
    IL_000d: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_0012: brfalse.s IL_001e
    IL_0014: ldsfld CameraController CameraController::instance  /*0x040003D2*/
    IL_0019: callvirt void CameraController::ShakePunch()  /*0x06000321*/
    IL_001e: ldarg.0
    IL_001f: ldfld ParticleSystem BuildingDestructionHandler::debrisParticles  /*0x04000373*/
    IL_0024: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0029: ldarg.0
    IL_002a: ldfld MeshRenderer BuildingDestructionHandler::mainMesh  /*0x04000372*/
    IL_002f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0034: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0039: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_003e: ldarg.0
    IL_003f: ldfld ParticleSystem BuildingDestructionHandler::debrisParticles  /*0x04000373*/
    IL_0044: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0049: ldarg.0
    IL_004a: ldfld MeshRenderer BuildingDestructionHandler::mainMesh  /*0x04000372*/
    IL_004f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0054: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0059: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_005e: ldarg.0
    IL_005f: ldfld ParticleSystem BuildingDestructionHandler::smokeParticles  /*0x04000374*/
    IL_0064: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0069: ldarg.0
    IL_006a: ldfld MeshRenderer BuildingDestructionHandler::mainMesh  /*0x04000372*/
    IL_006f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0074: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0079: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_007e: ldarg.0
    IL_007f: ldfld ParticleSystem BuildingDestructionHandler::smokeParticles  /*0x04000374*/
    IL_0084: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0089: ldarg.0
    IL_008a: ldfld MeshRenderer BuildingDestructionHandler::mainMesh  /*0x04000372*/
    IL_008f: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0094: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_0099: callvirt void UnityEngine.Transform::set_rotation(UnityEngine.Quaternion)  /*0x0A000071*/
    IL_009e: ldarg.0
    IL_009f: ldflda ParticleSystem.ShapeModule BuildingDestructionHandler::debrisShape  /*0x04000377*/
    IL_00a4: ldarg.0
    IL_00a5: ldfld MeshRenderer BuildingDestructionHandler::mainMesh  /*0x04000372*/
    IL_00aa: callvirt Bounds UnityEngine.Renderer::get_localBounds()  /*0x0A00010C*/
    IL_00af: stloc.0
    IL_00b0: ldloca.s 0
    IL_00b2: call Vector3 UnityEngine.Bounds::get_size()  /*0x0A00010D*/
    IL_00b7: call void UnityEngine.ParticleSystem.ShapeModule::set_scale(UnityEngine.Vector3)  /*0x0A00010E*/
    IL_00bc: ldarg.0
    IL_00bd: ldflda ParticleSystem.ShapeModule BuildingDestructionHandler::debrisShape  /*0x04000377*/
    IL_00c2: ldarg.0
    IL_00c3: ldfld MeshRenderer BuildingDestructionHandler::mainMesh  /*0x04000372*/
    IL_00c8: callvirt Bounds UnityEngine.Renderer::get_localBounds()  /*0x0A00010C*/
    IL_00cd: stloc.0
    IL_00ce: ldloca.s 0
    IL_00d0: call Vector3 UnityEngine.Bounds::get_center()  /*0x0A00010F*/
    IL_00d5: call void UnityEngine.ParticleSystem.ShapeModule::set_position(UnityEngine.Vector3)  /*0x0A000110*/
    IL_00da: ldarg.0
    IL_00db: ldflda ParticleSystem.ShapeModule BuildingDestructionHandler::smokeShape  /*0x04000378*/
    IL_00e0: ldarg.0
    IL_00e1: ldfld MeshRenderer BuildingDestructionHandler::mainMesh  /*0x04000372*/
    IL_00e6: callvirt Bounds UnityEngine.Renderer::get_localBounds()  /*0x0A00010C*/
    IL_00eb: stloc.0
    IL_00ec: ldloca.s 0
    IL_00ee: call Vector3 UnityEngine.Bounds::get_size()  /*0x0A00010D*/
    IL_00f3: call void UnityEngine.ParticleSystem.ShapeModule::set_scale(UnityEngine.Vector3)  /*0x0A00010E*/
    IL_00f8: ldarg.0
    IL_00f9: ldflda ParticleSystem.ShapeModule BuildingDestructionHandler::smokeShape  /*0x04000378*/
    IL_00fe: ldarg.0
    IL_00ff: ldfld MeshRenderer BuildingDestructionHandler::mainMesh  /*0x04000372*/
    IL_0104: callvirt Bounds UnityEngine.Renderer::get_localBounds()  /*0x0A00010C*/
    IL_0109: stloc.0
    IL_010a: ldloca.s 0
    IL_010c: call Vector3 UnityEngine.Bounds::get_center()  /*0x0A00010F*/
    IL_0111: call void UnityEngine.ParticleSystem.ShapeModule::set_position(UnityEngine.Vector3)  /*0x0A000110*/
    IL_0116: ldarg.0
    IL_0117: ldc.r4 0f
    IL_011c: stfld float BuildingDestructionHandler::debrisClock  /*0x0400037A*/
    IL_0121: ldarg.0
    IL_0122: ldfld ParticleSystem BuildingDestructionHandler::debrisParticles  /*0x04000373*/
    IL_0127: callvirt void UnityEngine.ParticleSystem::Play()  /*0x0A0000EC*/
    IL_012c: ldarg.0
    IL_012d: ldfld AudioSource BuildingDestructionHandler::destructionSource  /*0x04000375*/
    IL_0132: ldc.r4 1f
    IL_0137: ldarg.0
    IL_0138: ldfld float BuildingDestructionHandler::destructionPitchRange  /*0x04000376*/
    IL_013d: sub
    IL_013e: ldc.r4 1f
    IL_0143: ldarg.0
    IL_0144: ldfld float BuildingDestructionHandler::destructionPitchRange  /*0x04000376*/
    IL_0149: add
    IL_014a: call float UnityEngine.Random::Range(float,float)  /*0x0A000097*/
    IL_014f: callvirt void UnityEngine.AudioSource::set_pitch(float)  /*0x0A00001B*/
    IL_0154: ldarg.0
    IL_0155: ldfld AudioSource BuildingDestructionHandler::destructionSource  /*0x04000375*/
    IL_015a: callvirt void UnityEngine.AudioSource::Play()  /*0x0A00001D*/
    IL_015f: ret

  .method BuildingDestructionHandler::Update()  // token 0x0600029E rva 0xbc80 attrs Private, HideBySig
    // code size 57 (0x39), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld ParticleSystem BuildingDestructionHandler::debrisParticles  /*0x04000373*/
    IL_0006: callvirt bool UnityEngine.ParticleSystem::get_isPlaying()  /*0x0A000111*/
    IL_000b: brfalse.s IL_0038
    IL_000d: ldarg.0
    IL_000e: ldarg.0
    IL_000f: ldfld float BuildingDestructionHandler::debrisClock  /*0x0400037A*/
    IL_0014: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0019: add
    IL_001a: stfld float BuildingDestructionHandler::debrisClock  /*0x0400037A*/
    IL_001f: ldarg.0
    IL_0020: ldfld float BuildingDestructionHandler::debrisClock  /*0x0400037A*/
    IL_0025: ldarg.0
    IL_0026: ldfld float BuildingDestructionHandler::debrisPlaytime  /*0x04000379*/
    IL_002b: blt.un.s IL_0038
    IL_002d: ldarg.0
    IL_002e: ldfld ParticleSystem BuildingDestructionHandler::debrisParticles  /*0x04000373*/
    IL_0033: callvirt void UnityEngine.ParticleSystem::Pause()  /*0x0A000112*/
    IL_0038: ret

  .method BuildingDestructionHandler::.ctor()  // token 0x0600029F rva 0xbcba attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.2f
    IL_0006: stfld float BuildingDestructionHandler::destructionPitchRange  /*0x04000376*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 5f
    IL_0011: stfld float BuildingDestructionHandler::debrisPlaytime  /*0x04000379*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

