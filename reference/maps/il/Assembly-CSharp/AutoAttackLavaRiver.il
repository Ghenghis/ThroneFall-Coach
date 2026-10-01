// ===== AutoAttackLavaRiver  (token 0x020000CC) =====
  .method AutoAttackLavaRiver::Start()  // token 0x0600043E rva 0x12888 attrs Public, Virtual, HideBySig
    // code size 134 (0x86), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: call void AutoAttack::Start()  /*0x06000233*/
    IL_0006: ldarg.0
    IL_0007: ldfld BoxCollider AutoAttackLavaRiver::areaCollider  /*0x0400056D*/
    IL_000c: ldnull
    IL_000d: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0012: brfalse.s IL_001f
    IL_0014: ldstr "Lava river attack area collider component is missing."
    IL_0019: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: ldfld BoxCollider AutoAttackLavaRiver::areaCollider  /*0x0400056D*/
    IL_0025: ldc.i4.0
    IL_0026: callvirt void UnityEngine.Collider::set_enabled(bool)  /*0x0A0001B5*/
    IL_002b: ldarg.0
    IL_002c: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0031: callvirt int System.Collections.Generic.List<TargetPriority>::get_Count()  /*0x0A0000E4*/
    IL_0036: ldc.i4.1
    IL_0037: bne.un.s IL_0073
    IL_0039: ldarg.0
    IL_003a: ldarg.0
    IL_003b: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_0040: ldc.i4.0
    IL_0041: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0046: ldfld List<TagManager.ETag> TargetPriority::mustHaveTags  /*0x040010D0*/
    IL_004b: newobj void System.Collections.Generic.HashSet<TagManager.ETag>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0001E7*/
    IL_0050: stfld HashSet<TagManager.ETag> AutoAttackLavaRiver::mustHaveTags  /*0x04000570*/
    IL_0055: ldarg.0
    IL_0056: ldarg.0
    IL_0057: ldfld List<TargetPriority> AutoAttack::targetPriorities  /*0x04000302*/
    IL_005c: ldc.i4.0
    IL_005d: callvirt !0 System.Collections.Generic.List<TargetPriority>::get_Item(int)  /*0x0A0000E3*/
    IL_0062: ldfld List<TagManager.ETag> TargetPriority::mayNotHaveTags  /*0x040010D1*/
    IL_0067: newobj void System.Collections.Generic.HashSet<TagManager.ETag>::.ctor(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0001E7*/
    IL_006c: stfld HashSet<TagManager.ETag> AutoAttackLavaRiver::mustNotHaveTags  /*0x04000571*/
    IL_0071: br.s IL_007e
    IL_0073: ldstr "Lava river attack should have only one priority to filter units."
    IL_0078: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_007d: ret
    IL_007e: ldarg.0
    IL_007f: ldc.i4.1
    IL_0080: stfld bool AutoAttackLavaRiver::inited  /*0x04000572*/
    IL_0085: ret

  .method AutoAttackLavaRiver::RefreshTargets()  // token 0x0600043F rva 0x1291c attrs Private, HideBySig
    // code size 117 (0x75), max stack 2, init locals
    .locals ([0] HashSet.Enumerator<TaggedObject>, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoAttackLavaRiver::inited  /*0x04000572*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld List<TaggedObject> AutoAttackLavaRiver::aliveTargets  /*0x0400056F*/
    IL_000f: callvirt void System.Collections.Generic.List<TaggedObject>::Clear()  /*0x0A0000E6*/
    IL_0014: ldarg.0
    IL_0015: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_001a: callvirt HashSet.Enumerator<!0> System.Collections.Generic.HashSet<TaggedObject>::GetEnumerator()  /*0x0A0001E8*/
    IL_001f: stloc.0
    IL_0020: br.s IL_003f
    IL_0022: ldloca.s 0
    IL_0024: call !0 System.Collections.Generic.HashSet.Enumerator<TaggedObject>::get_Current()  /*0x0A0001E9*/
    IL_0029: stloc.1
    IL_002a: ldloc.1
    IL_002b: ldnull
    IL_002c: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0031: brfalse.s IL_003f
    IL_0033: ldarg.0
    IL_0034: ldfld List<TaggedObject> AutoAttackLavaRiver::aliveTargets  /*0x0400056F*/
    IL_0039: ldloc.1
    IL_003a: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_003f: ldloca.s 0
    IL_0041: call bool System.Collections.Generic.HashSet.Enumerator<TaggedObject>::MoveNext()  /*0x0A0001EA*/
    IL_0046: brtrue.s IL_0022
    IL_0048: leave.s IL_0058
    IL_004a: ldloca.s 0
    IL_004c: constrained. System.Collections.Generic.HashSet.Enumerator<TaggedObject>  /*0x1B00004A*/
    IL_0052: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0057: endfinally
    IL_0058: ldarg.0
    IL_0059: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_005e: callvirt void System.Collections.Generic.HashSet<TaggedObject>::Clear()  /*0x0A0001EB*/
    IL_0063: ldarg.0
    IL_0064: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_0069: ldarg.0
    IL_006a: ldfld List<TaggedObject> AutoAttackLavaRiver::aliveTargets  /*0x0400056F*/
    IL_006f: callvirt void System.Collections.Generic.HashSet<TaggedObject>::UnionWith(System.Collections.Generic.IEnumerable<!0>)  /*0x0A0001EC*/
    IL_0074: ret
    .try IL_0020-IL_004a finally handler IL_004a-IL_0058

  .method AutoAttackLavaRiver::Update()  // token 0x06000440 rva 0x129b0 attrs Public, Virtual, HideBySig
    // code size 204 (0xcc), max stack 7, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoAttackLavaRiver::inited  /*0x04000572*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldfld BoxCollider AutoAttackLavaRiver::areaCollider  /*0x0400056D*/
    IL_000f: callvirt bool UnityEngine.Collider::get_enabled()  /*0x0A0001ED*/
    IL_0014: brfalse IL_00cb
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0020: call float UnityEngine.Time::get_deltaTime()  /*0x0A000045*/
    IL_0025: sub
    IL_0026: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_002b: ldarg.0
    IL_002c: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0031: ldc.r4 0f
    IL_0036: bgt.un IL_00cb
    IL_003b: ldarg.0
    IL_003c: ldc.i4.0
    IL_003d: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_0042: ldarg.0
    IL_0043: ldarg.0
    IL_0044: ldfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0049: ldarg.0
    IL_004a: ldfld float AutoAttack::cooldownDuration  /*0x040002FE*/
    IL_004f: add
    IL_0050: stfld float AutoAttack::cooldown  /*0x04000306*/
    IL_0055: ldarg.0
    IL_0056: call void AutoAttackLavaRiver::RefreshTargets()  /*0x0600043F*/
    IL_005b: ldc.i4.0
    IL_005c: stloc.0
    IL_005d: br.s IL_00bd
    IL_005f: ldarg.0
    IL_0060: ldfld Weapon AutoAttack::weapon  /*0x04000303*/
    IL_0065: ldarg.0
    IL_0066: ldfld List<TaggedObject> AutoAttackLavaRiver::aliveTargets  /*0x0400056F*/
    IL_006b: ldloc.0
    IL_006c: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0071: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0076: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_007b: ldarg.0
    IL_007c: ldfld List<TaggedObject> AutoAttackLavaRiver::aliveTargets  /*0x0400056F*/
    IL_0081: ldloc.0
    IL_0082: callvirt !0 System.Collections.Generic.List<TaggedObject>::get_Item(int)  /*0x0A0001EE*/
    IL_0087: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_008c: call Vector3 UnityEngine.Vector3::get_zero()  /*0x0A000081*/
    IL_0091: ldarg.0
    IL_0092: ldfld TaggedObject AutoAttack::taggedObject  /*0x04000305*/
    IL_0097: ldarg.0
    IL_0098: ldfld float AutoAttack::damageMultiplyer  /*0x04000309*/
    IL_009d: ldc.r4 1f
    IL_00a2: callvirt void Weapon::Attack(UnityEngine.Vector3,Hp,UnityEngine.Vector3,TaggedObject,float,float)  /*0x060013C9*/
    IL_00a7: ldarg.0
    IL_00a8: ldfld UnityEvent AutoAttack::onAttackTriggered  /*0x0400030B*/
    IL_00ad: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_00b2: ldarg.0
    IL_00b3: ldc.i4.1
    IL_00b4: stfld bool AutoAttack::onCooldown  /*0x04000307*/
    IL_00b9: ldloc.0
    IL_00ba: ldc.i4.1
    IL_00bb: add
    IL_00bc: stloc.0
    IL_00bd: ldloc.0
    IL_00be: ldarg.0
    IL_00bf: ldfld List<TaggedObject> AutoAttackLavaRiver::aliveTargets  /*0x0400056F*/
    IL_00c4: callvirt int System.Collections.Generic.List<TaggedObject>::get_Count()  /*0x0A000015*/
    IL_00c9: blt.s IL_005f
    IL_00cb: ret

  .method AutoAttackLavaRiver::GetTaggedObject(UnityEngine.Collider)  // token 0x06000441 rva 0x12a88 attrs Private, HideBySig
    // code size 30 (0x1e), max stack 2, init locals
    .locals ([0] Transform)
    IL_0000: ldarg.1
    IL_0001: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Transform UnityEngine.Transform::get_parent()  /*0x0A000019*/
    IL_000b: stloc.0
    IL_000c: ldloc.0
    IL_000d: ldnull
    IL_000e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0013: brfalse.s IL_001c
    IL_0015: ldloc.0
    IL_0016: callvirt !!0 UnityEngine.Component::GetComponent()<TaggedObject>  /*0x2B000005*/
    IL_001b: ret
    IL_001c: ldnull
    IL_001d: ret

  .method AutoAttackLavaRiver::IncludeObject(TaggedObject)  // token 0x06000442 rva 0x12ab4 attrs Private, HideBySig
    // code size 67 (0x43), max stack 3, init locals
    .locals ([0] Hp)
    IL_0000: ldarg.1
    IL_0001: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0006: stloc.0
    IL_0007: ldloc.0
    IL_0008: ldnull
    IL_0009: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000e: brfalse.s IL_0042
    IL_0010: ldarg.0
    IL_0011: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_0016: ldarg.1
    IL_0017: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Contains(!0)  /*0x0A0001EF*/
    IL_001c: brtrue.s IL_0042
    IL_001e: ldarg.0
    IL_001f: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_0024: ldarg.1
    IL_0025: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Add(!0)  /*0x0A0001F0*/
    IL_002a: pop
    IL_002b: ldloc.0
    IL_002c: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_0031: ldarg.0
    IL_0032: ldftn void AutoAttackLavaRiver::ExcludeObject(TaggedObject)  /*0x06000444*/
    IL_0038: newobj void UnityEngine.Events.UnityAction<TaggedObject>::.ctor(object,IntPtr)  /*0x0A0001D8*/
    IL_003d: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::AddListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0001D9*/
    IL_0042: ret

  .method AutoAttackLavaRiver::OnTriggerEnter(UnityEngine.Collider)  // token 0x06000443 rva 0x12b04 attrs Private, HideBySig
    // code size 54 (0x36), max stack 3, init locals
    .locals ([0] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoAttackLavaRiver::inited  /*0x04000572*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.1
    IL_000b: call TaggedObject AutoAttackLavaRiver::GetTaggedObject(UnityEngine.Collider)  /*0x06000441*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0018: brfalse.s IL_0035
    IL_001a: ldloc.0
    IL_001b: ldarg.0
    IL_001c: ldfld HashSet<TagManager.ETag> AutoAttackLavaRiver::mustHaveTags  /*0x04000570*/
    IL_0021: ldarg.0
    IL_0022: ldfld HashSet<TagManager.ETag> AutoAttackLavaRiver::mustNotHaveTags  /*0x04000571*/
    IL_0027: callvirt bool TaggedObject::Match(System.Collections.Generic.HashSet<TagManager.ETag>,System.Collections.Generic.HashSet<TagManager.ETag>)  /*0x06000E4F*/
    IL_002c: brfalse.s IL_0035
    IL_002e: ldarg.0
    IL_002f: ldloc.0
    IL_0030: call void AutoAttackLavaRiver::IncludeObject(TaggedObject)  /*0x06000442*/
    IL_0035: ret

  .method AutoAttackLavaRiver::ExcludeObject(TaggedObject)  // token 0x06000444 rva 0x12b48 attrs Private, HideBySig
    // code size 65 (0x41), max stack 3, init locals
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0007: brfalse.s IL_0040
    IL_0009: ldarg.0
    IL_000a: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_000f: ldarg.1
    IL_0010: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Contains(!0)  /*0x0A0001EF*/
    IL_0015: brfalse.s IL_0040
    IL_0017: ldarg.1
    IL_0018: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_001d: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_0022: ldarg.0
    IL_0023: ldftn void AutoAttackLavaRiver::ExcludeObject(TaggedObject)  /*0x06000444*/
    IL_0029: newobj void UnityEngine.Events.UnityAction<TaggedObject>::.ctor(object,IntPtr)  /*0x0A0001D8*/
    IL_002e: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::RemoveListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0001F1*/
    IL_0033: ldarg.0
    IL_0034: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_0039: ldarg.1
    IL_003a: callvirt bool System.Collections.Generic.HashSet<TaggedObject>::Remove(!0)  /*0x0A0001F2*/
    IL_003f: pop
    IL_0040: ret

  .method AutoAttackLavaRiver::OnTriggerExit(UnityEngine.Collider)  // token 0x06000445 rva 0x12b98 attrs Private, HideBySig
    // code size 54 (0x36), max stack 3, init locals
    .locals ([0] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoAttackLavaRiver::inited  /*0x04000572*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: ldarg.1
    IL_000b: call TaggedObject AutoAttackLavaRiver::GetTaggedObject(UnityEngine.Collider)  /*0x06000441*/
    IL_0010: stloc.0
    IL_0011: ldloc.0
    IL_0012: ldnull
    IL_0013: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0018: brfalse.s IL_0035
    IL_001a: ldloc.0
    IL_001b: ldarg.0
    IL_001c: ldfld HashSet<TagManager.ETag> AutoAttackLavaRiver::mustHaveTags  /*0x04000570*/
    IL_0021: ldarg.0
    IL_0022: ldfld HashSet<TagManager.ETag> AutoAttackLavaRiver::mustNotHaveTags  /*0x04000571*/
    IL_0027: callvirt bool TaggedObject::Match(System.Collections.Generic.HashSet<TagManager.ETag>,System.Collections.Generic.HashSet<TagManager.ETag>)  /*0x06000E4F*/
    IL_002c: brfalse.s IL_0035
    IL_002e: ldarg.0
    IL_002f: ldloc.0
    IL_0030: call void AutoAttackLavaRiver::ExcludeObject(TaggedObject)  /*0x06000444*/
    IL_0035: ret

  .method AutoAttackLavaRiver::ClearTargets()  // token 0x06000446 rva 0x12bdc attrs Private, HideBySig
    // code size 96 (0x60), max stack 3, init locals
    .locals ([0] HashSet.Enumerator<TaggedObject>, [1] TaggedObject)
    IL_0000: ldarg.0
    IL_0001: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_0006: callvirt HashSet.Enumerator<!0> System.Collections.Generic.HashSet<TaggedObject>::GetEnumerator()  /*0x0A0001E8*/
    IL_000b: stloc.0
    IL_000c: br.s IL_003b
    IL_000e: ldloca.s 0
    IL_0010: call !0 System.Collections.Generic.HashSet.Enumerator<TaggedObject>::get_Current()  /*0x0A0001E9*/
    IL_0015: stloc.1
    IL_0016: ldloc.1
    IL_0017: ldnull
    IL_0018: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_001d: brfalse.s IL_003b
    IL_001f: ldloc.1
    IL_0020: callvirt Hp TaggedObject::get_Hp()  /*0x06000E41*/
    IL_0025: ldfld UnityEvent<TaggedObject> Hp::OnKillOrKnockoutDetailed  /*0x04000A40*/
    IL_002a: ldarg.0
    IL_002b: ldftn void AutoAttackLavaRiver::ExcludeObject(TaggedObject)  /*0x06000444*/
    IL_0031: newobj void UnityEngine.Events.UnityAction<TaggedObject>::.ctor(object,IntPtr)  /*0x0A0001D8*/
    IL_0036: callvirt void UnityEngine.Events.UnityEvent<TaggedObject>::RemoveListener(UnityEngine.Events.UnityAction<!0>)  /*0x0A0001F1*/
    IL_003b: ldloca.s 0
    IL_003d: call bool System.Collections.Generic.HashSet.Enumerator<TaggedObject>::MoveNext()  /*0x0A0001EA*/
    IL_0042: brtrue.s IL_000e
    IL_0044: leave.s IL_0054
    IL_0046: ldloca.s 0
    IL_0048: constrained. System.Collections.Generic.HashSet.Enumerator<TaggedObject>  /*0x1B00004A*/
    IL_004e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0053: endfinally
    IL_0054: ldarg.0
    IL_0055: ldfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_005a: callvirt void System.Collections.Generic.HashSet<TaggedObject>::Clear()  /*0x0A0001EB*/
    IL_005f: ret
    .try IL_000c-IL_0046 finally handler IL_0046-IL_0054

  .method AutoAttackLavaRiver::TurnOn()  // token 0x06000447 rva 0x12c58 attrs Public, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoAttackLavaRiver::inited  /*0x04000572*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: call void AutoAttackLavaRiver::ClearTargets()  /*0x06000446*/
    IL_000f: ldarg.0
    IL_0010: ldfld BoxCollider AutoAttackLavaRiver::areaCollider  /*0x0400056D*/
    IL_0015: ldc.i4.1
    IL_0016: callvirt void UnityEngine.Collider::set_enabled(bool)  /*0x0A0001B5*/
    IL_001b: ret

  .method AutoAttackLavaRiver::TurnOff()  // token 0x06000448 rva 0x12c75 attrs Public, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld bool AutoAttackLavaRiver::inited  /*0x04000572*/
    IL_0006: brtrue.s IL_0009
    IL_0008: ret
    IL_0009: ldarg.0
    IL_000a: call void AutoAttackLavaRiver::ClearTargets()  /*0x06000446*/
    IL_000f: ldarg.0
    IL_0010: ldfld BoxCollider AutoAttackLavaRiver::areaCollider  /*0x0400056D*/
    IL_0015: ldc.i4.0
    IL_0016: callvirt void UnityEngine.Collider::set_enabled(bool)  /*0x0A0001B5*/
    IL_001b: ret

  .method AutoAttackLavaRiver::.ctor()  // token 0x06000449 rva 0x12c92 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.HashSet<TaggedObject>::.ctor()  /*0x0A0001F3*/
    IL_0006: stfld HashSet<TaggedObject> AutoAttackLavaRiver::targets  /*0x0400056E*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0011: stfld List<TaggedObject> AutoAttackLavaRiver::aliveTargets  /*0x0400056F*/
    IL_0016: ldarg.0
    IL_0017: newobj void System.Collections.Generic.HashSet<TagManager.ETag>::.ctor()  /*0x0A0001F4*/
    IL_001c: stfld HashSet<TagManager.ETag> AutoAttackLavaRiver::mustHaveTags  /*0x04000570*/
    IL_0021: ldarg.0
    IL_0022: newobj void System.Collections.Generic.HashSet<TagManager.ETag>::.ctor()  /*0x0A0001F4*/
    IL_0027: stfld HashSet<TagManager.ETag> AutoAttackLavaRiver::mustNotHaveTags  /*0x04000571*/
    IL_002c: ldarg.0
    IL_002d: call void AutoAttack::.ctor()  /*0x06000238*/
    IL_0032: ret

