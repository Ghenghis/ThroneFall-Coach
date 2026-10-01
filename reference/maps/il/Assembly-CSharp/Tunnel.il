// ===== Tunnel  (token 0x0200012C) =====
  .method Tunnel::Start()  // token 0x06000644 rva 0x1a4e4 attrs Private, HideBySig
    // code size 94 (0x5e), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call PlayerManager PlayerManager::get_Instance()  /*0x06000C14*/
    IL_0006: stfld PlayerManager Tunnel::playerManager  /*0x040007A6*/
    IL_000b: ldarg.0
    IL_000c: ldfld bool Tunnel::initialized  /*0x040007A7*/
    IL_0011: brtrue.s IL_0019
    IL_0013: ldarg.0
    IL_0014: call void Tunnel::Initialize()  /*0x0600064A*/
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld float Tunnel::playerEnterTimerMax  /*0x040007A2*/
    IL_0020: stfld float Tunnel::playerEnterTimer  /*0x040007A4*/
    IL_0025: ldarg.0
    IL_0026: ldfld BuildSlot Tunnel::buildSlot  /*0x0400079C*/
    IL_002b: ldfld UnityEvent BuildSlot::OnUpgrade  /*0x040003B0*/
    IL_0030: ldarg.0
    IL_0031: ldftn void Tunnel::OnBuildThis()  /*0x0600064B*/
    IL_0037: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_003c: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_0041: ldarg.0
    IL_0042: ldfld Hp Tunnel::hp  /*0x0400079D*/
    IL_0047: ldfld UnityEvent Hp::OnKillOrKnockout  /*0x04000A3E*/
    IL_004c: ldarg.0
    IL_004d: ldftn void Tunnel::OnDestroyThis()  /*0x0600064C*/
    IL_0053: newobj void UnityEngine.Events.UnityAction::.ctor(object,IntPtr)  /*0x0A00000F*/
    IL_0058: callvirt void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)  /*0x0A000010*/
    IL_005d: ret

  .method Tunnel::Update()  // token 0x06000645 rva 0x1a550 attrs Private, HideBySig
    // code size 409 (0x199), max stack 5, init locals
    .locals ([0] bool, [1] PlayerMovement[], [2] int, [3] PlayerMovement, [4] Vector3, [5] Matrix4x4, [6] Vector3)
    IL_0000: ldarg.0
    IL_0001: ldfld Tunnel Tunnel::pairedTunnel  /*0x0400079E*/
    IL_0006: callvirt bool Tunnel::IsBuilt()  /*0x06000649*/
    IL_000b: brfalse.s IL_001a
    IL_000d: ldarg.0
    IL_000e: ldfld Hp Tunnel::hp  /*0x0400079D*/
    IL_0013: callvirt bool Hp::get_KnockedOut()  /*0x06000815*/
    IL_0018: brfalse.s IL_001b
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: ldfld float Tunnel::cooldown  /*0x040007A5*/
    IL_0022: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0027: sub
    IL_0028: stfld float Tunnel::cooldown  /*0x040007A5*/
    IL_002d: ldarg.0
    IL_002e: ldfld BuildSlot Tunnel::buildSlot  /*0x0400079C*/
    IL_0033: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0038: ldc.i4.0
    IL_0039: ble.s IL_0048
    IL_003b: ldarg.0
    IL_003c: ldfld float Tunnel::cooldown  /*0x040007A5*/
    IL_0041: ldc.r4 0f
    IL_0046: ble.un.s IL_0049
    IL_0048: ret
    IL_0049: ldc.i4.0
    IL_004a: stloc.0
    IL_004b: ldarg.0
    IL_004c: ldfld PlayerManager Tunnel::playerManager  /*0x040007A6*/
    IL_0051: callvirt PlayerMovement[] PlayerManager::get_RegisteredPlayers()  /*0x06000C15*/
    IL_0056: stloc.1
    IL_0057: ldc.i4.0
    IL_0058: stloc.2
    IL_0059: br IL_0180
    IL_005e: ldloc.1
    IL_005f: ldloc.2
    IL_0060: ldelem.ref
    IL_0061: stloc.3
    IL_0062: ldarg.0
    IL_0063: ldfld Transform Tunnel::tunnelEntrance  /*0x0400079F*/
    IL_0068: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_006d: ldloc.3
    IL_006e: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0073: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0078: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_007d: stloc.s 4
    IL_007f: ldloca.s 4
    IL_0081: call float UnityEngine.Vector3::get_magnitude()  /*0x0A000063*/
    IL_0086: ldarg.0
    IL_0087: ldfld float Tunnel::enterDistance  /*0x040007A0*/
    IL_008c: bge.un IL_017c
    IL_0091: ldarg.0
    IL_0092: ldfld Transform Tunnel::tunnelEntrance  /*0x0400079F*/
    IL_0097: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_009c: stloc.s 5
    IL_009e: ldloca.s 5
    IL_00a0: ldc.r4 0f
    IL_00a5: ldc.r4 0f
    IL_00aa: ldc.r4 1f
    IL_00af: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00b4: call Vector3 UnityEngine.Matrix4x4::MultiplyVector(UnityEngine.Vector3)  /*0x0A0000A7*/
    IL_00b9: stloc.s 4
    IL_00bb: ldloca.s 4
    IL_00bd: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_00c2: ldloc.3
    IL_00c3: callvirt Vector3 PlayerMovement::get_Velocity()  /*0x06000C26*/
    IL_00c8: stloc.s 4
    IL_00ca: ldloca.s 4
    IL_00cc: call Vector3 UnityEngine.Vector3::get_normalized()  /*0x0A00006C*/
    IL_00d1: call float UnityEngine.Vector3::Dot(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A0001A1*/
    IL_00d6: ldarg.0
    IL_00d7: ldfld float Tunnel::enterAngleDotProd  /*0x040007A1*/
    IL_00dc: ble.un IL_017c
    IL_00e1: ldarg.0
    IL_00e2: ldarg.0
    IL_00e3: ldfld float Tunnel::playerEnterTimer  /*0x040007A4*/
    IL_00e8: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_00ed: sub
    IL_00ee: stfld float Tunnel::playerEnterTimer  /*0x040007A4*/
    IL_00f3: ldc.i4.1
    IL_00f4: stloc.0
    IL_00f5: ldarg.0
    IL_00f6: ldfld float Tunnel::playerEnterTimer  /*0x040007A4*/
    IL_00fb: ldc.r4 0f
    IL_0100: bgt.un.s IL_017c
    IL_0102: ldarg.0
    IL_0103: ldfld Tunnel Tunnel::pairedTunnel  /*0x0400079E*/
    IL_0108: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_010d: brfalse.s IL_017c
    IL_010f: ldarg.0
    IL_0110: ldfld Tunnel Tunnel::pairedTunnel  /*0x0400079E*/
    IL_0115: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_011a: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_011f: stloc.s 6
    IL_0121: ldloc.s 6
    IL_0123: ldarg.0
    IL_0124: ldfld Tunnel Tunnel::pairedTunnel  /*0x0400079E*/
    IL_0129: ldfld Transform Tunnel::tunnelEntrance  /*0x0400079F*/
    IL_012e: callvirt Matrix4x4 UnityEngine.Transform::get_localToWorldMatrix()  /*0x0A0000A6*/
    IL_0133: stloc.s 5
    IL_0135: ldloca.s 5
    IL_0137: ldc.r4 0f
    IL_013c: ldc.r4 0f
    IL_0141: ldc.r4 -1f
    IL_0146: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_014b: call Vector3 UnityEngine.Matrix4x4::MultiplyVector(UnityEngine.Vector3)  /*0x0A0000A7*/
    IL_0150: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0155: stloc.s 6
    IL_0157: ldloc.3
    IL_0158: ldloc.s 6
    IL_015a: callvirt void PlayerMovement::TeleportTo(UnityEngine.Vector3)  /*0x06000C22*/
    IL_015f: ldarg.0
    IL_0160: ldfld Tunnel Tunnel::pairedTunnel  /*0x0400079E*/
    IL_0165: ldarg.0
    IL_0166: ldfld float Tunnel::cooldownAfterTeleport  /*0x040007A3*/
    IL_016b: callvirt void Tunnel::SetCooldown(float)  /*0x06000646*/
    IL_0170: ldarg.0
    IL_0171: ldarg.0
    IL_0172: ldfld float Tunnel::cooldownAfterTeleport  /*0x040007A3*/
    IL_0177: call void Tunnel::SetCooldown(float)  /*0x06000646*/
    IL_017c: ldloc.2
    IL_017d: ldc.i4.1
    IL_017e: add
    IL_017f: stloc.2
    IL_0180: ldloc.2
    IL_0181: ldloc.1
    IL_0182: ldlen
    IL_0183: conv.i4
    IL_0184: blt IL_005e
    IL_0189: ldloc.0
    IL_018a: brtrue.s IL_0198
    IL_018c: ldarg.0
    IL_018d: ldarg.0
    IL_018e: ldfld float Tunnel::playerEnterTimerMax  /*0x040007A2*/
    IL_0193: stfld float Tunnel::playerEnterTimer  /*0x040007A4*/
    IL_0198: ret

  .method Tunnel::SetCooldown(float)  // token 0x06000646 rva 0x1a6f5 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld float Tunnel::cooldown  /*0x040007A5*/
    IL_0007: ret

  .method Tunnel::BuildMeToo()  // token 0x06000647 rva 0x1a6fe attrs Public, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Tunnel::buildSlot  /*0x0400079C*/
    IL_0006: ldsfld PlayerInteraction PlayerInteraction::instance  /*0x04000ED7*/
    IL_000b: ldc.i4.0
    IL_000c: callvirt void BuildSlot::ExecuteBuildOrUpgrade(PlayerInteraction,bool)  /*0x060002F7*/
    IL_0011: ret

  .method Tunnel::DestroyMeToo()  // token 0x06000648 rva 0x1a711 attrs Public, HideBySig
    // code size 27 (0x1b), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Hp Tunnel::hp  /*0x0400079D*/
    IL_0006: ldarg.0
    IL_0007: ldfld Hp Tunnel::hp  /*0x0400079D*/
    IL_000c: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0011: ldnull
    IL_0012: ldc.i4.0
    IL_0013: ldc.i4.1
    IL_0014: callvirt bool Hp::TakeDamage(float,TaggedObject,bool,bool)  /*0x0600082D*/
    IL_0019: pop
    IL_001a: ret

  .method Tunnel::IsBuilt()  // token 0x06000649 rva 0x1a72d attrs Public, HideBySig
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld BuildSlot Tunnel::buildSlot  /*0x0400079C*/
    IL_0006: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_000b: ldc.i4.0
    IL_000c: clt
    IL_000e: ldc.i4.0
    IL_000f: ceq
    IL_0011: ret

  .method Tunnel::Initialize()  // token 0x0600064A rva 0x1a740 attrs Private, HideBySig
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool Tunnel::initialized  /*0x040007A7*/
    IL_0006: brfalse.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.0
    IL_000b: ldfld BuildSlot Tunnel::buildSlot  /*0x0400079C*/
    IL_0010: ldnull
    IL_0011: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0016: brtrue.s IL_0020
    IL_0018: ldarg.0
    IL_0019: ldfld BuildSlot Tunnel::buildSlot  /*0x0400079C*/
    IL_001e: br.s IL_0026
    IL_0020: ldarg.0
    IL_0021: call !!0 UnityEngine.Component::GetComponent()<BuildSlot>  /*0x2B00001A*/
    IL_0026: stfld BuildSlot Tunnel::buildSlot  /*0x0400079C*/
    IL_002b: ldarg.0
    IL_002c: ldc.i4.1
    IL_002d: stfld bool Tunnel::initialized  /*0x040007A7*/
    IL_0032: ret

  .method Tunnel::OnBuildThis()  // token 0x0600064B rva 0x1a774 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Tunnel Tunnel::pairedTunnel  /*0x0400079E*/
    IL_0006: callvirt void Tunnel::BuildMeToo()  /*0x06000647*/
    IL_000b: ret

  .method Tunnel::OnDestroyThis()  // token 0x0600064C rva 0x1a781 attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Tunnel Tunnel::pairedTunnel  /*0x0400079E*/
    IL_0006: callvirt void Tunnel::DestroyMeToo()  /*0x06000648*/
    IL_000b: ret

  .method Tunnel::.ctor()  // token 0x0600064D rva 0x1a78e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 40 (0x28), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 0.8f
    IL_0006: stfld float Tunnel::enterAngleDotProd  /*0x040007A1*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 0.75f
    IL_0011: stfld float Tunnel::playerEnterTimerMax  /*0x040007A2*/
    IL_0016: ldarg.0
    IL_0017: ldc.r4 1f
    IL_001c: stfld float Tunnel::cooldownAfterTeleport  /*0x040007A3*/
    IL_0021: ldarg.0
    IL_0022: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0027: ret

