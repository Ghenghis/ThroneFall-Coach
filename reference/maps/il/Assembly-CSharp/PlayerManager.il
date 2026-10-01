// ===== PlayerManager  (token 0x02000237) =====
  .method PlayerManager::get_Instance()  // token 0x06000C14 rva 0x388c3 attrs Public, Static, HideBySig, SpecialName
    // code size 6 (0x6), max stack 8
    IL_0000: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_0005: ret

  .method PlayerManager::get_RegisteredPlayers()  // token 0x06000C15 rva 0x388ca attrs Public, HideBySig, SpecialName
    // code size 12 (0xc), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldfld List<PlayerMovement> PlayerManager::registeredPlayers  /*0x04000EDB*/
    IL_0006: callvirt !0[] System.Collections.Generic.List<PlayerMovement>::ToArray()  /*0x0A000508*/
    IL_000b: ret

  .method PlayerManager::Awake()  // token 0x06000C16 rva 0x388d7 attrs Private, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_0005: ldnull
    IL_0006: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_000b: brfalse.s IL_0021
    IL_000d: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_0012: call void UnityEngine.Object::Destroy(UnityEngine.Object)  /*0x0A000072*/
    IL_0017: ldstr "Found more than one player manager in scene. Destroyed old one."
    IL_001c: call void UnityEngine.Debug::LogWarning(object)  /*0x0A000143*/
    IL_0021: ldarg.0
    IL_0022: stsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_0027: ret

  .method PlayerManager::RegisterPlayer(PlayerMovement)  // token 0x06000C17 rva 0x38900 attrs Public, Static, HideBySig
    // code size 40 (0x28), max stack 8
    IL_0000: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_0017
    IL_000c: ldstr "No PlayerManager exists in scene."
    IL_0011: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0016: ret
    IL_0017: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_001c: ldfld List<PlayerMovement> PlayerManager::registeredPlayers  /*0x04000EDB*/
    IL_0021: ldarg.0
    IL_0022: callvirt void System.Collections.Generic.List<PlayerMovement>::Add(!0)  /*0x0A000509*/
    IL_0027: ret

  .method PlayerManager::UnregisterPlayer(PlayerMovement)  // token 0x06000C18 rva 0x38929 attrs Public, Static, HideBySig
    // code size 41 (0x29), max stack 8
    IL_0000: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_0017
    IL_000c: ldstr "No PlayerManager exists in scene."
    IL_0011: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0016: ret
    IL_0017: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_001c: ldfld List<PlayerMovement> PlayerManager::registeredPlayers  /*0x04000EDB*/
    IL_0021: ldarg.0
    IL_0022: callvirt bool System.Collections.Generic.List<PlayerMovement>::Remove(!0)  /*0x0A00050A*/
    IL_0027: pop
    IL_0028: ret

  .method PlayerManager::GetClosestPlayer(UnityEngine.Vector3)  // token 0x06000C19 rva 0x38954 attrs Public, Static, HideBySig
    // code size 114 (0x72), max stack 2, init locals
    .locals ([0] PlayerMovement, [1] float, [2] List.Enumerator<PlayerMovement>, [3] PlayerMovement, [4] float)
    IL_0000: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_0005: call bool UnityEngine.Object::op_Implicit(UnityEngine.Object)  /*0x0A00000E*/
    IL_000a: brtrue.s IL_0018
    IL_000c: ldstr "No PlayerManager exists in scene."
    IL_0011: call void UnityEngine.Debug::Log(object)  /*0x0A000115*/
    IL_0016: ldnull
    IL_0017: ret
    IL_0018: ldnull
    IL_0019: stloc.0
    IL_001a: ldc.r4 Infinityf
    IL_001f: stloc.1
    IL_0020: ldsfld PlayerManager PlayerManager::instance  /*0x04000EDA*/
    IL_0025: ldfld List<PlayerMovement> PlayerManager::registeredPlayers  /*0x04000EDB*/
    IL_002a: callvirt List.Enumerator<!0> System.Collections.Generic.List<PlayerMovement>::GetEnumerator()  /*0x0A00050B*/
    IL_002f: stloc.2
    IL_0030: br.s IL_0057
    IL_0032: ldloca.s 2
    IL_0034: call !0 System.Collections.Generic.List.Enumerator<PlayerMovement>::get_Current()  /*0x0A00050C*/
    IL_0039: stloc.3
    IL_003a: ldarg.0
    IL_003b: ldloc.3
    IL_003c: callvirt Transform UnityEngine.Component::get_transform()  /*0x0A000018*/
    IL_0041: callvirt Vector3 UnityEngine.Transform::get_position()  /*0x0A000061*/
    IL_0046: call float UnityEngine.Vector3::Distance(UnityEngine.Vector3,UnityEngine.Vector3)  /*0x0A000102*/
    IL_004b: stloc.s 4
    IL_004d: ldloc.s 4
    IL_004f: ldloc.1
    IL_0050: bge.un.s IL_0057
    IL_0052: ldloc.s 4
    IL_0054: stloc.1
    IL_0055: ldloc.3
    IL_0056: stloc.0
    IL_0057: ldloca.s 2
    IL_0059: call bool System.Collections.Generic.List.Enumerator<PlayerMovement>::MoveNext()  /*0x0A00050D*/
    IL_005e: brtrue.s IL_0032
    IL_0060: leave.s IL_0070
    IL_0062: ldloca.s 2
    IL_0064: constrained. System.Collections.Generic.List.Enumerator<PlayerMovement>  /*0x1B0000E0*/
    IL_006a: callvirt void System.IDisposable::Dispose()  /*0x0A000029*/
    IL_006f: endfinally
    IL_0070: ldloc.0
    IL_0071: ret
    .try IL_0030-IL_0062 finally handler IL_0062-IL_0070

  .method PlayerManager::.ctor()  // token 0x06000C1A rva 0x389e4 attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 18 (0x12), max stack 8
    IL_0000: ldarg.0
    IL_0001: newobj void System.Collections.Generic.List<PlayerMovement>::.ctor()  /*0x0A00050E*/
    IL_0006: stfld List<PlayerMovement> PlayerManager::registeredPlayers  /*0x04000EDB*/
    IL_000b: ldarg.0
    IL_000c: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0011: ret

