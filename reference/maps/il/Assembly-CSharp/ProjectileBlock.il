// ===== ProjectileBlock  (token 0x02000118) =====
  .method ProjectileBlock::AddSphereArea(UnityEngine.Transform,float)  // token 0x060005CC rva 0x18a38 attrs Public, Static, HideBySig
    // code size 82 (0x52), max stack 3, init locals
    IL_0000: ldsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_0005: ldarg.0
    IL_0006: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::ContainsKey(!0)  /*0x0A000268*/
    IL_000b: brfalse.s IL_001f
    IL_000d: ldsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_0012: ldarg.0
    IL_0013: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::get_Item(!0)  /*0x0A000269*/
    IL_0018: ldarg.1
    IL_0019: stfld float ProjectileSphereArea::radius  /*0x04000733*/
    IL_001e: ret
    IL_001f: ldsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_0024: ldarg.0
    IL_0025: newobj void ProjectileSphereArea::.ctor()  /*0x060005CB*/
    IL_002a: callvirt void System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::set_Item(!0,!1)  /*0x0A00026A*/
    IL_002f: ldsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_0034: ldarg.0
    IL_0035: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::get_Item(!0)  /*0x0A000269*/
    IL_003a: ldarg.0
    IL_003b: stfld Transform ProjectileSphereArea::transform  /*0x04000732*/
    IL_0040: ldsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_0045: ldarg.0
    IL_0046: callvirt !1 System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::get_Item(!0)  /*0x0A000269*/
    IL_004b: ldarg.1
    IL_004c: stfld float ProjectileSphereArea::radius  /*0x04000733*/
    IL_0051: ret

  .method ProjectileBlock::RemoveSphereArea(UnityEngine.Transform)  // token 0x060005CD rva 0x18a96 attrs Public, Static, HideBySig
    // code size 26 (0x1a), max stack 8
    IL_0000: ldsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_0005: ldarg.0
    IL_0006: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::ContainsKey(!0)  /*0x0A000268*/
    IL_000b: brfalse.s IL_0019
    IL_000d: ldsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_0012: ldarg.0
    IL_0013: callvirt bool System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::Remove(!0)  /*0x0A00026B*/
    IL_0018: pop
    IL_0019: ret

  .method ProjectileBlock::Inside(UnityEngine.Transform)  // token 0x060005CE rva 0x18ab4 attrs Public, Static, HideBySig
    // code size 73 (0x49), max stack 2, init locals
    .locals ([0] Dictionary.ValueCollection.Enumerator<Transform, ProjectileSphereArea>, [1] ProjectileSphereArea, [2] Transform)
    IL_0000: ldsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_0005: callvirt Dictionary.ValueCollection<!0, !1> System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::get_Values()  /*0x0A00026C*/
    IL_000a: callvirt Dictionary.ValueCollection.Enumerator<!0, !1> System.Collections.Generic.Dictionary.ValueCollection<UnityEngine.Transform, ProjectileSphereArea>::GetEnumerator()  /*0x0A00026D*/
    IL_000f: stloc.0
    IL_0010: br.s IL_002c
    IL_0012: ldloca.s 0
    IL_0014: call !1 System.Collections.Generic.Dictionary.ValueCollection.Enumerator<UnityEngine.Transform, ProjectileSphereArea>::get_Current()  /*0x0A00026E*/
    IL_0019: stloc.1
    IL_001a: ldloc.1
    IL_001b: ldarg.0
    IL_001c: callvirt bool ProjectileSphereArea::Inside(UnityEngine.Transform)  /*0x060005CA*/
    IL_0021: brfalse.s IL_002c
    IL_0023: ldloc.1
    IL_0024: ldfld Transform ProjectileSphereArea::transform  /*0x04000732*/
    IL_0029: stloc.2
    IL_002a: leave.s IL_0047
    IL_002c: ldloca.s 0
    IL_002e: call bool System.Collections.Generic.Dictionary.ValueCollection.Enumerator<UnityEngine.Transform, ProjectileSphereArea>::MoveNext()  /*0x0A00026F*/
    IL_0033: brtrue.s IL_0012
    IL_0035: leave.s IL_0045
    IL_0037: ldloca.s 0
    IL_0039: constrained. System.Collections.Generic.Dictionary.ValueCollection.Enumerator<UnityEngine.Transform, ProjectileSphereArea>  /*0x1B00006C*/
    IL_003f: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0044: endfinally
    IL_0045: ldnull
    IL_0046: ret
    IL_0047: ldloc.2
    IL_0048: ret
    .try IL_0010-IL_0037 finally handler IL_0037-IL_0045

  .method ProjectileBlock::.ctor()  // token 0x060005CF rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method ProjectileBlock::.cctor()  // token 0x060005D0 rva 0x18b1c attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void System.Collections.Generic.Dictionary<UnityEngine.Transform, ProjectileSphereArea>::.ctor()  /*0x0A000270*/
    IL_0005: stsfld Dictionary<Transform, ProjectileSphereArea> ProjectileBlock::areas  /*0x04000734*/
    IL_000a: ret

// ===== ProjectileBlock/ProjectileTag  (token 0x02000119) =====
