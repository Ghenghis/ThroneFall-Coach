// ===== TriggerOnHealthLoss  (token 0x020002BE) =====
  .method TriggerOnHealthLoss::Start()  // token 0x06000F19 rva 0x43b7c attrs Private, HideBySig
    // code size 55 (0x37), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldarg.0
    IL_0002: ldfld Hp TriggerOnHealthLoss::healthToMonitor  /*0x0400117A*/
    IL_0007: ldfld float Hp::maxHp  /*0x04000A2C*/
    IL_000c: ldarg.0
    IL_000d: ldfld int TriggerOnHealthLoss::healthSegments  /*0x0400117B*/
    IL_0012: conv.r4
    IL_0013: div
    IL_0014: stfld float TriggerOnHealthLoss::healthSegmentSize  /*0x0400117D*/
    IL_0019: ldarg.0
    IL_001a: ldarg.0
    IL_001b: ldfld Hp TriggerOnHealthLoss::healthToMonitor  /*0x0400117A*/
    IL_0020: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_0025: ldarg.0
    IL_0026: ldfld float TriggerOnHealthLoss::healthSegmentSize  /*0x0400117D*/
    IL_002b: div
    IL_002c: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_0031: stfld int TriggerOnHealthLoss::previousSegments  /*0x0400117E*/
    IL_0036: ret

  .method TriggerOnHealthLoss::Update()  // token 0x06000F1A rva 0x43bb4 attrs Private, HideBySig
    // code size 73 (0x49), max stack 2, init locals
    .locals ([0] int, [1] int, [2] int)
    IL_0000: ldarg.0
    IL_0001: ldfld Hp TriggerOnHealthLoss::healthToMonitor  /*0x0400117A*/
    IL_0006: callvirt float Hp::get_HpValue()  /*0x06000812*/
    IL_000b: ldarg.0
    IL_000c: ldfld float TriggerOnHealthLoss::healthSegmentSize  /*0x0400117D*/
    IL_0011: div
    IL_0012: call int UnityEngine.Mathf::CeilToInt(float)  /*0x0A000298*/
    IL_0017: stloc.0
    IL_0018: ldloc.0
    IL_0019: ldarg.0
    IL_001a: ldfld int TriggerOnHealthLoss::previousSegments  /*0x0400117E*/
    IL_001f: bge.s IL_0048
    IL_0021: ldarg.0
    IL_0022: ldfld int TriggerOnHealthLoss::previousSegments  /*0x0400117E*/
    IL_0027: ldloc.0
    IL_0028: sub
    IL_0029: stloc.1
    IL_002a: ldc.i4.0
    IL_002b: stloc.2
    IL_002c: br.s IL_003d
    IL_002e: ldarg.0
    IL_002f: ldfld UnityEvent TriggerOnHealthLoss::onHealthSegmentLost  /*0x0400117C*/
    IL_0034: callvirt void UnityEngine.Events.UnityEvent::Invoke()  /*0x0A00006B*/
    IL_0039: ldloc.2
    IL_003a: ldc.i4.1
    IL_003b: add
    IL_003c: stloc.2
    IL_003d: ldloc.2
    IL_003e: ldloc.1
    IL_003f: blt.s IL_002e
    IL_0041: ldarg.0
    IL_0042: ldloc.0
    IL_0043: stfld int TriggerOnHealthLoss::previousSegments  /*0x0400117E*/
    IL_0048: ret

  .method TriggerOnHealthLoss::.ctor()  // token 0x06000F1B rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

