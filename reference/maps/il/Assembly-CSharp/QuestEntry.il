// ===== QuestEntry  (token 0x02000331) =====
  .method QuestEntry::Init(Quest,int,bool)  // token 0x06001192 rva 0x54528 attrs Public, HideBySig
    // code size 673 (0x2a1), max stack 6, init locals
    .locals ([0] string, [1] Quest.EType, [2] List.Enumerator<Equippable>, [3] Equippable, [4] Equippable)
    IL_0000: ldstr "<style=\"Body Bold Italic\">"
    IL_0005: stloc.0
    IL_0006: ldarg.2
    IL_0007: switch (IL_002e, IL_003c, IL_004a, IL_0058, IL_0066, IL_0074, IL_0082, IL_0090)
    IL_002c: br.s IL_009c
    IL_002e: ldloc.0
    IL_002f: ldstr "A."
    IL_0034: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0039: stloc.0
    IL_003a: br.s IL_009c
    IL_003c: ldloc.0
    IL_003d: ldstr "B."
    IL_0042: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0047: stloc.0
    IL_0048: br.s IL_009c
    IL_004a: ldloc.0
    IL_004b: ldstr "C."
    IL_0050: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0055: stloc.0
    IL_0056: br.s IL_009c
    IL_0058: ldloc.0
    IL_0059: ldstr "D."
    IL_005e: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0063: stloc.0
    IL_0064: br.s IL_009c
    IL_0066: ldloc.0
    IL_0067: ldstr "E."
    IL_006c: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0071: stloc.0
    IL_0072: br.s IL_009c
    IL_0074: ldloc.0
    IL_0075: ldstr "F."
    IL_007a: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_007f: stloc.0
    IL_0080: br.s IL_009c
    IL_0082: ldloc.0
    IL_0083: ldstr "G."
    IL_0088: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_008d: stloc.0
    IL_008e: br.s IL_009c
    IL_0090: ldloc.0
    IL_0091: ldstr "H."
    IL_0096: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_009b: stloc.0
    IL_009c: ldloc.0
    IL_009d: ldstr " "
    IL_00a2: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00a7: stloc.0
    IL_00a8: ldloc.0
    IL_00a9: ldstr "<style=\"Body Light\">"
    IL_00ae: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_00b3: stloc.0
    IL_00b4: ldarg.1
    IL_00b5: ldfld Quest.EType Quest::questType  /*0x04000F4E*/
    IL_00ba: stloc.1
    IL_00bb: ldloc.1
    IL_00bc: switch (IL_0123, IL_015a, IL_00d6, IL_01da)
    IL_00d1: br IL_0259
    IL_00d6: ldarg.0
    IL_00d7: ldfld GameObject QuestEntry::equippableConditionsParent  /*0x04001525*/
    IL_00dc: ldc.i4.0
    IL_00dd: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00e2: ldarg.0
    IL_00e3: ldfld TextMeshProUGUI QuestEntry::numericalCondition  /*0x04001524*/
    IL_00e8: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00ed: ldc.i4.1
    IL_00ee: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00f3: ldarg.0
    IL_00f4: ldfld TextMeshProUGUI QuestEntry::numericalCondition  /*0x04001524*/
    IL_00f9: ldarg.1
    IL_00fa: ldflda int Quest::achieveScoreOf  /*0x04000F50*/
    IL_00ff: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0104: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0109: ldloc.0
    IL_010a: ldstr "Quests/Achieve Score"
    IL_010f: ldc.i4.1
    IL_0110: ldc.i4.0
    IL_0111: ldc.i4.1
    IL_0112: ldc.i4.1
    IL_0113: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0118: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_011d: stloc.0
    IL_011e: br IL_0259
    IL_0123: ldarg.0
    IL_0124: ldfld GameObject QuestEntry::equippableConditionsParent  /*0x04001525*/
    IL_0129: ldc.i4.0
    IL_012a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_012f: ldarg.0
    IL_0130: ldfld TextMeshProUGUI QuestEntry::numericalCondition  /*0x04001524*/
    IL_0135: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_013a: ldc.i4.0
    IL_013b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0140: ldloc.0
    IL_0141: ldstr "Quests/Achieve Victory"
    IL_0146: ldc.i4.1
    IL_0147: ldc.i4.0
    IL_0148: ldc.i4.1
    IL_0149: ldc.i4.1
    IL_014a: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_014f: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0154: stloc.0
    IL_0155: br IL_0259
    IL_015a: ldarg.0
    IL_015b: ldfld GameObject QuestEntry::equippableConditionsParent  /*0x04001525*/
    IL_0160: ldc.i4.1
    IL_0161: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0166: ldarg.0
    IL_0167: ldfld TextMeshProUGUI QuestEntry::numericalCondition  /*0x04001524*/
    IL_016c: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0171: ldc.i4.0
    IL_0172: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0177: ldloc.0
    IL_0178: ldstr "Quests/Achieve Victory With"
    IL_017d: ldc.i4.1
    IL_017e: ldc.i4.0
    IL_017f: ldc.i4.1
    IL_0180: ldc.i4.1
    IL_0181: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0186: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_018b: stloc.0
    IL_018c: ldarg.1
    IL_018d: ldfld List<Equippable> Quest::beatTheLevelWith  /*0x04000F4F*/
    IL_0192: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0197: stloc.2
    IL_0198: br.s IL_01be
    IL_019a: ldloca.s 2
    IL_019c: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_01a1: stloc.3
    IL_01a2: ldarg.0
    IL_01a3: ldfld QuestConditionEquippable QuestEntry::equippableConditionPrefab  /*0x04001526*/
    IL_01a8: ldarg.0
    IL_01a9: ldfld GameObject QuestEntry::equippableConditionsParent  /*0x04001525*/
    IL_01ae: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_01b3: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<QuestConditionEquippable>  /*0x2B000101*/
    IL_01b8: ldloc.3
    IL_01b9: callvirt void QuestConditionEquippable::SetData(Equippable)  /*0x06001190*/
    IL_01be: ldloca.s 2
    IL_01c0: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_01c5: brtrue.s IL_019a
    IL_01c7: leave IL_0259
    IL_01cc: ldloca.s 2
    IL_01ce: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_01d4: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_01d9: endfinally
    IL_01da: ldarg.0
    IL_01db: ldfld GameObject QuestEntry::equippableConditionsParent  /*0x04001525*/
    IL_01e0: ldc.i4.1
    IL_01e1: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01e6: ldarg.0
    IL_01e7: ldfld TextMeshProUGUI QuestEntry::numericalCondition  /*0x04001524*/
    IL_01ec: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_01f1: ldc.i4.0
    IL_01f2: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_01f7: ldloc.0
    IL_01f8: ldstr "Quests/Achieve Victory Without"
    IL_01fd: ldc.i4.1
    IL_01fe: ldc.i4.0
    IL_01ff: ldc.i4.1
    IL_0200: ldc.i4.1
    IL_0201: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0206: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_020b: stloc.0
    IL_020c: ldarg.1
    IL_020d: ldfld List<Equippable> Quest::beatTheLevelWithout  /*0x04000F51*/
    IL_0212: callvirt List.Enumerator<!0> System.Collections.Generic.List<Equippable>::GetEnumerator()  /*0x0A0002E3*/
    IL_0217: stloc.2
    IL_0218: br.s IL_0240
    IL_021a: ldloca.s 2
    IL_021c: call !0 System.Collections.Generic.List.Enumerator<Equippable>::get_Current()  /*0x0A0002E4*/
    IL_0221: stloc.s 4
    IL_0223: ldarg.0
    IL_0224: ldfld QuestConditionEquippable QuestEntry::equippableConditionPrefab  /*0x04001526*/
    IL_0229: ldarg.0
    IL_022a: ldfld GameObject QuestEntry::equippableConditionsParent  /*0x04001525*/
    IL_022f: callvirt Transform UnityEngine.GameObject::get_transform()  /*0x0A000064*/
    IL_0234: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<QuestConditionEquippable>  /*0x2B000101*/
    IL_0239: ldloc.s 4
    IL_023b: callvirt void QuestConditionEquippable::SetData(Equippable)  /*0x06001190*/
    IL_0240: ldloca.s 2
    IL_0242: call bool System.Collections.Generic.List.Enumerator<Equippable>::MoveNext()  /*0x0A0002E7*/
    IL_0247: brtrue.s IL_021a
    IL_0249: leave.s IL_0259
    IL_024b: ldloca.s 2
    IL_024d: constrained. System.Collections.Generic.List.Enumerator<Equippable>  /*0x1B000085*/
    IL_0253: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0258: endfinally
    IL_0259: ldarg.0
    IL_025a: ldfld TextMeshProUGUI QuestEntry::questText  /*0x04001523*/
    IL_025f: ldloc.0
    IL_0260: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0265: ldarg.3
    IL_0266: brfalse.s IL_02a0
    IL_0268: ldarg.0
    IL_0269: ldfld CanvasGroup QuestEntry::canvasGroup  /*0x04001527*/
    IL_026e: ldc.r4 0.1f
    IL_0273: callvirt void UnityEngine.CanvasGroup::set_alpha(float)  /*0x0A000609*/
    IL_0278: ldarg.0
    IL_0279: ldfld TextMeshProUGUI QuestEntry::questText  /*0x04001523*/
    IL_027e: ldarg.0
    IL_027f: ldfld TextMeshProUGUI QuestEntry::questText  /*0x04001523*/
    IL_0284: callvirt string TMPro.TMP_Text::get_text()  /*0x0A0005FF*/
    IL_0289: callvirt string System.String::ToUpper()  /*0x0A0006FE*/
    IL_028e: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0293: ldarg.0
    IL_0294: ldfld TextMeshProUGUI QuestEntry::questText  /*0x04001523*/
    IL_0299: ldc.i4.s 64
    IL_029b: callvirt void TMPro.TMP_Text::set_fontStyle(TMPro.FontStyles)  /*0x0A0006FF*/
    IL_02a0: ret
    .try IL_0198-IL_01cc finally handler IL_01cc-IL_01da
    .try IL_0218-IL_024b finally handler IL_024b-IL_0259

  .method QuestEntry::.ctor()  // token 0x06001193 rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

