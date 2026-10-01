// ===== FinalBossSpellThrower  (token 0x02000165) =====
  .method FinalBossSpellThrower::OnAttack(TaggedObject)  // token 0x0600074B rva 0x24b00 attrs Public, Virtual, HideBySig
    // code size 143 (0x8f), max stack 7, init locals
    .locals ([0] Vector3)
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.0
    IL_000c: ldfld float AutoAttack::spawnAttackHeight  /*0x04000304*/
    IL_0011: call Vector3 UnityEngine.Vector3::get_up()  /*0x0A000067*/
    IL_0016: call Vector3 UnityEngine.Vector3::op_Multiply(float,UnityEngine.Vector3)  /*0x0A000068*/
    IL_001b: call Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000069*/
    IL_0020: stloc.0
    IL_0021: ldarg.0
    IL_0022: ldfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0027: ldnull
    IL_0028: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_002d: brfalse.s IL_003b
    IL_002f: ldarg.0
    IL_0030: ldfld Transform AutoAttack::optionalAttackOrigin  /*0x04000308*/
    IL_0035: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_003a: stloc.0
    IL_003b: ldarg.0
    IL_003c: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0041: ldloc.0
    IL_0042: ldnull
    IL_0043: ldarg.1
    IL_0044: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0049: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_004e: ldloc.0
    IL_004f: call Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000062*/
    IL_0054: ldarg.0
    IL_0055: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_005a: ldarg.0
    IL_005b: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_0060: ldarg.0
    IL_0061: ldfld float AutoAttack::projectileSpeedMultiplyer  /*0x0400030A*/
    IL_0066: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_006b: ldarg.0
    IL_006c: ldarg.1
    IL_006d: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0072: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0077: stfld Vector3 AutoAttack::lastTargetPosition  /*0x0400030C*/
    IL_007c: ldarg.0
    IL_007d: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_0082: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0087: ldarg.0
    IL_0088: ldc.i4.1
    IL_0089: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_008e: ret

  .method FinalBossSpellThrower::.ctor()  // token 0x0600074C rva 0xa042 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0006: ret

