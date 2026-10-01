// ===== PlatformMover  (token 0x0200010F) =====
  .method PlatformMover::add_OnPlatformLeaving(System.Action<int>)  // token 0x06000599 rva 0x17ea0 attrs Public, Static, HideBySig, SpecialName
    // code size 39 (0x27), max stack 3, init locals
    .locals ([0] Action<int>, [1] Action<int>, [2] Action<int>)
    IL_0000: ldsfld Action<int> PlatformMover::OnPlatformLeaving  /*0x04000715*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: stloc.1
    IL_0008: ldloc.1
    IL_0009: ldarg.0
    IL_000a: call Delegate System.Delegate::Combine(System.Delegate,System.Delegate)  /*0x0A00024B*/
    IL_000f: castclass System.Action<int>  /*0x1B00005C*/
    IL_0014: stloc.2
    IL_0015: ldsflda Action<int> PlatformMover::OnPlatformLeaving  /*0x04000715*/
    IL_001a: ldloc.2
    IL_001b: ldloc.1
    IL_001c: call !!0 System.Threading.Interlocked::CompareExchange(ref !!0,!!0,!!0)<System.Action<int>>  /*0x2B00003E*/
    IL_0021: stloc.0
    IL_0022: ldloc.0
    IL_0023: ldloc.1
    IL_0024: bne.un.s IL_0006
    IL_0026: ret

  .method PlatformMover::remove_OnPlatformLeaving(System.Action<int>)  // token 0x0600059A rva 0x17ed4 attrs Public, Static, HideBySig, SpecialName
    // code size 39 (0x27), max stack 3, init locals
    .locals ([0] Action<int>, [1] Action<int>, [2] Action<int>)
    IL_0000: ldsfld Action<int> PlatformMover::OnPlatformLeaving  /*0x04000715*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: stloc.1
    IL_0008: ldloc.1
    IL_0009: ldarg.0
    IL_000a: call Delegate System.Delegate::Remove(System.Delegate,System.Delegate)  /*0x0A00024D*/
    IL_000f: castclass System.Action<int>  /*0x1B00005C*/
    IL_0014: stloc.2
    IL_0015: ldsflda Action<int> PlatformMover::OnPlatformLeaving  /*0x04000715*/
    IL_001a: ldloc.2
    IL_001b: ldloc.1
    IL_001c: call !!0 System.Threading.Interlocked::CompareExchange(ref !!0,!!0,!!0)<System.Action<int>>  /*0x2B00003E*/
    IL_0021: stloc.0
    IL_0022: ldloc.0
    IL_0023: ldloc.1
    IL_0024: bne.un.s IL_0006
    IL_0026: ret

  .method PlatformMover::get_StartingDockId()  // token 0x0600059B rva 0x17f07 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int PlatformMover::startingDockId  /*0x0400070F*/
    IL_0006: ret

  .method PlatformMover::get_CurrentDockId()  // token 0x0600059C rva 0x17f0f attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld int PlatformMover::<CurrentDockId>k__BackingField  /*0x04000716*/
    IL_0006: ret

  .method PlatformMover::set_CurrentDockId(int)  // token 0x0600059D rva 0x17f17 attrs Private, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld int PlatformMover::<CurrentDockId>k__BackingField  /*0x04000716*/
    IL_0007: ret

  .method PlatformMover::get_CurrentDockPosition()  // token 0x0600059E rva 0x17f20 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld Vector3 PlatformMover::<CurrentDockPosition>k__BackingField  /*0x04000717*/
    IL_0006: ret

  .method PlatformMover::set_CurrentDockPosition(UnityEngine.Vector3)  // token 0x0600059F rva 0x17f28 attrs Private, HideBySig, SpecialName
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: stfld Vector3 PlatformMover::<CurrentDockPosition>k__BackingField  /*0x04000717*/
    IL_0007: ret

  .method PlatformMover::Start()  // token 0x060005A0 rva 0x17f34 attrs Private, HideBySig
    // code size 127 (0x7f), max stack 3, init locals
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_0007: ldnull
    IL_0008: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000d: brtrue.s IL_0017
    IL_000f: ldarg.0
    IL_0010: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_0015: br.s IL_001d
    IL_0017: ldarg.0
    IL_0018: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.Animator>  /*0x2B000013*/
    IL_001d: stfld Animator PlatformMover::animator  /*0x04000710*/
    IL_0022: ldarg.0
    IL_0023: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_0028: ldc.i4.0
    IL_0029: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_002e: ldarg.0
    IL_002f: ldarg.0
    IL_0030: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_0035: callvirt RuntimeAnimatorController UnityEngine.Animator::get_runtimeAnimatorController()  /*0x0A00024E*/
    IL_003a: newobj void UnityEngine.AnimatorOverrideController::.ctor(UnityEngine.RuntimeAnimatorController)  /*0x0A00024F*/
    IL_003f: stfld AnimatorOverrideController PlatformMover::overrideController  /*0x04000718*/
    IL_0044: ldarg.0
    IL_0045: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_004a: ldarg.0
    IL_004b: ldfld AnimatorOverrideController PlatformMover::overrideController  /*0x04000718*/
    IL_0050: callvirt void UnityEngine.Animator::set_runtimeAnimatorController(UnityEngine.RuntimeAnimatorController)  /*0x0A000250*/
    IL_0055: ldarg.0
    IL_0056: ldarg.0
    IL_0057: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_005c: callvirt RuntimeAnimatorController UnityEngine.Animator::get_runtimeAnimatorController()  /*0x0A00024E*/
    IL_0061: callvirt AnimationClip[] UnityEngine.RuntimeAnimatorController::get_animationClips()  /*0x0A000251*/
    IL_0066: ldc.i4.0
    IL_0067: ldelem.ref
    IL_0068: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_006d: stfld string PlatformMover::baseClip  /*0x04000719*/
    IL_0072: ldarg.0
    IL_0073: ldarg.0
    IL_0074: call Vector3 PlatformMover::get_CurrentDockPosition()  /*0x0600059E*/
    IL_0079: call void PlatformMover::SnapToDock(UnityEngine.Vector3)  /*0x060005A5*/
    IL_007e: ret

  .method PlatformMover::GetEntryAfterNight(int)  // token 0x060005A1 rva 0x17fc0 attrs Public, HideBySig
    // code size 37 (0x25), max stack 3, init locals
    .locals ([0] PlatformMover.<>c__DisplayClass22_0)
    IL_0000: newobj void PlatformMover.<>c__DisplayClass22_0::.ctor()  /*0x060005A9*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.1
    IL_0008: stfld int PlatformMover.<>c__DisplayClass22_0::night  /*0x0400071A*/
    IL_000d: ldarg.0
    IL_000e: ldfld List<ScheduleEntry> PlatformMover::schedule  /*0x04000714*/
    IL_0013: ldloc.0
    IL_0014: ldftn bool PlatformMover.<>c__DisplayClass22_0::<GetEntryAfterNight>b__0(ScheduleEntry)  /*0x060005AA*/
    IL_001a: newobj void System.Predicate<ScheduleEntry>::.ctor(object,IntPtr)  /*0x0A000252*/
    IL_001f: callvirt !0 System.Collections.Generic.List<ScheduleEntry>::Find(System.Predicate<!0>)  /*0x0A000253*/
    IL_0024: ret

  .method PlatformMover::SetStartDockId()  // token 0x060005A2 rva 0x17ff1 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld int PlatformMover::startingDockId  /*0x0400070F*/
    IL_0007: call void PlatformMover::set_CurrentDockId(int)  /*0x0600059D*/
    IL_000c: ret

  .method PlatformMover::SetCurrentDockId(int)  // token 0x060005A3 rva 0x17fff attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void PlatformMover::set_CurrentDockId(int)  /*0x0600059D*/
    IL_0007: ret

  .method PlatformMover::SetCurrentDockPosition(UnityEngine.Vector3)  // token 0x060005A4 rva 0x18008 attrs Public, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.1
    IL_0002: call void PlatformMover::set_CurrentDockPosition(UnityEngine.Vector3)  /*0x0600059F*/
    IL_0007: ret

  .method PlatformMover::SnapToDock(UnityEngine.Vector3)  // token 0x060005A5 rva 0x18011 attrs Public, HideBySig
    // code size 13 (0xd), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: ldarg.1
    IL_0007: callvirt void UnityEngine.Transform::set_position(UnityEngine.Vector3)  /*0x0A00006A*/
    IL_000c: ret

  .method PlatformMover::MoveTo(int,UnityEngine.Vector3,UnityEngine.AnimationClip)  // token 0x060005A6 rva 0x18020 attrs Public, HideBySig
    // code size 115 (0x73), max stack 4, init locals
    IL_0000: ldarg.3
    IL_0001: ldnull
    IL_0002: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_0007: brfalse.s IL_000a
    IL_0009: ret
    IL_000a: ldarg.0
    IL_000b: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_0010: ldc.i4.1
    IL_0011: callvirt void UnityEngine.Behaviour::set_enabled(bool)  /*0x0A000048*/
    IL_0016: ldsfld Action<int> PlatformMover::OnPlatformLeaving  /*0x04000715*/
    IL_001b: dup
    IL_001c: brtrue.s IL_0021
    IL_001e: pop
    IL_001f: br.s IL_002c
    IL_0021: ldarg.0
    IL_0022: call int PlatformMover::get_CurrentDockId()  /*0x0600059C*/
    IL_0027: callvirt void System.Action<int>::Invoke(!0)  /*0x0A000254*/
    IL_002c: ldarg.0
    IL_002d: ldarg.2
    IL_002e: call void PlatformMover::SnapToDock(UnityEngine.Vector3)  /*0x060005A5*/
    IL_0033: ldarg.0
    IL_0034: ldfld AnimatorOverrideController PlatformMover::overrideController  /*0x04000718*/
    IL_0039: ldarg.0
    IL_003a: ldfld string PlatformMover::baseClip  /*0x04000719*/
    IL_003f: ldarg.3
    IL_0040: callvirt void UnityEngine.AnimatorOverrideController::set_Item(string,UnityEngine.AnimationClip)  /*0x0A000255*/
    IL_0045: ldarg.0
    IL_0046: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_004b: ldstr "StartMove"
    IL_0050: callvirt void UnityEngine.Animator::SetTrigger(string)  /*0x0A00008B*/
    IL_0055: ldarg.0
    IL_0056: ldfld Animator PlatformMover::animator  /*0x04000710*/
    IL_005b: ldstr "Move"
    IL_0060: ldc.i4.0
    IL_0061: ldc.r4 0f
    IL_0066: callvirt void UnityEngine.Animator::Play(string,int,float)  /*0x0A000256*/
    IL_006b: ldarg.0
    IL_006c: ldarg.1
    IL_006d: call void PlatformMover::set_CurrentDockId(int)  /*0x0600059D*/
    IL_0072: ret

  .method PlatformMover::GetOccupants(ref PlayerMovement,ref System.Collections.Generic.List<TaggedObject>)  // token 0x060005A7 rva 0x180a0 attrs Public, HideBySig
    // code size 266 (0x10a), max stack 6, init locals
    .locals ([0] Vector3, [1] Collider[], [2] Bounds, [3] Collider[], [4] int, [5] TaggedObject)
    IL_0000: ldarg.1
    IL_0001: ldnull
    IL_0002: stind.ref
    IL_0003: ldarg.2
    IL_0004: newobj void System.Collections.Generic.List<TaggedObject>::.ctor()  /*0x0A00001F*/
    IL_0009: stind.ref
    IL_000a: ldarg.0
    IL_000b: ldfld Collider PlatformMover::platformCollider  /*0x04000711*/
    IL_0010: callvirt Bounds UnityEngine.Collider::get_bounds()  /*0x0A000257*/
    IL_0015: stloc.2
    IL_0016: ldloca.s 2
    IL_0018: call Vector3 UnityEngine.Bounds::get_center()  /*0x0A00010F*/
    IL_001d: ldarg.0
    IL_001e: ldfld Collider PlatformMover::platformCollider  /*0x04000711*/
    IL_0023: callvirt Bounds UnityEngine.Collider::get_bounds()  /*0x0A000257*/
    IL_0028: stloc.2
    IL_0029: ldloca.s 2
    IL_002b: call Vector3 UnityEngine.Bounds::get_extents()  /*0x0A000258*/
    IL_0030: stloc.0
    IL_0031: ldarg.0
    IL_0032: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0037: callvirt Quaternion UnityEngine.Transform::get_rotation()  /*0x0A00007D*/
    IL_003c: pop
    IL_003d: dup
    IL_003e: ldloc.0
    IL_003f: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0044: ldc.r4 0.5f
    IL_0049: add
    IL_004a: ldloc.0
    IL_004b: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_0050: ldc.r4 3f
    IL_0055: add
    IL_0056: ldloc.0
    IL_0057: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_005c: ldc.r4 0.5f
    IL_0061: add
    IL_0062: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_0067: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_006c: ldarg.0
    IL_006d: ldfld LayerMask PlatformMover::playerLayer  /*0x04000712*/
    IL_0072: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_0077: call Collider[] UnityEngine.Physics::OverlapBox(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Quaternion,int)  /*0x0A000259*/
    IL_007c: stloc.1
    IL_007d: ldloc.1
    IL_007e: ldlen
    IL_007f: brfalse.s IL_008b
    IL_0081: ldloc.1
    IL_0082: ldc.i4.0
    IL_0083: ldelem.ref
    IL_0084: ldarg.1
    IL_0085: callvirt bool UnityEngine.Component::TryGetComponent(ref !!0)<PlayerMovement>  /*0x2B00003F*/
    IL_008a: pop
    IL_008b: ldloc.0
    IL_008c: ldfld float UnityEngine.Vector3::x  /*0x0A000094*/
    IL_0091: ldc.r4 0.5f
    IL_0096: add
    IL_0097: ldloc.0
    IL_0098: ldfld float UnityEngine.Vector3::y  /*0x0A000095*/
    IL_009d: ldc.r4 3f
    IL_00a2: add
    IL_00a3: ldloc.0
    IL_00a4: ldfld float UnityEngine.Vector3::z  /*0x0A000096*/
    IL_00a9: ldc.r4 0.5f
    IL_00ae: add
    IL_00af: newobj void UnityEngine.Vector3::.ctor(float,float,float)  /*0x0A000035*/
    IL_00b4: call Quaternion UnityEngine.Quaternion::get_identity()  /*0x0A000073*/
    IL_00b9: ldarg.0
    IL_00ba: ldfld LayerMask PlatformMover::unitLayer  /*0x04000713*/
    IL_00bf: call int UnityEngine.LayerMask::op_Implicit(UnityEngine.LayerMask)  /*0x0A000105*/
    IL_00c4: call Collider[] UnityEngine.Physics::OverlapBox(UnityEngine.Vector3,UnityEngine.Vector3,UnityEngine.Quaternion,int)  /*0x0A000259*/
    IL_00c9: stloc.3
    IL_00ca: ldc.i4.0
    IL_00cb: stloc.s 4
    IL_00cd: br.s IL_0102
    IL_00cf: ldloc.3
    IL_00d0: ldloc.s 4
    IL_00d2: ldelem.ref
    IL_00d3: callvirt !!0 UnityEngine.Component::GetComponentInParent()<TaggedObject>  /*0x2B00001D*/
    IL_00d8: stloc.s 5
    IL_00da: ldloc.s 5
    IL_00dc: ldnull
    IL_00dd: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_00e2: brfalse.s IL_00fc
    IL_00e4: ldloc.s 5
    IL_00e6: callvirt List<TagManager.ETag> TaggedObject::get_Tags()  /*0x06000E3F*/
    IL_00eb: ldc.i4.7
    IL_00ec: callvirt bool System.Collections.Generic.List<TagManager.ETag>::Contains(!0)  /*0x0A000050*/
    IL_00f1: brfalse.s IL_00fc
    IL_00f3: ldarg.2
    IL_00f4: ldind.ref
    IL_00f5: ldloc.s 5
    IL_00f7: callvirt void System.Collections.Generic.List<TaggedObject>::Add(!0)  /*0x0A0000E7*/
    IL_00fc: ldloc.s 4
    IL_00fe: ldc.i4.1
    IL_00ff: add
    IL_0100: stloc.s 4
    IL_0102: ldloc.s 4
    IL_0104: ldloc.3
    IL_0105: ldlen
    IL_0106: conv.i4
    IL_0107: blt.s IL_00cf
    IL_0109: ret

  .method PlatformMover::.ctor()  // token 0x060005A8 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

// ===== PlatformMover/<>c__DisplayClass22_0  (token 0x02000110) =====
  .method PlatformMover.<>c__DisplayClass22_0::.ctor()  // token 0x060005A9 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method PlatformMover.<>c__DisplayClass22_0::<GetEntryAfterNight>b__0(ScheduleEntry)  // token 0x060005AA rva 0x181b6 attrs Assembly, HideBySig
    // code size 15 (0xf), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld int ScheduleEntry::afterNight  /*0x0400070D*/
    IL_0006: ldarg.0
    IL_0007: ldfld int PlatformMover.<>c__DisplayClass22_0::night  /*0x0400071A*/
    IL_000c: ceq
    IL_000e: ret

