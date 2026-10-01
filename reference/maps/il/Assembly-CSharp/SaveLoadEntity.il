// ===== SaveLoadEntity  (token 0x02000260) =====
  .method SaveLoadEntity::get_GUID()  // token 0x06000D09 rva 0x3bb41 attrs Public, HideBySig, SpecialName
    // code size 7 (0x7), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0006: ret

  .method SaveLoadEntity::AssignNewGUID()  // token 0x06000D0A rva 0x3bb4c attrs Public, HideBySig
    // code size 26 (0x1a), max stack 2, init locals
    .locals ([0] Guid)
    IL_0000: ldarg.0
    IL_0001: call Guid System.Guid::NewGuid()  /*0x0A000571*/
    IL_0006: stloc.0
    IL_0007: ldloca.s 0
    IL_0009: constrained. System.Guid  /*0x01000107*/
    IL_000f: callvirt string System.Object::ToString()  /*0x0A000142*/
    IL_0014: stfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0019: ret

  .method SaveLoadEntity::ExecuteBeforeMainLoadPass()  // token 0x06000D0B rva 0x3bb72 attrs Public, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0006: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_000b: brtrue.s IL_001e
    IL_000d: ldstr "NO GUID ASSIGNED"
    IL_0012: ldarg.0
    IL_0013: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0018: call void UnityEngine.Debug::LogError(object,UnityEngine.Object)  /*0x0A000388*/
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0024: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0029: brfalse.s IL_003c
    IL_002b: ldarg.0
    IL_002c: ldstr "OnBeforeMainLoadPass"
    IL_0031: ldarg.0
    IL_0032: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0037: call void UnityEngine.Component::BroadcastMessage(string,object)  /*0x0A000572*/
    IL_003c: ret

  .method SaveLoadEntity::ExecuteLoad()  // token 0x06000D0C rva 0x3bbb0 attrs Public, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0006: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_000b: brtrue.s IL_001e
    IL_000d: ldstr "NO GUID ASSIGNED"
    IL_0012: ldarg.0
    IL_0013: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0018: call void UnityEngine.Debug::LogError(object,UnityEngine.Object)  /*0x0A000388*/
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0024: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0029: brfalse.s IL_003c
    IL_002b: ldarg.0
    IL_002c: ldstr "OnLoad"
    IL_0031: ldarg.0
    IL_0032: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0037: call void UnityEngine.Component::BroadcastMessage(string,object)  /*0x0A000572*/
    IL_003c: ret

  .method SaveLoadEntity::ExecuteAfterMainLoadPass()  // token 0x06000D0D rva 0x3bbee attrs Public, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0006: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_000b: brtrue.s IL_001e
    IL_000d: ldstr "NO GUID ASSIGNED"
    IL_0012: ldarg.0
    IL_0013: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0018: call void UnityEngine.Debug::LogError(object,UnityEngine.Object)  /*0x0A000388*/
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0024: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0029: brfalse.s IL_003c
    IL_002b: ldarg.0
    IL_002c: ldstr "OnAfterMainLoadPass"
    IL_0031: ldarg.0
    IL_0032: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0037: call void UnityEngine.Component::BroadcastMessage(string,object)  /*0x0A000572*/
    IL_003c: ret

  .method SaveLoadEntity::ExecuteSave()  // token 0x06000D0E rva 0x3bc2c attrs Public, HideBySig
    // code size 61 (0x3d), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0006: callvirt int System.String::get_Length()  /*0x0A000145*/
    IL_000b: brtrue.s IL_001e
    IL_000d: ldstr "NO GUID ASSIGNED"
    IL_0012: ldarg.0
    IL_0013: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0018: call void UnityEngine.Debug::LogError(object,UnityEngine.Object)  /*0x0A000388*/
    IL_001d: ret
    IL_001e: ldarg.0
    IL_001f: call GameObject UnityEngine.Component::get_gameObject()  /*0x0A00001A*/
    IL_0024: callvirt bool UnityEngine.GameObject::get_activeInHierarchy()  /*0x0A000016*/
    IL_0029: brfalse.s IL_003c
    IL_002b: ldarg.0
    IL_002c: ldstr "OnSave"
    IL_0031: ldarg.0
    IL_0032: ldfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_0037: call void UnityEngine.Component::BroadcastMessage(string,object)  /*0x0A000572*/
    IL_003c: ret

  .method SaveLoadEntity::.ctor()  // token 0x06000D0F rva 0x3bc6a attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldstr ""
    IL_0006: stfld string SaveLoadEntity::guid  /*0x04000F9C*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

