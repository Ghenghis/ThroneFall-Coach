// ===== QuestTagUI  (token 0x02000334) =====
  .method QuestTagUI::UpdateVisualization(Quest,LevelData)  // token 0x06001199 rva 0x549e4 attrs Public, HideBySig
    // code size 780 (0x30c), max stack 3, init locals
    .locals ([0] bool, [1] Quest.EType)
    IL_0000: ldarg.1
    IL_0001: brfalse.s IL_0006
    IL_0003: ldarg.2
    IL_0004: brtrue.s IL_0013
    IL_0006: ldarg.0
    IL_0007: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_000c: ldc.i4.0
    IL_000d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0012: ret
    IL_0013: ldarg.0
    IL_0014: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0019: ldc.i4.1
    IL_001a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_001f: ldarg.1
    IL_0020: ldarg.2
    IL_0021: callvirt bool Quest::CheckBeaten(LevelData)  /*0x06000CA5*/
    IL_0026: stloc.0
    IL_0027: ldarg.0
    IL_0028: ldfld Image QuestTagUI::completeImage  /*0x04001530*/
    IL_002d: ldloc.0
    IL_002e: brtrue.s IL_0038
    IL_0030: ldarg.0
    IL_0031: ldfld Color QuestTagUI::incompleteColor  /*0x04001532*/
    IL_0036: br.s IL_003e
    IL_0038: ldarg.0
    IL_0039: ldfld Color QuestTagUI::completeColor  /*0x04001531*/
    IL_003e: callvirt void UnityEngine.UI.Graphic::set_color(UnityEngine.Color)  /*0x0A000367*/
    IL_0043: ldarg.0
    IL_0044: ldfld GameObject QuestTagUI::crossedOut1  /*0x04001535*/
    IL_0049: ldc.i4.0
    IL_004a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_004f: ldarg.0
    IL_0050: ldfld GameObject QuestTagUI::crossedOut2  /*0x04001537*/
    IL_0055: ldc.i4.0
    IL_0056: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_005b: ldarg.0
    IL_005c: ldfld GameObject QuestTagUI::crossedOut3  /*0x04001539*/
    IL_0061: ldc.i4.0
    IL_0062: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0067: ldarg.0
    IL_0068: ldfld Image QuestTagUI::icon1  /*0x04001534*/
    IL_006d: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0072: ldc.i4.0
    IL_0073: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0078: ldarg.0
    IL_0079: ldfld Image QuestTagUI::icon2  /*0x04001536*/
    IL_007e: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0083: ldc.i4.0
    IL_0084: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0089: ldarg.0
    IL_008a: ldfld Image QuestTagUI::icon3  /*0x04001538*/
    IL_008f: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0094: ldc.i4.0
    IL_0095: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_009a: ldarg.0
    IL_009b: ldfld TMP_Text QuestTagUI::goalNumber  /*0x0400153A*/
    IL_00a0: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00a5: ldc.i4.0
    IL_00a6: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00ab: ldarg.1
    IL_00ac: ldfld Quest.EType Quest::questType  /*0x04000F4E*/
    IL_00b1: stloc.1
    IL_00b2: ldloc.1
    IL_00b3: switch (IL_00c9, IL_0114, IL_00db, IL_01fe)
    IL_00c8: ret
    IL_00c9: ldarg.0
    IL_00ca: ldfld TMP_Text QuestTagUI::description  /*0x04001533*/
    IL_00cf: ldarg.0
    IL_00d0: ldfld string QuestTagUI::completeLevel  /*0x0400153B*/
    IL_00d5: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00da: ret
    IL_00db: ldarg.0
    IL_00dc: ldfld TMP_Text QuestTagUI::description  /*0x04001533*/
    IL_00e1: ldarg.0
    IL_00e2: ldfld string QuestTagUI::achieveScoreOf  /*0x0400153C*/
    IL_00e7: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00ec: ldarg.0
    IL_00ed: ldfld TMP_Text QuestTagUI::goalNumber  /*0x0400153A*/
    IL_00f2: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00f7: ldc.i4.1
    IL_00f8: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00fd: ldarg.0
    IL_00fe: ldfld TMP_Text QuestTagUI::goalNumber  /*0x0400153A*/
    IL_0103: ldarg.1
    IL_0104: ldflda int Quest::achieveScoreOf  /*0x04000F50*/
    IL_0109: call string System.Int32::ToString()  /*0x0A000031*/
    IL_010e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0113: ret
    IL_0114: ldarg.0
    IL_0115: ldfld Image QuestTagUI::icon1  /*0x04001534*/
    IL_011a: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_011f: ldarg.1
    IL_0120: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_0125: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_012a: ldc.i4.0
    IL_012b: cgt
    IL_012d: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0132: ldarg.0
    IL_0133: ldfld Image QuestTagUI::icon2  /*0x04001536*/
    IL_0138: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_013d: ldarg.1
    IL_013e: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_0143: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0148: ldc.i4.1
    IL_0149: cgt
    IL_014b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0150: ldarg.0
    IL_0151: ldfld Image QuestTagUI::icon3  /*0x04001538*/
    IL_0156: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_015b: ldarg.1
    IL_015c: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_0161: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0166: ldc.i4.2
    IL_0167: cgt
    IL_0169: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_016e: ldarg.1
    IL_016f: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_0174: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0179: ldc.i4.0
    IL_017a: ble.s IL_0198
    IL_017c: ldarg.0
    IL_017d: ldfld Image QuestTagUI::icon1  /*0x04001534*/
    IL_0182: ldarg.1
    IL_0183: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_0188: ldc.i4.0
    IL_0189: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_018e: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_0193: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_0198: ldarg.1
    IL_0199: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_019e: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_01a3: ldc.i4.1
    IL_01a4: ble.s IL_01c2
    IL_01a6: ldarg.0
    IL_01a7: ldfld Image QuestTagUI::icon2  /*0x04001536*/
    IL_01ac: ldarg.1
    IL_01ad: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_01b2: ldc.i4.1
    IL_01b3: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_01b8: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_01bd: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_01c2: ldarg.1
    IL_01c3: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_01c8: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_01cd: ldc.i4.2
    IL_01ce: ble.s IL_01ec
    IL_01d0: ldarg.0
    IL_01d1: ldfld Image QuestTagUI::icon3  /*0x04001538*/
    IL_01d6: ldarg.1
    IL_01d7: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_01dc: ldc.i4.2
    IL_01dd: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_01e2: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_01e7: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_01ec: ldarg.0
    IL_01ed: ldfld TMP_Text QuestTagUI::description  /*0x04001533*/
    IL_01f2: ldarg.0
    IL_01f3: ldfld string QuestTagUI::winWith  /*0x0400153D*/
    IL_01f8: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_01fd: ret
    IL_01fe: ldarg.0
    IL_01ff: ldfld TMP_Text QuestTagUI::description  /*0x04001533*/
    IL_0204: ldarg.0
    IL_0205: ldfld string QuestTagUI::winWithout  /*0x0400153E*/
    IL_020a: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_020f: ldarg.0
    IL_0210: ldfld GameObject QuestTagUI::crossedOut1  /*0x04001535*/
    IL_0215: ldc.i4.1
    IL_0216: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_021b: ldarg.0
    IL_021c: ldfld GameObject QuestTagUI::crossedOut2  /*0x04001537*/
    IL_0221: ldc.i4.1
    IL_0222: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0227: ldarg.0
    IL_0228: ldfld GameObject QuestTagUI::crossedOut3  /*0x04001539*/
    IL_022d: ldc.i4.1
    IL_022e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0233: ldarg.0
    IL_0234: ldfld Image QuestTagUI::icon1  /*0x04001534*/
    IL_0239: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_023e: ldarg.1
    IL_023f: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_0244: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0249: ldc.i4.0
    IL_024a: cgt
    IL_024c: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0251: ldarg.0
    IL_0252: ldfld Image QuestTagUI::icon2  /*0x04001536*/
    IL_0257: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_025c: ldarg.1
    IL_025d: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_0262: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0267: ldc.i4.1
    IL_0268: cgt
    IL_026a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_026f: ldarg.0
    IL_0270: ldfld Image QuestTagUI::icon3  /*0x04001538*/
    IL_0275: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_027a: ldarg.1
    IL_027b: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_0280: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0285: ldc.i4.2
    IL_0286: cgt
    IL_0288: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_028d: ldarg.1
    IL_028e: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_0293: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_0298: ldc.i4.0
    IL_0299: ble.s IL_02b7
    IL_029b: ldarg.0
    IL_029c: ldfld Image QuestTagUI::icon1  /*0x04001534*/
    IL_02a1: ldarg.1
    IL_02a2: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_02a7: ldc.i4.0
    IL_02a8: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_02ad: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_02b2: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_02b7: ldarg.1
    IL_02b8: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_02bd: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_02c2: ldc.i4.1
    IL_02c3: ble.s IL_02e1
    IL_02c5: ldarg.0
    IL_02c6: ldfld Image QuestTagUI::icon3  /*0x04001538*/
    IL_02cb: ldarg.1
    IL_02cc: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_02d1: ldc.i4.1
    IL_02d2: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_02d7: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_02dc: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_02e1: ldarg.1
    IL_02e2: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_02e7: callvirt int System.Collections.Generic.List<Equippable>::get_Count()  /*0x0A0002D9*/
    IL_02ec: ldc.i4.2
    IL_02ed: ble.s IL_030b
    IL_02ef: ldarg.0
    IL_02f0: ldfld Image QuestTagUI::icon3  /*0x04001538*/
    IL_02f5: ldarg.1
    IL_02f6: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_02fb: ldc.i4.2
    IL_02fc: callvirt !0 System.Collections.Generic.List<Equippable>::get_Item(int)  /*0x0A0002DA*/
    IL_0301: ldfld Sprite Equippable::icon  /*0x04000E2A*/
    IL_0306: callvirt void UnityEngine.UI.Image::set_sprite(UnityEngine.Sprite)  /*0x0A000044*/
    IL_030b: ret

  .method QuestTagUI::.ctor()  // token 0x0600119A rva 0x54cfc attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 51 (0x33), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr "Achieve a victory."
    IL_0006: stfld string QuestTagUI::completeLevel  /*0x0400153B*/
    IL_000b: ldarg.0
    IL_000c: ldstr "Achieve score:"
    IL_0011: stfld string QuestTagUI::achieveScoreOf  /*0x0400153C*/
    IL_0016: ldarg.0
    IL_0017: ldstr "Win with:"
    IL_001c: stfld string QuestTagUI::winWith  /*0x0400153D*/
    IL_0021: ldarg.0
    IL_0022: ldstr "Win without:"
    IL_0027: stfld string QuestTagUI::winWithout  /*0x0400153E*/
    IL_002c: ldarg.0
    IL_002d: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0032: ret

