// ===== QuestOverallProgressDisplay  (token 0x02000333) =====
  .method QuestOverallProgressDisplay::Start()  // token 0x06001196 rva 0x5484a attrs Private, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_0006: stfld PerkManager QuestOverallProgressDisplay::perkManager  /*0x0400152F*/
    IL_000b: ret

  .method QuestOverallProgressDisplay::Update()  // token 0x06001197 rva 0x54858 attrs Private, HideBySig
    // code size 336 (0x150), max stack 6, init locals
    .locals ([0] int, [1] int, [2] int)
    IL_0000: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000011*/
    IL_000b: brfalse.s IL_000e
    IL_000d: ret
    IL_000e: nop
    IL_000f: ldsfld LevelProgressManager LevelProgressManager::instance  /*0x04000BB6*/
    IL_0014: dup
    IL_0015: callvirt int LevelProgressManager::CrownsAchieved()  /*0x0600094E*/
    IL_001a: stloc.1
    IL_001b: dup
    IL_001c: callvirt int LevelProgressManager::CrownsAvailabe()  /*0x0600094D*/
    IL_0021: stloc.2
    IL_0022: ldnull
    IL_0023: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0028: brfalse.s IL_004d
    IL_002a: ldarg.0
    IL_002b: ldfld TextMeshProUGUI QuestOverallProgressDisplay::questDisplay  /*0x04001528*/
    IL_0030: ldloca.s 1
    IL_0032: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0037: ldstr "<font=PTSerif-Bold SDF>/</font>"
    IL_003c: ldloca.s 2
    IL_003e: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0043: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0048: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_004d: leave.s IL_0062
    IL_004f: pop
    IL_0050: ldarg.0
    IL_0051: ldfld TextMeshProUGUI QuestOverallProgressDisplay::questDisplay  /*0x04001528*/
    IL_0056: ldstr "Unknown Error"
    IL_005b: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0060: leave.s IL_0062
    IL_0062: ldarg.0
    IL_0063: ldfld TextMeshProUGUI QuestOverallProgressDisplay::levelDisplay  /*0x04001529*/
    IL_0068: ldstr "Menu/Level"
    IL_006d: ldc.i4.1
    IL_006e: ldc.i4.0
    IL_006f: ldc.i4.1
    IL_0070: ldc.i4.1
    IL_0071: call string TextTranslator::Translate(string,bool,int,bool,bool)  /*0x060009E2*/
    IL_0076: ldstr " <style=\"Body Numerals\">"
    IL_007b: ldarg.0
    IL_007c: ldfld PerkManager QuestOverallProgressDisplay::perkManager  /*0x0400152F*/
    IL_0081: ldflda int PerkManager::level  /*0x04000BEC*/
    IL_0086: call string System.Int32::ToString()  /*0x0A000031*/
    IL_008b: call string System.String::Concat(string,string,string)  /*0x0A000032*/
    IL_0090: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0095: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_009a: ldfld int PerkManager::level  /*0x04000BEC*/
    IL_009f: ldsfld PerkManager PerkManager::instance  /*0x04000BE6*/
    IL_00a4: callvirt List<MetaLevel> PerkManager::get_MetaLevels()  /*0x0600097B*/
    IL_00a9: callvirt int System.Collections.Generic.List<MetaLevel>::get_Count()  /*0x0A000454*/
    IL_00ae: sub
    IL_00af: ldc.i4.1
    IL_00b0: sub
    IL_00b1: stloc.0
    IL_00b2: ldloc.0
    IL_00b3: ldc.i4.0
    IL_00b4: ble.s IL_010c
    IL_00b6: ldarg.0
    IL_00b7: ldfld RectTransform QuestOverallProgressDisplay::backgroundRect  /*0x0400152C*/
    IL_00bc: ldarg.0
    IL_00bd: ldfld RectTransform QuestOverallProgressDisplay::backgroundRect  /*0x0400152C*/
    IL_00c2: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_00c7: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_00cc: ldarg.0
    IL_00cd: ldfld float QuestOverallProgressDisplay::withTrophyBackgroundHeight  /*0x0400152E*/
    IL_00d2: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_00d7: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_00dc: ldarg.0
    IL_00dd: ldfld TextMeshProUGUI QuestOverallProgressDisplay::trophyDisplay  /*0x0400152A*/
    IL_00e2: ldloca.s 0
    IL_00e4: call string System.Int32::ToString()  /*0x0A000031*/
    IL_00e9: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_00ee: ldarg.0
    IL_00ef: ldfld TextMeshProUGUI QuestOverallProgressDisplay::trophyDisplay  /*0x0400152A*/
    IL_00f4: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00f9: ldc.i4.1
    IL_00fa: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00ff: ldarg.0
    IL_0100: ldfld GameObject QuestOverallProgressDisplay::trophyImage  /*0x0400152B*/
    IL_0105: ldc.i4.1
    IL_0106: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_010b: ret
    IL_010c: ldarg.0
    IL_010d: ldfld RectTransform QuestOverallProgressDisplay::backgroundRect  /*0x0400152C*/
    IL_0112: ldarg.0
    IL_0113: ldfld RectTransform QuestOverallProgressDisplay::backgroundRect  /*0x0400152C*/
    IL_0118: callvirt Vector2 UnityEngine.RectTransform::get_sizeDelta()  /*0x0A000655*/
    IL_011d: ldfld float UnityEngine.Vector2::x  /*0x0A000152*/
    IL_0122: ldarg.0
    IL_0123: ldfld float QuestOverallProgressDisplay::defaultBackgroundHeight  /*0x0400152D*/
    IL_0128: newobj void UnityEngine.Vector2::.ctor(float,float)  /*0x0A000153*/
    IL_012d: callvirt void UnityEngine.RectTransform::set_sizeDelta(UnityEngine.Vector2)  /*0x0A000665*/
    IL_0132: ldarg.0
    IL_0133: ldfld TextMeshProUGUI QuestOverallProgressDisplay::trophyDisplay  /*0x0400152A*/
    IL_0138: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_013d: ldc.i4.0
    IL_013e: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0143: ldarg.0
    IL_0144: ldfld GameObject QuestOverallProgressDisplay::trophyImage  /*0x0400152B*/
    IL_0149: ldc.i4.0
    IL_014a: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_014f: ret
    .try IL_000f-IL_004f catch System.Object handler IL_004f-IL_0062

  .method QuestOverallProgressDisplay::.ctor()  // token 0x06001198 rva 0x549c4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 29 (0x1d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.r4 89f
    IL_0006: stfld float QuestOverallProgressDisplay::defaultBackgroundHeight  /*0x0400152D*/
    IL_000b: ldarg.0
    IL_000c: ldc.r4 120f
    IL_0011: stfld float QuestOverallProgressDisplay::withTrophyBackgroundHeight  /*0x0400152E*/
    IL_0016: ldarg.0
    IL_0017: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_001c: ret

