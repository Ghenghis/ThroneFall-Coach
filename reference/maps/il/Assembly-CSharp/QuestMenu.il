// ===== QuestMenu  (token 0x02000332) =====
  .method QuestMenu::UpdateVisualization(LevelData,System.Collections.Generic.List<Quest>)  // token 0x06001194 rva 0x547f4 attrs Public, HideBySig
    // code size 74 (0x4a), max stack 3, init locals
    .locals ([0] int, [1] QuestTagUI)
    IL_0000: ldc.i4.0
    IL_0001: stloc.0
    IL_0002: br.s IL_003b
    IL_0004: ldarg.0
    IL_0005: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_000a: ldloc.0
    IL_000b: callvirt Transform UnityEngine.Transform::GetChild(int)  /*0x0A0001B7*/
    IL_0010: callvirt !!0 UnityEngine.Component::GetComponent()<QuestTagUI>  /*0x2B000102*/
    IL_0015: stloc.1
    IL_0016: ldloc.0
    IL_0017: ldarg.2
    IL_0018: callvirt int System.Collections.Generic.List<Quest>::get_Count()  /*0x0A0003D7*/
    IL_001d: bge.s IL_002f
    IL_001f: ldloc.1
    IL_0020: ldarg.2
    IL_0021: ldloc.0
    IL_0022: callvirt !0 System.Collections.Generic.List<Quest>::get_Item(int)  /*0x0A0003D6*/
    IL_0027: ldarg.1
    IL_0028: callvirt void QuestTagUI::UpdateVisualization(Quest,LevelData)  /*0x06001199*/
    IL_002d: br.s IL_0037
    IL_002f: ldloc.1
    IL_0030: ldnull
    IL_0031: ldnull
    IL_0032: callvirt void QuestTagUI::UpdateVisualization(Quest,LevelData)  /*0x06001199*/
    IL_0037: ldloc.0
    IL_0038: ldc.i4.1
    IL_0039: add
    IL_003a: stloc.0
    IL_003b: ldloc.0
    IL_003c: ldarg.0
    IL_003d: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0042: callvirt int UnityEngine.Transform::get_childCount()  /*0x0A0001B6*/
    IL_0047: blt.s IL_0004
    IL_0049: ret

  .method QuestMenu::.ctor()  // token 0x06001195 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

