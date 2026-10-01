// ===== NightPreviewElement  (token 0x02000325) =====
  .method NightPreviewElement::SetData(WaveInfo)  // token 0x06001158 rva 0x51cc4 attrs Public, HideBySig
    // code size 297 (0x129), max stack 4, init locals
    .locals ([0] int, [1] List.Enumerator<TFUIEnemy>, [2] int, [3] int)
    IL_0000: ldarg.0
    IL_0001: ldfld List<TFUIEnemy> NightPreviewElement::enemyTFUIs  /*0x040014BC*/
    IL_0006: callvirt List.Enumerator<!0> System.Collections.Generic.List<TFUIEnemy>::GetEnumerator()  /*0x0A0006E4*/
    IL_000b: stloc.1
    IL_000c: br.s IL_0020
    IL_000e: ldloca.s 1
    IL_0010: call !0 System.Collections.Generic.List.Enumerator<TFUIEnemy>::get_Current()  /*0x0A0006E5*/
    IL_0015: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_001a: ldc.i4.0
    IL_001b: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0020: ldloca.s 1
    IL_0022: call bool System.Collections.Generic.List.Enumerator<TFUIEnemy>::MoveNext()  /*0x0A0006E6*/
    IL_0027: brtrue.s IL_000e
    IL_0029: leave.s IL_0039
    IL_002b: ldloca.s 1
    IL_002d: constrained. System.Collections.Generic.List.Enumerator<TFUIEnemy>  /*0x1B000143*/
    IL_0033: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0038: endfinally
    IL_0039: ldarg.1
    IL_003a: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_003f: callvirt int System.Collections.Generic.List<WaveEnemyInfo>::get_Count()  /*0x0A0006E7*/
    IL_0044: ldarg.0
    IL_0045: ldfld List<TFUIEnemy> NightPreviewElement::enemyTFUIs  /*0x040014BC*/
    IL_004a: callvirt int System.Collections.Generic.List<TFUIEnemy>::get_Count()  /*0x0A0006E8*/
    IL_004f: sub
    IL_0050: stloc.0
    IL_0051: ldc.i4.0
    IL_0052: stloc.2
    IL_0053: br.s IL_0075
    IL_0055: ldarg.0
    IL_0056: ldfld List<TFUIEnemy> NightPreviewElement::enemyTFUIs  /*0x040014BC*/
    IL_005b: ldarg.0
    IL_005c: ldfld TFUIEnemy NightPreviewElement::enemyTFUIPrefab  /*0x040014BA*/
    IL_0061: ldarg.0
    IL_0062: call Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0067: call !!0 UnityEngine.Object::Instantiate(!!0,UnityEngine.Transform)<TFUIEnemy>  /*0x2B0000FC*/
    IL_006c: callvirt void System.Collections.Generic.List<TFUIEnemy>::Add(!0)  /*0x0A0006E9*/
    IL_0071: ldloc.2
    IL_0072: ldc.i4.1
    IL_0073: add
    IL_0074: stloc.2
    IL_0075: ldloc.2
    IL_0076: ldloc.0
    IL_0077: blt.s IL_0055
    IL_0079: ldarg.1
    IL_007a: ldarg.1
    IL_007b: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_0080: ldsfld Func<WaveEnemyInfo, int> NightPreviewElement.<>c::<>9__3_0  /*0x040014BE*/
    IL_0085: dup
    IL_0086: brtrue.s IL_009f
    IL_0088: pop
    IL_0089: ldsfld NightPreviewElement.<>c NightPreviewElement.<>c::<>9  /*0x040014BD*/
    IL_008e: ldftn int NightPreviewElement.<>c::<SetData>b__3_0(WaveEnemyInfo)  /*0x0600115D*/
    IL_0094: newobj void System.Func<WaveEnemyInfo, int>::.ctor(object,IntPtr)  /*0x0A0006EA*/
    IL_0099: dup
    IL_009a: stsfld Func<WaveEnemyInfo, int> NightPreviewElement.<>c::<>9__3_0  /*0x040014BE*/
    IL_009f: call IOrderedEnumerable<!!0> System.Linq.Enumerable::OrderBy(System.Collections.Generic.IEnumerable<!!0>,System.Func<!!0, !!1>)<WaveEnemyInfo,int>  /*0x2B0000FD*/
    IL_00a4: call List<!!0> System.Linq.Enumerable::ToList(System.Collections.Generic.IEnumerable<!!0>)<WaveEnemyInfo>  /*0x2B0000FE*/
    IL_00a9: stfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_00ae: ldc.i4.0
    IL_00af: stloc.3
    IL_00b0: br.s IL_00ea
    IL_00b2: ldarg.0
    IL_00b3: ldfld List<TFUIEnemy> NightPreviewElement::enemyTFUIs  /*0x040014BC*/
    IL_00b8: ldloc.3
    IL_00b9: callvirt !0 System.Collections.Generic.List<TFUIEnemy>::get_Item(int)  /*0x0A0006EB*/
    IL_00be: callvirt GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_00c3: ldc.i4.1
    IL_00c4: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_00c9: ldarg.0
    IL_00ca: ldfld List<TFUIEnemy> NightPreviewElement::enemyTFUIs  /*0x040014BC*/
    IL_00cf: ldloc.3
    IL_00d0: callvirt !0 System.Collections.Generic.List<TFUIEnemy>::get_Item(int)  /*0x0A0006EB*/
    IL_00d5: ldarg.1
    IL_00d6: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_00db: ldloc.3
    IL_00dc: callvirt !0 System.Collections.Generic.List<WaveEnemyInfo>::get_Item(int)  /*0x0A0006EC*/
    IL_00e1: callvirt void TFUIEnemy::SetDataSimple(WaveEnemyInfo)  /*0x060011E3*/
    IL_00e6: ldloc.3
    IL_00e7: ldc.i4.1
    IL_00e8: add
    IL_00e9: stloc.3
    IL_00ea: ldloc.3
    IL_00eb: ldarg.1
    IL_00ec: ldfld List<WaveEnemyInfo> WaveInfo::enemies  /*0x040007FE*/
    IL_00f1: callvirt int System.Collections.Generic.List<WaveEnemyInfo>::get_Count()  /*0x0A0006E7*/
    IL_00f6: blt.s IL_00b2
    IL_00f8: ldarg.0
    IL_00f9: ldfld TextMeshProUGUI NightPreviewElement::number  /*0x040014BB*/
    IL_00fe: ldarg.1
    IL_00ff: ldflda int WaveInfo::waveNumber  /*0x040007FB*/
    IL_0104: call string System.Int32::ToString()  /*0x0A000031*/
    IL_0109: ldstr "."
    IL_010e: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0113: callvirt void TMPro.TMP_Text::set_text(string)  /*0x0A000007*/
    IL_0118: call void UnityEngine.Canvas::ForceUpdateCanvases()  /*0x0A0006ED*/
    IL_011d: ldarg.0
    IL_011e: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.HorizontalLayoutGroup>  /*0x2B0000E7*/
    IL_0123: callvirt void UnityEngine.UI.LayoutGroup::SetLayoutHorizontal()  /*0x0A0006EE*/
    IL_0128: ret
    .try IL_000c-IL_002b finally handler IL_002b-IL_0039

  .method NightPreviewElement::OnEnable()  // token 0x06001159 rva 0x51e0c attrs Private, HideBySig
    // code size 17 (0x11), max stack 8
    IL_0000: call void UnityEngine.Canvas::ForceUpdateCanvases()  /*0x0A0006ED*/
    IL_0005: ldarg.0
    IL_0006: call !!0 UnityEngine.Component::GetComponent()<UnityEngine.UI.HorizontalLayoutGroup>  /*0x2B0000E7*/
    IL_000b: callvirt void UnityEngine.UI.LayoutGroup::SetLayoutHorizontal()  /*0x0A0006EE*/
    IL_0010: ret

  .method NightPreviewElement::.ctor()  // token 0x0600115A rva 0x51e1e attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<TFUIEnemy>::.ctor()  /*0x0A0006EF*/
    IL_0006: stfld List<TFUIEnemy> NightPreviewElement::enemyTFUIs  /*0x040014BC*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

// ===== NightPreviewElement/<>c  (token 0x02000326) =====
  .method NightPreviewElement.<>c::.cctor()  // token 0x0600115B rva 0x51e31 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void NightPreviewElement.<>c::.ctor()  /*0x0600115C*/
    IL_0005: stsfld NightPreviewElement.<>c NightPreviewElement.<>c::<>9  /*0x040014BD*/
    IL_000a: ret

  .method NightPreviewElement.<>c::.ctor()  // token 0x0600115C rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method NightPreviewElement.<>c::<SetData>b__3_0(WaveEnemyInfo)  // token 0x0600115D rva 0x51e3d attrs Assembly, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldfld int WaveEnemyInfo::enemyCount  /*0x04000804*/
    IL_0006: ret

