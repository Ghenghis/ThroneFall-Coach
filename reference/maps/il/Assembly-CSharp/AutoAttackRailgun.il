// ===== AutoAttackRailgun  (token 0x020000CE) =====
  .method AutoAttackRailgun::Start()  // token 0x0600044D rva 0x12f04 attrs Public, Virtual, HideBySig
    // code size 170 (0xaa), max stack 3, init locals
    .locals ([0] Vector3, [1] LaserBeam, [2] RailgunBeam.Config)
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000c: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0011: ldarg.0
    IL_0012: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_0017: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_001c: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_0021: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0026: stloc.0
    IL_0027: ldarg.0
    IL_0028: ldfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_002d: ldnull
    IL_002e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0033: brfalse.s IL_0041
    IL_0035: ldarg.0
    IL_0036: ldfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_003b: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0040: stloc.0
    IL_0041: ldarg.0
    IL_0042: call !!0 UnityEngine.Component::GetComponent()<LaserBeam>  /*0x2B000036*/
    IL_0047: stloc.1
    IL_0048: newobj void RailgunBeam.Config::.ctor()  /*0x060005D8*/
    IL_004d: dup
    IL_004e: ldloc.0
    IL_004f: stfld Vector3 RailgunBeam.Config::origin  /*0x0400073F*/
    IL_0054: dup
    IL_0055: ldarg.0
    IL_0056: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_005b: stfld List<TargetPriority> RailgunBeam.Config::targetPriorities  /*0x04000740*/
    IL_0060: dup
    IL_0061: ldarg.0
    IL_0062: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0067: ldfld float Weapon::shootWithoutTargetRange  /*0x04001821*/
    IL_006c: stfld float RailgunBeam.Config::range  /*0x04000741*/
    IL_0071: dup
    IL_0072: ldarg.0
    IL_0073: ldfld float AutoAttackRailgun::_decayCoeff  /*0x04000576*/
    IL_0078: stfld float RailgunBeam.Config::demageDecayCoeff  /*0x04000742*/
    IL_007d: dup
    IL_007e: ldarg.0
    IL_007f: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0084: stfld Weapon RailgunBeam.Config::weapon  /*0x04000743*/
    IL_0089: dup
    IL_008a: ldarg.0
    IL_008b: ldfld TaggedObject AutoAttackRailgun::_attaker  /*0x04000577*/
    IL_0090: stfld TaggedObject RailgunBeam.Config::attacker  /*0x04000744*/
    IL_0095: dup
    IL_0096: ldloc.1
    IL_0097: stfld LaserBeam RailgunBeam.Config::laserBeam  /*0x04000745*/
    IL_009c: stloc.2
    IL_009d: ldarg.0
    IL_009e: ldloc.2
    IL_009f: newobj void RailgunBeam::.ctor(RailgunBeam.Config)  /*0x060005D1*/
    IL_00a4: stfld RailgunBeam AutoAttackRailgun::_beam  /*0x04000578*/
    IL_00a9: ret

  .method AutoAttackRailgun::OnAttack(TaggedObject)  // token 0x0600044E rva 0x12fbc attrs Public, Virtual, HideBySig
    // code size 56 (0x38), max stack 2, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.1
    IL_0001: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: stloc.0
    IL_000c: ldarg.0
    IL_000d: ldfld RailgunBeam AutoAttackRailgun::_beam  /*0x04000578*/
    IL_0012: ldloc.0
    IL_0013: callvirt void RailgunBeam::Fire(UnityEngine.Vector3)  /*0x060005D3*/
    IL_0018: ldarg.0
    IL_0019: ldloc.0
    IL_001a: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_001f: ldarg.0
    IL_0020: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0025: dup
    IL_0026: brtrue.s IL_002b
    IL_0028: pop
    IL_0029: br.s IL_0030
    IL_002b: call void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0030: ldarg.0
    IL_0031: ldc.i4.1
    IL_0032: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_0037: ret

  .method AutoAttackRailgun::.ctor()  // token 0x0600044F rva 0x13000 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttackTower::.ctor()  /*0x06000246*/
    IL_0006: ret

