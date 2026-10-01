// ===== MainThreadDispatcher  (token 0x02000180) =====
  .method MainThreadDispatcher::Awake()  // token 0x060007B1 rva 0x25dd6 attrs Private, HideBySig
    // code size 43 (0x2b), max stack 8
    IL_0000: ldsfld MainThreadDispatcher MainThreadDispatcher::Instance  /*0x0400099D*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_001f
    IL_000d: ldarg.0
    IL_000e: stsfld MainThreadDispatcher MainThreadDispatcher::Instance  /*0x0400099D*/
    IL_0013: ldarg.0
    IL_0014: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0019: call void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)  /*0x0A0000C1*/
    IL_001e: ret
    IL_001f: ldarg.0
    IL_0020: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0025: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_002a: ret

  .method MainThreadDispatcher::Update()  // token 0x060007B2 rva 0x25e04 attrs Private, HideBySig
    // code size 62 (0x3e), max stack 2, init locals
    .locals ([0] Queue<Action>, [1] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld Queue<Action> MainThreadDispatcher::_queue  /*0x0400099E*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: ldloc.0
    IL_000a: ldloca.s 1
    IL_000c: call void System.Threading.Monitor::Enter(object,ref bool)  /*0x0A00037D*/
    IL_0011: br.s IL_0023
    IL_0013: ldarg.0
    IL_0014: ldfld Queue<Action> MainThreadDispatcher::_queue  /*0x0400099E*/
    IL_0019: callvirt !0 System.Collections.Generic.Queue<System.Action>::Dequeue()  /*0x0A00037E*/
    IL_001e: callvirt void System.Action::Invoke()  /*0x0A00037F*/
    IL_0023: ldarg.0
    IL_0024: ldfld Queue<Action> MainThreadDispatcher::_queue  /*0x0400099E*/
    IL_0029: callvirt int System.Collections.Generic.Queue<System.Action>::get_Count()  /*0x0A000380*/
    IL_002e: ldc.i4.0
    IL_002f: bgt.s IL_0013
    IL_0031: leave.s IL_003d
    IL_0033: ldloc.1
    IL_0034: brfalse.s IL_003c
    IL_0036: ldloc.0
    IL_0037: call void System.Threading.Monitor::Exit(object)  /*0x0A000381*/
    IL_003c: endfinally
    IL_003d: ret
    .try IL_0009-IL_0033 finally handler IL_0033-IL_003d

  .method MainThreadDispatcher::Enqueue(System.Action)  // token 0x060007B3 rva 0x25e60 attrs Public, HideBySig
    // code size 42 (0x2a), max stack 2, init locals
    .locals ([0] Queue<Action>, [1] bool)
    IL_0000: ldarg.0
    IL_0001: ldfld Queue<Action> MainThreadDispatcher::_queue  /*0x0400099E*/
    IL_0006: stloc.0
    IL_0007: ldc.i4.0
    IL_0008: stloc.1
    IL_0009: ldloc.0
    IL_000a: ldloca.s 1
    IL_000c: call void System.Threading.Monitor::Enter(object,ref bool)  /*0x0A00037D*/
    IL_0011: ldarg.0
    IL_0012: ldfld Queue<Action> MainThreadDispatcher::_queue  /*0x0400099E*/
    IL_0017: ldarg.1
    IL_0018: callvirt void System.Collections.Generic.Queue<System.Action>::Enqueue(!0)  /*0x0A000382*/
    IL_001d: leave.s IL_0029
    IL_001f: ldloc.1
    IL_0020: brfalse.s IL_0028
    IL_0022: ldloc.0
    IL_0023: call void System.Threading.Monitor::Exit(object)  /*0x0A000381*/
    IL_0028: endfinally
    IL_0029: ret
    .try IL_0009-IL_001f finally handler IL_001f-IL_0029

  .method MainThreadDispatcher::.ctor()  // token 0x060007B4 rva 0x25ea8 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.Queue<System.Action>::.ctor()  /*0x0A000383*/
    IL_0006: stfld Queue<Action> MainThreadDispatcher::_queue  /*0x0400099E*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

