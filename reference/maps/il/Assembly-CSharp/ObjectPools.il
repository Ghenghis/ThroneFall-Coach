// ===== ObjectPools  (token 0x020002A5) =====
  .method ObjectPools::Awake()  // token 0x06000E97 rva 0x41335 attrs Private, HideBySig
    // code size 50 (0x32), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld UnityAction<Scene, Scene> ObjectPools::_onActiveSceneChangedCallback  /*0x040010E2*/
    IL_0006: brfalse.s IL_0013
    IL_0008: ldarg.0
    IL_0009: ldfld UnityAction<Scene, Scene> ObjectPools::_onActiveSceneChangedCallback  /*0x040010E2*/
    IL_000e: call void UnityEngine.SceneManagement.SceneManager::remove_activeSceneChanged(UnityEngine.Events.UnityAction<UnityEngine.SceneManagement.Scene, UnityEngine.SceneManagement.Scene>)  /*0x0A0005D6*/
    IL_0013: ldarg.0
    IL_0014: ldarg.0
    IL_0015: dup
    IL_0016: ldvirtftn void ObjectPools::OnActiveSceneChanged(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)  /*0x06000E9E*/
    IL_001c: newobj void UnityEngine.Events.UnityAction<UnityEngine.SceneManagement.Scene, UnityEngine.SceneManagement.Scene>::.ctor(object,IntPtr)  /*0x0A0005D7*/
    IL_0021: stfld UnityAction<Scene, Scene> ObjectPools::_onActiveSceneChangedCallback  /*0x040010E2*/
    IL_0026: ldarg.0
    IL_0027: ldfld UnityAction<Scene, Scene> ObjectPools::_onActiveSceneChangedCallback  /*0x040010E2*/
    IL_002c: call void UnityEngine.SceneManagement.SceneManager::add_activeSceneChanged(UnityEngine.Events.UnityAction<UnityEngine.SceneManagement.Scene, UnityEngine.SceneManagement.Scene>)  /*0x0A0005D8*/
    IL_0031: ret

  .method ObjectPools::GetObjectPoolByHashCode(int)  // token 0x06000E98 rva 0x41368 attrs Public, Static, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0005: ldarg.0
    IL_0006: callvirt !1 System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::get_Item(!0)  /*0x0A0005D9*/
    IL_000b: ret

  .method ObjectPools::CreatePooledItem(UnityEngine.GameObject)  // token 0x06000E99 rva 0x41375 attrs Private, Static, HideBySig
    // code size 24 (0x18), max stack 8
    IL_0000: ldarg.0
    IL_0001: call !!0 UnityEngine.Object::Instantiate(!!0)<UnityEngine.GameObject>  /*0x2B0000D0*/
    IL_0006: dup
    IL_0007: callvirt !!0 UnityEngine.GameObject::AddComponent()<ReturnGameObjectToPool>  /*0x2B0000D1*/
    IL_000c: ldarg.0
    IL_000d: callvirt int System.Object::GetHashCode()  /*0x0A0004DA*/
    IL_0012: stfld int ReturnGameObjectToPool::owningPoolHashCode  /*0x040010EF*/
    IL_0017: ret

  .method ObjectPools::GetPooledItemByObject(UnityEngine.GameObject)  // token 0x06000E9A rva 0x41390 attrs Public, Static, HideBySig
    // code size 400 (0x190), max stack 9, init locals
    .locals ([0] ObjectPools.<>c__DisplayClass8_0, [1] ObjectPool<GameObject>)
    IL_0000: newobj void ObjectPools.<>c__DisplayClass8_0::.ctor()  /*0x06000EA9*/
    IL_0005: stloc.0
    IL_0006: ldloc.0
    IL_0007: ldarg.0
    IL_0008: stfld GameObject ObjectPools.<>c__DisplayClass8_0::Object  /*0x040010EE*/
    IL_000d: ldnull
    IL_000e: stloc.1
    IL_000f: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0014: brtrue.s IL_002a
    IL_0016: newobj void System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::.ctor()  /*0x0A0005DB*/
    IL_001b: stsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0020: ldsfld Dictionary<int, string> ObjectPools::poolMapToName  /*0x040010E6*/
    IL_0025: callvirt void System.Collections.Generic.Dictionary<int, string>::Clear()  /*0x0A0005DC*/
    IL_002a: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_002f: ldloc.0
    IL_0030: ldfld GameObject ObjectPools.<>c__DisplayClass8_0::Object  /*0x040010EE*/
    IL_0035: callvirt int System.Object::GetHashCode()  /*0x0A0004DA*/
    IL_003a: ldloca.s 1
    IL_003c: callvirt bool System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::TryGetValue(!0,ref !1)  /*0x0A0005DD*/
    IL_0041: brtrue IL_00f8
    IL_0046: ldloc.0
    IL_0047: ldftn GameObject ObjectPools.<>c__DisplayClass8_0::<GetPooledItemByObject>b__0()  /*0x06000EAA*/
    IL_004d: newobj void System.Func<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A0005DE*/
    IL_0052: ldsfld Action<GameObject> ObjectPools.<>c::<>9__8_1  /*0x040010E8*/
    IL_0057: dup
    IL_0058: brtrue.s IL_0071
    IL_005a: pop
    IL_005b: ldsfld ObjectPools.<>c ObjectPools.<>c::<>9  /*0x040010E7*/
    IL_0060: ldftn void ObjectPools.<>c::<GetPooledItemByObject>b__8_1(UnityEngine.GameObject)  /*0x06000EA3*/
    IL_0066: newobj void System.Action<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A0005DF*/
    IL_006b: dup
    IL_006c: stsfld Action<GameObject> ObjectPools.<>c::<>9__8_1  /*0x040010E8*/
    IL_0071: ldsfld Action<GameObject> ObjectPools.<>c::<>9__8_2  /*0x040010E9*/
    IL_0076: dup
    IL_0077: brtrue.s IL_0090
    IL_0079: pop
    IL_007a: ldsfld ObjectPools.<>c ObjectPools.<>c::<>9  /*0x040010E7*/
    IL_007f: ldftn void ObjectPools.<>c::<GetPooledItemByObject>b__8_2(UnityEngine.GameObject)  /*0x06000EA4*/
    IL_0085: newobj void System.Action<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A0005DF*/
    IL_008a: dup
    IL_008b: stsfld Action<GameObject> ObjectPools.<>c::<>9__8_2  /*0x040010E9*/
    IL_0090: ldsfld Action<GameObject> ObjectPools.<>c::<>9__8_3  /*0x040010EA*/
    IL_0095: dup
    IL_0096: brtrue.s IL_00af
    IL_0098: pop
    IL_0099: ldsfld ObjectPools.<>c ObjectPools.<>c::<>9  /*0x040010E7*/
    IL_009e: ldftn void ObjectPools.<>c::<GetPooledItemByObject>b__8_3(UnityEngine.GameObject)  /*0x06000EA5*/
    IL_00a4: newobj void System.Action<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A0005DF*/
    IL_00a9: dup
    IL_00aa: stsfld Action<GameObject> ObjectPools.<>c::<>9__8_3  /*0x040010EA*/
    IL_00af: ldc.i4.0
    IL_00b0: ldc.i4.s 50
    IL_00b2: ldc.i4 1000
    IL_00b7: newobj void UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>::.ctor(System.Func<!0>,System.Action<!0>,System.Action<!0>,System.Action<!0>,bool,int,int)  /*0x0A0005E0*/
    IL_00bc: stloc.1
    IL_00bd: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_00c2: ldloc.0
    IL_00c3: ldfld GameObject ObjectPools.<>c__DisplayClass8_0::Object  /*0x040010EE*/
    IL_00c8: callvirt int System.Object::GetHashCode()  /*0x0A0004DA*/
    IL_00cd: ldloc.1
    IL_00ce: callvirt void System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::Add(!0,!1)  /*0x0A0005E1*/
    IL_00d3: ldsfld Dictionary<int, string> ObjectPools::poolMapToName  /*0x040010E6*/
    IL_00d8: ldloc.0
    IL_00d9: ldfld GameObject ObjectPools.<>c__DisplayClass8_0::Object  /*0x040010EE*/
    IL_00de: callvirt int System.Object::GetHashCode()  /*0x0A0004DA*/
    IL_00e3: ldloc.0
    IL_00e4: ldfld GameObject ObjectPools.<>c__DisplayClass8_0::Object  /*0x040010EE*/
    IL_00e9: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_00ee: callvirt void System.Collections.Generic.Dictionary<int, string>::Add(!0,!1)  /*0x0A0005E2*/
    IL_00f3: br IL_0189
    IL_00f8: ldloc.1
    IL_00f9: brtrue IL_0189
    IL_00fe: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0103: ldloc.0
    IL_0104: ldfld GameObject ObjectPools.<>c__DisplayClass8_0::Object  /*0x040010EE*/
    IL_0109: callvirt int System.Object::GetHashCode()  /*0x0A0004DA*/
    IL_010e: ldloc.0
    IL_010f: ldftn GameObject ObjectPools.<>c__DisplayClass8_0::<GetPooledItemByObject>b__4()  /*0x06000EAB*/
    IL_0115: newobj void System.Func<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A0005DE*/
    IL_011a: ldsfld Action<GameObject> ObjectPools.<>c::<>9__8_5  /*0x040010EB*/
    IL_011f: dup
    IL_0120: brtrue.s IL_0139
    IL_0122: pop
    IL_0123: ldsfld ObjectPools.<>c ObjectPools.<>c::<>9  /*0x040010E7*/
    IL_0128: ldftn void ObjectPools.<>c::<GetPooledItemByObject>b__8_5(UnityEngine.GameObject)  /*0x06000EA6*/
    IL_012e: newobj void System.Action<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A0005DF*/
    IL_0133: dup
    IL_0134: stsfld Action<GameObject> ObjectPools.<>c::<>9__8_5  /*0x040010EB*/
    IL_0139: ldsfld Action<GameObject> ObjectPools.<>c::<>9__8_6  /*0x040010EC*/
    IL_013e: dup
    IL_013f: brtrue.s IL_0158
    IL_0141: pop
    IL_0142: ldsfld ObjectPools.<>c ObjectPools.<>c::<>9  /*0x040010E7*/
    IL_0147: ldftn void ObjectPools.<>c::<GetPooledItemByObject>b__8_6(UnityEngine.GameObject)  /*0x06000EA7*/
    IL_014d: newobj void System.Action<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A0005DF*/
    IL_0152: dup
    IL_0153: stsfld Action<GameObject> ObjectPools.<>c::<>9__8_6  /*0x040010EC*/
    IL_0158: ldsfld Action<GameObject> ObjectPools.<>c::<>9__8_7  /*0x040010ED*/
    IL_015d: dup
    IL_015e: brtrue.s IL_0177
    IL_0160: pop
    IL_0161: ldsfld ObjectPools.<>c ObjectPools.<>c::<>9  /*0x040010E7*/
    IL_0166: ldftn void ObjectPools.<>c::<GetPooledItemByObject>b__8_7(UnityEngine.GameObject)  /*0x06000EA8*/
    IL_016c: newobj void System.Action<UnityEngine.GameObject>::.ctor(object,IntPtr)  /*0x0A0005DF*/
    IL_0171: dup
    IL_0172: stsfld Action<GameObject> ObjectPools.<>c::<>9__8_7  /*0x040010ED*/
    IL_0177: ldc.i4.0
    IL_0178: ldc.i4.s 50
    IL_017a: ldc.i4 1000
    IL_017f: newobj void UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>::.ctor(System.Func<!0>,System.Action<!0>,System.Action<!0>,System.Action<!0>,bool,int,int)  /*0x0A0005E0*/
    IL_0184: callvirt void System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::set_Item(!0,!1)  /*0x0A0005E3*/
    IL_0189: ldloc.1
    IL_018a: callvirt !0 UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>::Get()  /*0x0A0005E4*/
    IL_018f: ret

  .method ObjectPools::ReleasePooledItemByObject(UnityEngine.GameObject)  // token 0x06000E9B rva 0x4152c attrs Public, Static, HideBySig
    // code size 84 (0x54), max stack 3, init locals
    .locals ([0] ReturnGameObjectToPool, [1] ObjectPool<GameObject>)
    IL_0000: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0005: brfalse.s IL_0053
    IL_0007: ldarg.0
    IL_0008: callvirt !!0 UnityEngine.GameObject::GetComponent()<ReturnGameObjectToPool>  /*0x2B000020*/
    IL_000d: stloc.0
    IL_000e: ldloc.0
    IL_000f: ldnull
    IL_0010: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0015: brfalse.s IL_004d
    IL_0017: ldnull
    IL_0018: stloc.1
    IL_0019: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_001e: ldloc.0
    IL_001f: ldfld int ReturnGameObjectToPool::owningPoolHashCode  /*0x040010EF*/
    IL_0024: ldloca.s 1
    IL_0026: callvirt bool System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::TryGetValue(!0,ref !1)  /*0x0A0005DD*/
    IL_002b: pop
    IL_002c: ldloc.1
    IL_002d: brfalse.s IL_0037
    IL_002f: ldloc.1
    IL_0030: ldarg.0
    IL_0031: callvirt void UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>::Release(!0)  /*0x0A0005E5*/
    IL_0036: ret
    IL_0037: ldstr "Pool Error - Missing a valid pool for this game object "
    IL_003c: ldarg.0
    IL_003d: callvirt string UnityEngine.Object::get_name()  /*0x0A000026*/
    IL_0042: call string System.String::Concat(string,string)  /*0x0A000043*/
    IL_0047: call void UnityEngine.Debug::LogError(object)  /*0x0A0000DD*/
    IL_004c: ret
    IL_004d: ldarg.0
    IL_004e: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0053: ret

  .method ObjectPools::OnDestroy()  // token 0x06000E9C rva 0x4158c attrs Private, HideBySig
    // code size 79 (0x4f), max stack 1, init locals
    .locals ([0] Dictionary.Enumerator<int, ObjectPool<GameObject>>, [1] KeyValuePair<int, ObjectPool<GameObject>>)
    IL_0000: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0005: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::GetEnumerator()  /*0x0A0005E6*/
    IL_000a: stloc.0
    IL_000b: br.s IL_0021
    IL_000d: ldloca.s 0
    IL_000f: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::get_Current()  /*0x0A0005E7*/
    IL_0014: stloc.1
    IL_0015: ldloca.s 1
    IL_0017: call !1 System.Collections.Generic.KeyValuePair<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::get_Value()  /*0x0A0005E8*/
    IL_001c: callvirt void UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>::Dispose()  /*0x0A0005E9*/
    IL_0021: ldloca.s 0
    IL_0023: call bool System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::MoveNext()  /*0x0A0005EA*/
    IL_0028: brtrue.s IL_000d
    IL_002a: leave.s IL_003a
    IL_002c: ldloca.s 0
    IL_002e: constrained. System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>  /*0x1B000111*/
    IL_0034: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0039: endfinally
    IL_003a: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_003f: callvirt void System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::Clear()  /*0x0A0005EB*/
    IL_0044: ldsfld Dictionary<int, string> ObjectPools::poolMapToName  /*0x040010E6*/
    IL_0049: callvirt void System.Collections.Generic.Dictionary<int, string>::Clear()  /*0x0A0005DC*/
    IL_004e: ret
    .try IL_000b-IL_002c finally handler IL_002c-IL_003a

  .method ObjectPools::OnApplicationQuit()  // token 0x06000E9D rva 0x415f8 attrs Public, HideBySig
    // code size 79 (0x4f), max stack 1, init locals
    .locals ([0] Dictionary.Enumerator<int, ObjectPool<GameObject>>, [1] KeyValuePair<int, ObjectPool<GameObject>>)
    IL_0000: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0005: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::GetEnumerator()  /*0x0A0005E6*/
    IL_000a: stloc.0
    IL_000b: br.s IL_0021
    IL_000d: ldloca.s 0
    IL_000f: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::get_Current()  /*0x0A0005E7*/
    IL_0014: stloc.1
    IL_0015: ldloca.s 1
    IL_0017: call !1 System.Collections.Generic.KeyValuePair<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::get_Value()  /*0x0A0005E8*/
    IL_001c: callvirt void UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>::Dispose()  /*0x0A0005E9*/
    IL_0021: ldloca.s 0
    IL_0023: call bool System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::MoveNext()  /*0x0A0005EA*/
    IL_0028: brtrue.s IL_000d
    IL_002a: leave.s IL_003a
    IL_002c: ldloca.s 0
    IL_002e: constrained. System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>  /*0x1B000111*/
    IL_0034: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0039: endfinally
    IL_003a: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_003f: callvirt void System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::Clear()  /*0x0A0005EB*/
    IL_0044: ldsfld Dictionary<int, string> ObjectPools::poolMapToName  /*0x040010E6*/
    IL_0049: callvirt void System.Collections.Generic.Dictionary<int, string>::Clear()  /*0x0A0005DC*/
    IL_004e: ret
    .try IL_000b-IL_002c finally handler IL_002c-IL_003a

  .method ObjectPools::OnActiveSceneChanged(UnityEngine.SceneManagement.Scene,UnityEngine.SceneManagement.Scene)  // token 0x06000E9E rva 0x41664 attrs Family, Virtual, HideBySig, VtableLayoutMask
    // code size 79 (0x4f), max stack 1, init locals
    .locals ([0] Dictionary.Enumerator<int, ObjectPool<GameObject>>, [1] KeyValuePair<int, ObjectPool<GameObject>>)
    IL_0000: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0005: callvirt Dictionary.Enumerator<!0, !1> System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::GetEnumerator()  /*0x0A0005E6*/
    IL_000a: stloc.0
    IL_000b: br.s IL_0021
    IL_000d: ldloca.s 0
    IL_000f: call KeyValuePair<!0, !1> System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::get_Current()  /*0x0A0005E7*/
    IL_0014: stloc.1
    IL_0015: ldloca.s 1
    IL_0017: call !1 System.Collections.Generic.KeyValuePair<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::get_Value()  /*0x0A0005E8*/
    IL_001c: callvirt void UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>::Dispose()  /*0x0A0005E9*/
    IL_0021: ldloca.s 0
    IL_0023: call bool System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::MoveNext()  /*0x0A0005EA*/
    IL_0028: brtrue.s IL_000d
    IL_002a: leave.s IL_003a
    IL_002c: ldloca.s 0
    IL_002e: constrained. System.Collections.Generic.Dictionary.Enumerator<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>  /*0x1B000111*/
    IL_0034: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_0039: endfinally
    IL_003a: ldsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_003f: callvirt void System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::Clear()  /*0x0A0005EB*/
    IL_0044: ldsfld Dictionary<int, string> ObjectPools::poolMapToName  /*0x040010E6*/
    IL_0049: callvirt void System.Collections.Generic.Dictionary<int, string>::Clear()  /*0x0A0005DC*/
    IL_004e: ret
    .try IL_000b-IL_002c finally handler IL_002c-IL_003a

  .method ObjectPools::.ctor()  // token 0x06000E9F rva 0x20e9 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0006: ret

  .method ObjectPools::.cctor()  // token 0x06000EA0 rva 0x416d0 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 33 (0x21), max stack 8
    IL_0000: ldc.i4.1
    IL_0001: stsfld bool ObjectPools::s_ObjectPoolingEnabled  /*0x040010E3*/
    IL_0006: ldc.i4.0
    IL_0007: stsfld bool ObjectPools::s_ObjectPoolingLoggingEnabled  /*0x040010E4*/
    IL_000c: newobj void System.Collections.Generic.Dictionary<int, UnityEngine.Pool.ObjectPool<UnityEngine.GameObject>>::.ctor()  /*0x0A0005DB*/
    IL_0011: stsfld Dictionary<int, ObjectPool<GameObject>> ObjectPools::poolMap  /*0x040010E5*/
    IL_0016: newobj void System.Collections.Generic.Dictionary<int, string>::.ctor()  /*0x0A0005EC*/
    IL_001b: stsfld Dictionary<int, string> ObjectPools::poolMapToName  /*0x040010E6*/
    IL_0020: ret

// ===== ObjectPools/<>c  (token 0x020002A6) =====
  .method ObjectPools.<>c::.cctor()  // token 0x06000EA1 rva 0x416f2 attrs Private, Static, HideBySig, SpecialName, RTSpecialName
    // code size 11 (0xb), max stack 8
    IL_0000: newobj void ObjectPools.<>c::.ctor()  /*0x06000EA2*/
    IL_0005: stsfld ObjectPools.<>c ObjectPools.<>c::<>9  /*0x040010E7*/
    IL_000a: ret

  .method ObjectPools.<>c::.ctor()  // token 0x06000EA2 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method ObjectPools.<>c::<GetPooledItemByObject>b__8_1(UnityEngine.GameObject)  // token 0x06000EA3 rva 0x416fe attrs Assembly, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0007: ret

  .method ObjectPools.<>c::<GetPooledItemByObject>b__8_2(UnityEngine.GameObject)  // token 0x06000EA4 rva 0x416fe attrs Assembly, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0007: ret

  .method ObjectPools.<>c::<GetPooledItemByObject>b__8_3(UnityEngine.GameObject)  // token 0x06000EA5 rva 0x41707 attrs Assembly, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0006: ret

  .method ObjectPools.<>c::<GetPooledItemByObject>b__8_5(UnityEngine.GameObject)  // token 0x06000EA6 rva 0x416fe attrs Assembly, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0007: ret

  .method ObjectPools.<>c::<GetPooledItemByObject>b__8_6(UnityEngine.GameObject)  // token 0x06000EA7 rva 0x416fe attrs Assembly, HideBySig
    // code size 8 (0x8), max stack 8
    IL_0000: ldarg.1
    IL_0001: ldc.i4.0
    IL_0002: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0007: ret

  .method ObjectPools.<>c::<GetPooledItemByObject>b__8_7(UnityEngine.GameObject)  // token 0x06000EA8 rva 0x41707 attrs Assembly, HideBySig
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.1
    IL_0001: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0006: ret

// ===== ObjectPools/<>c__DisplayClass8_0  (token 0x020002A7) =====
  .method ObjectPools.<>c__DisplayClass8_0::.ctor()  // token 0x06000EA9 rva 0x4751 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: call void System.Object::.ctor()  /*0x0A000038*/
    IL_0006: ret

  .method ObjectPools.<>c__DisplayClass8_0::<GetPooledItemByObject>b__0()  // token 0x06000EAA rva 0x4170f attrs Assembly, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ObjectPools.<>c__DisplayClass8_0::Object  /*0x040010EE*/
    IL_0006: call GameObject ObjectPools::CreatePooledItem(UnityEngine.GameObject)  /*0x06000E99*/
    IL_000b: ret

  .method ObjectPools.<>c__DisplayClass8_0::<GetPooledItemByObject>b__4()  // token 0x06000EAB rva 0x4170f attrs Assembly, HideBySig
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld GameObject ObjectPools.<>c__DisplayClass8_0::Object  /*0x040010EE*/
    IL_0006: call GameObject ObjectPools::CreatePooledItem(UnityEngine.GameObject)  /*0x06000E99*/
    IL_000b: ret

