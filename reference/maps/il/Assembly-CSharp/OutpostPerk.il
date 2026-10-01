// ===== OutpostPerk  (token 0x02000206) =====
  .method OutpostPerk::OnEnable()  // token 0x06000AD3 rva 0x334b3 attrs Private, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_000e
    IL_000d: ret
    IL_000e: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0013: callvirt bool PerkManager::get_OutpostEquipped()  /*0x0600099C*/
    IL_0018: brtrue.s IL_001b
    IL_001a: ret
    IL_001b: ldarg.0
    IL_001c: ldarg.0
    IL_001d: call IEnumerator OutpostPerk::BuildFreeTowers()  /*0x06000AD4*/
    IL_0022: call Coroutine UnityEngine.MonoBehaviour::StartCoroutine(System.Collections.IEnumerator)  /*0x0A00002F*/
    IL_0027: pop
    IL_0028: ret

  .method OutpostPerk::BuildFreeTowers()  // token 0x06000AD4 rva 0x334dd attrs Private, HideBySig
    // code size 14 (0xe), max stack 8
    IL_0000: ldc.i4.0
    IL_0001: newobj void OutpostPerk.<BuildFreeTowers>d__3::.ctor(int)  /*0x06000AD7*/
    IL_0006: dup
    IL_0007: ldarg.0
    IL_0008: stfld OutpostPerk OutpostPerk.<BuildFreeTowers>d__3::<>4__this  /*0x04000D9F*/
    IL_000d: ret

  .method OutpostPerk::.ctor()  // token 0x06000AD5 rva 0x334ec attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.2
    IL_0002: stfld int OutpostPerk::numberOfTowersToActivate  /*0x04000D9C*/
    IL_0007: ldarg.0
    IL_0008: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_000d: ret

  .method OutpostPerk::<BuildFreeTowers>b__3_0(BuildSlot)  // token 0x06000AD6 rva 0x334fb attrs Private, HideBySig
    // code size 28 (0x1c), max stack 8
    IL_0000: ldarg.0
    IL_0001: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0006: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_000b: ldarg.1
    IL_000c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0011: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0016: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_001b: ret

// ===== OutpostPerk/<BuildFreeTowers>d__3  (token 0x02000207) =====
  .method OutpostPerk.<BuildFreeTowers>d__3::.ctor(int)  // token 0x06000AD7 rva 0x33518 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 14 (0xe), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ldarg.0
    IL_0007: ldarg.1
    IL_0008: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_000d: ret

  .method OutpostPerk.<BuildFreeTowers>d__3::System.IDisposable.Dispose()  // token 0x06000AD8 rva 0x25f1 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 1 (0x1), max stack 8
    IL_0000: ret

  .method OutpostPerk.<BuildFreeTowers>d__3::MoveNext()  // token 0x06000AD9 rva 0x33528 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 438 (0x1b6), max stack 4, init locals
    .locals ([0] int, [1] OutpostPerk, [2] List.Enumerator<BuildSlot>, [3] BuildSlot, [4] int)
    IL_0000: ldarg.0
    IL_0001: ldfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0006: stloc.0
    IL_0007: ldarg.0
    IL_0008: ldfld OutpostPerk OutpostPerk.<BuildFreeTowers>d__3::<>4__this  /*0x04000D9F*/
    IL_000d: stloc.1
    IL_000e: ldloc.0
    IL_000f: switch (IL_002e, IL_0045, IL_005c, IL_0073, IL_014b, IL_017a)
    IL_002c: ldc.i4.0
    IL_002d: ret
    IL_002e: ldarg.0
    IL_002f: ldc.i4.m1
    IL_0030: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0035: ldarg.0
    IL_0036: ldnull
    IL_0037: stfld object OutpostPerk.<BuildFreeTowers>d__3::<>2__current  /*0x04000D9E*/
    IL_003c: ldarg.0
    IL_003d: ldc.i4.1
    IL_003e: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0043: ldc.i4.1
    IL_0044: ret
    IL_0045: ldarg.0
    IL_0046: ldc.i4.m1
    IL_0047: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_004c: ldarg.0
    IL_004d: ldnull
    IL_004e: stfld object OutpostPerk.<BuildFreeTowers>d__3::<>2__current  /*0x04000D9E*/
    IL_0053: ldarg.0
    IL_0054: ldc.i4.2
    IL_0055: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_005a: ldc.i4.1
    IL_005b: ret
    IL_005c: ldarg.0
    IL_005d: ldc.i4.m1
    IL_005e: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0063: ldarg.0
    IL_0064: ldnull
    IL_0065: stfld object OutpostPerk.<BuildFreeTowers>d__3::<>2__current  /*0x04000D9E*/
    IL_006a: ldarg.0
    IL_006b: ldc.i4.3
    IL_006c: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0071: ldc.i4.1
    IL_0072: ret
    IL_0073: ldarg.0
    IL_0074: ldc.i4.m1
    IL_0075: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_007a: ldloc.1
    IL_007b: ldfld BuildSlot OutpostPerk::buildSlot  /*0x04000D9B*/
    IL_0080: callvirt List<BuildSlot> BuildSlot::get_BuiltSlotsThatRelyOnThisBuilding()  /*0x060002EC*/
    IL_0085: ldarg.0
    IL_0086: newobj void System.Collections.Generic.List<BuildSlot>::.ctor()  /*0x0A00012D*/
    IL_008b: stfld List<BuildSlot> OutpostPerk.<BuildFreeTowers>d__3::<towerSlots>5__2  /*0x04000DA0*/
    IL_0090: callvirt List.Enumerator<!0> System.Collections.Generic.List<BuildSlot>::GetEnumerator()  /*0x0A000137*/
    IL_0095: stloc.2
    IL_0096: br.s IL_00c6
    IL_0098: ldloca.s 2
    IL_009a: call !0 System.Collections.Generic.List.Enumerator<BuildSlot>::get_Current()  /*0x0A000138*/
    IL_009f: stloc.3
    IL_00a0: ldloc.3
    IL_00a1: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_00a6: brfalse.s IL_00c6
    IL_00a8: ldloc.3
    IL_00a9: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_00ae: ldstr "Tower"
    IL_00b3: callvirt bool System.String::Contains(string)  /*0x0A000055*/
    IL_00b8: brfalse.s IL_00c6
    IL_00ba: ldarg.0
    IL_00bb: ldfld List<BuildSlot> OutpostPerk.<BuildFreeTowers>d__3::<towerSlots>5__2  /*0x04000DA0*/
    IL_00c0: ldloc.3
    IL_00c1: callvirt void System.Collections.Generic.List<BuildSlot>::Add(!0)  /*0x0A00012E*/
    IL_00c6: ldloca.s 2
    IL_00c8: call bool System.Collections.Generic.List.Enumerator<BuildSlot>::MoveNext()  /*0x0A000139*/
    IL_00cd: brtrue.s IL_0098
    IL_00cf: leave.s IL_00df
    IL_00d1: ldloca.s 2
    IL_00d3: constrained. System.Collections.Generic.List.Enumerator<BuildSlot>  /*0x1B000029*/
    IL_00d9: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_00de: endfinally
    IL_00df: ldarg.0
    IL_00e0: ldarg.0
    IL_00e1: ldfld List<BuildSlot> OutpostPerk.<BuildFreeTowers>d__3::<towerSlots>5__2  /*0x04000DA0*/
    IL_00e6: ldloc.1
    IL_00e7: ldftn float OutpostPerk::<BuildFreeTowers>b__3_0(BuildSlot)  /*0x06000AD6*/
    IL_00ed: newobj void System.Func<BuildSlot, float>::.ctor(object,IntPtr)  /*0x0A0004C6*/
    IL_00f2: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderByDescending(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<BuildSlot,float>  /*0x2B0000A4*/
    IL_00f7: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<BuildSlot>  /*0x2B0000A5*/
    IL_00fc: stfld List<BuildSlot> OutpostPerk.<BuildFreeTowers>d__3::<towerSlots>5__2  /*0x04000DA0*/
    IL_0101: ldarg.0
    IL_0102: ldc.i4.0
    IL_0103: stfld int OutpostPerk.<BuildFreeTowers>d__3::<i>5__3  /*0x04000DA1*/
    IL_0108: br IL_0193
    IL_010d: ldarg.0
    IL_010e: ldfld List<BuildSlot> OutpostPerk.<BuildFreeTowers>d__3::<towerSlots>5__2  /*0x04000DA0*/
    IL_0113: ldarg.0
    IL_0114: ldfld int OutpostPerk.<BuildFreeTowers>d__3::<i>5__3  /*0x04000DA1*/
    IL_0119: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_011e: callvirt int BuildSlot::get_Level()  /*0x060002D3*/
    IL_0123: brtrue.s IL_0181
    IL_0125: ldarg.0
    IL_0126: ldfld List<BuildSlot> OutpostPerk.<BuildFreeTowers>d__3::<towerSlots>5__2  /*0x04000DA0*/
    IL_012b: ldarg.0
    IL_012c: ldfld int OutpostPerk.<BuildFreeTowers>d__3::<i>5__3  /*0x04000DA1*/
    IL_0131: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0136: callvirt void BuildSlot::ActivateIgrnoringActivatorLevel()  /*0x060002F4*/
    IL_013b: ldarg.0
    IL_013c: ldnull
    IL_013d: stfld object OutpostPerk.<BuildFreeTowers>d__3::<>2__current  /*0x04000D9E*/
    IL_0142: ldarg.0
    IL_0143: ldc.i4.4
    IL_0144: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0149: ldc.i4.1
    IL_014a: ret
    IL_014b: ldarg.0
    IL_014c: ldc.i4.m1
    IL_014d: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0152: ldarg.0
    IL_0153: ldfld List<BuildSlot> OutpostPerk.<BuildFreeTowers>d__3::<towerSlots>5__2  /*0x04000DA0*/
    IL_0158: ldarg.0
    IL_0159: ldfld int OutpostPerk.<BuildFreeTowers>d__3::<i>5__3  /*0x04000DA1*/
    IL_015e: callvirt !0 System.Collections.Generic.List<BuildSlot>::get_Item(int)  /*0x0A000054*/
    IL_0163: ldnull
    IL_0164: ldc.i4.0
    IL_0165: callvirt void BuildSlot::TryToBuildOrUpgradeAndPay(PlayerInteraction,bool)  /*0x060002F6*/
    IL_016a: ldarg.0
    IL_016b: ldnull
    IL_016c: stfld object OutpostPerk.<BuildFreeTowers>d__3::<>2__current  /*0x04000D9E*/
    IL_0171: ldarg.0
    IL_0172: ldc.i4.5
    IL_0173: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0178: ldc.i4.1
    IL_0179: ret
    IL_017a: ldarg.0
    IL_017b: ldc.i4.m1
    IL_017c: stfld int OutpostPerk.<BuildFreeTowers>d__3::<>1__state  /*0x04000D9D*/
    IL_0181: ldarg.0
    IL_0182: ldfld int OutpostPerk.<BuildFreeTowers>d__3::<i>5__3  /*0x04000DA1*/
    IL_0187: stloc.s 4
    IL_0189: ldarg.0
    IL_018a: ldloc.s 4
    IL_018c: ldc.i4.1
    IL_018d: add
    IL_018e: stfld int OutpostPerk.<BuildFreeTowers>d__3::<i>5__3  /*0x04000DA1*/
    IL_0193: ldarg.0
    IL_0194: ldfld int OutpostPerk.<BuildFreeTowers>d__3::<i>5__3  /*0x04000DA1*/
    IL_0199: ldloc.1
    IL_019a: ldfld int OutpostPerk::numberOfTowersToActivate  /*0x04000D9C*/
    IL_019f: ldarg.0
    IL_01a0: ldfld List<BuildSlot> OutpostPerk.<BuildFreeTowers>d__3::<towerSlots>5__2  /*0x04000DA0*/
    IL_01a5: callvirt int System.Collections.Generic.List<BuildSlot>::get_Count()  /*0x0A000053*/
    IL_01aa: call int UnityEngine.Mathf::Min(int,int)  /*0x0A00027B*/
    IL_01af: blt IL_010d
    IL_01b4: ldc.i4.0
    IL_01b5: ret
    .try IL_0096-IL_00d1 finally handler IL_00d1-IL_00df

  .method OutpostPerk.<BuildFreeTowers>d__3::System.Collections.Generic.IEnumerator<System.Object>.get_Current()  // token 0x06000ADA rva 0x336fc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object OutpostPerk.<BuildFreeTowers>d__3::<>2__current  /*0x04000D9E*/
    IL_0006: ret

  .method OutpostPerk.<BuildFreeTowers>d__3::System.Collections.IEnumerator.Reset()  // token 0x06000ADB rva 0x2a85 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 6 (0x6), max stack 8
    IL_0000: newobj void System.NotSupportedException::.ctor()  /*0x0A00003F*/
    IL_0005: throw

  .method OutpostPerk.<BuildFreeTowers>d__3::System.Collections.IEnumerator.get_Current()  // token 0x06000ADC rva 0x336fc attrs Private, Final, Virtual, HideBySig, VtableLayoutMask, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld object OutpostPerk.<BuildFreeTowers>d__3::<>2__current  /*0x04000D9E*/
    IL_0006: ret

