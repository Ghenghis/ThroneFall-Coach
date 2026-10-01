// ===== UnitySerializedDictionary`2  (token 0x020001D1) =====
  .method UnitySerializedDictionary::UnityEngine.ISerializationCallbackReceiver.OnAfterDeserialize()  // token 0x06000953 rva 0x2c778 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 73 (0x49), max stack 4, init locals
    .locals ([0] int)
    IL_0000: ldarg.0
    IL_0001: call void System.Collections.Generic.Dictionary<!0, !1>::Clear()  /*0x0A000433*/
    IL_0006: ldc.i4.0
    IL_0007: stloc.0
    IL_0008: br.s IL_002c
    IL_000a: ldarg.0
    IL_000b: ldarg.0
    IL_000c: ldfld List<!0> UnitySerializedDictionary<!0, !1>::keyData  /*0x0A000434*/
    IL_0011: ldloc.0
    IL_0012: callvirt !0 System.Collections.Generic.List<!0>::get_Item(int)  /*0x0A000435*/
    IL_0017: ldarg.0
    IL_0018: ldfld List<!1> UnitySerializedDictionary<!0, !1>::valueData  /*0x0A000436*/
    IL_001d: ldloc.0
    IL_001e: callvirt !0 System.Collections.Generic.List<!1>::get_Item(int)  /*0x0A000437*/
    IL_0023: call void System.Collections.Generic.Dictionary<!0, !1>::set_Item(!0,!1)  /*0x0A000438*/
    IL_0028: ldloc.0
    IL_0029: ldc.i4.1
    IL_002a: add
    IL_002b: stloc.0
    IL_002c: ldloc.0
    IL_002d: ldarg.0
    IL_002e: ldfld List<!0> UnitySerializedDictionary<!0, !1>::keyData  /*0x0A000434*/
    IL_0033: callvirt int System.Collections.Generic.List<!0>::get_Count()  /*0x0A000439*/
    IL_0038: bge.s IL_0048
    IL_003a: ldloc.0
    IL_003b: ldarg.0
    IL_003c: ldfld List<!1> UnitySerializedDictionary<!0, !1>::valueData  /*0x0A000436*/
    IL_0041: callvirt int System.Collections.Generic.List<!1>::get_Count()  /*0x0A00043A*/
    IL_0046: blt.s IL_000a
    IL_0048: ret

  .method UnitySerializedDictionary::UnityEngine.ISerializationCallbackReceiver.OnBeforeSerialize()  // token 0x06000954 rva 0x2c7d0 attrs Private, Final, Virtual, HideBySig, VtableLayoutMask
    // code size 101 (0x65), max stack 2, init locals
    .locals ([0] Dictionary.Enumerator<!0, !1>, [1] KeyValuePair<!0, !1>)
    IL_0000: ldarg.0
    IL_0001: ldfld List<!0> UnitySerializedDictionary<!0, !1>::keyData  /*0x0A000434*/
    IL_0006: callvirt void System.Collections.Generic.List<!0>::Clear()  /*0x0A00043C*/
    IL_000b: ldarg.0
    IL_000c: ldfld List<!1> UnitySerializedDictionary<!0, !1>::valueData  /*0x0A000436*/
    IL_0011: callvirt void System.Collections.Generic.List<!1>::Clear()  /*0x0A00043D*/
    IL_0016: ldarg.0
    IL_0017: call Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<!0, !1>::GetEnumerator()  /*0x0A00043E*/
    IL_001c: stloc.0
    IL_001d: br.s IL_004b
    IL_001f: ldloca.s 0
    IL_0021: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<!0, !1>::get_Current()  /*0x0A00043F*/
    IL_0026: stloc.1
    IL_0027: ldarg.0
    IL_0028: ldfld List<!0> UnitySerializedDictionary<!0, !1>::keyData  /*0x0A000434*/
    IL_002d: ldloca.s 1
    IL_002f: call !0 System.Collections.Generic.KeyValuePair<!0, !1>::get_Key()  /*0x0A000440*/
    IL_0034: callvirt void System.Collections.Generic.List<!0>::Add(!0)  /*0x0A000441*/
    IL_0039: ldarg.0
    IL_003a: ldfld List<!1> UnitySerializedDictionary<!0, !1>::valueData  /*0x0A000436*/
    IL_003f: ldloca.s 1
    IL_0041: call !1 System.Collections.Generic.KeyValuePair<!0, !1>::get_Value()  /*0x0A000442*/
    IL_0046: callvirt void System.Collections.Generic.List<!1>::Add(!0)  /*0x0A000443*/
    IL_004b: ldloca.s 0
    IL_004d: call bool System.Collections.Generic.Dictionary.Enumerator<!0, !1>::MoveNext()  /*0x0A000444*/
    IL_0052: brtrue.s IL_001f
    IL_0054: leave.s IL_0064
    IL_0056: ldloca.s 0
    IL_0058: constrained. System.Collections.Generic.Dictionary.Enumerator<!0, !1>  /*0x1B0000C6*/
    IL_005e: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0063: endfinally
    IL_0064: ret
    .try IL_001d-IL_0056 finally handler IL_0056-IL_0064

  .method UnitySerializedDictionary::.ctor()  // token 0x06000955 rva 0x2c854 attrs Family, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<!0>::.ctor()  /*0x0A000446*/
    IL_0006: stfld List<!0> UnitySerializedDictionary<!0, !1>::keyData  /*0x0A000434*/
    IL_000b: ldarg.0
    IL_000c: newobj void System.Collections.Generic.List<!1>::.ctor()  /*0x0A000447*/
    IL_0011: stfld List<!1> UnitySerializedDictionary<!0, !1>::valueData  /*0x0A000436*/
    IL_0016: ldarg.0
    IL_0017: call void System.Collections.Generic.Dictionary<!0, !1>::.ctor()  /*0x0A000448*/
    IL_001c: ret

