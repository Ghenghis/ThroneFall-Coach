// ===== DisableButtonInWaveZero  (token 0x020002F4) =====
  .method DisableButtonInWaveZero::OnEnable()  // token 0x0600104C rva 0x4a46c attrs Public, HideBySig
    // code size 103 (0x67), max stack 2, init locals
    .locals ([0] bool, [1] bool, [2] Scene)
    IL_0000: call Scene UnityEngine.SceneManagement.SceneManager::GetActiveScene()  /*0x0A000292*/
    IL_0005: stloc.2
    IL_0006: ldloca.s 2
    IL_0008: call string UnityEngine.SceneManagement.Scene::get_name()  /*0x0A00011B*/
    IL_000d: ldstr "Neuland(Tutorial)"
    IL_0012: call bool System.String::op_Equality(string,string)  /*0x0A0002A6*/
    IL_0017: stloc.0
    IL_0018: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_001d: ldnull
    IL_001e: call bool UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)  /*0x0A000014*/
    IL_0023: brfalse.s IL_0034
    IL_0025: ldsfld EnemySpawner EnemySpawner::instance  /*0x040007C2*/
    IL_002a: callvirt int EnemySpawner::get_Wavenumber()  /*0x0600066E*/
    IL_002f: ldc.i4.1
    IL_0030: clt
    IL_0032: br.s IL_0035
    IL_0034: ldc.i4.0
    IL_0035: stloc.1
    IL_0036: ldarg.0
    IL_0037: ldfld bool DisableButtonInWaveZero::alwaysDisableInTutorial  /*0x04001329*/
    IL_003c: ldloc.0
    IL_003d: and
    IL_003e: brtrue.s IL_004a
    IL_0040: ldarg.0
    IL_0041: ldfld bool DisableButtonInWaveZero::disableInWaveZero  /*0x0400132A*/
    IL_0046: ldloc.1
    IL_0047: and
    IL_0048: br.s IL_004b
    IL_004a: ldc.i4.1
    IL_004b: brfalse.s IL_005a
    IL_004d: ldarg.0
    IL_004e: ldfld GameObject DisableButtonInWaveZero::buttonToDisable  /*0x0400132B*/
    IL_0053: ldc.i4.0
    IL_0054: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0059: ret
    IL_005a: ldarg.0
    IL_005b: ldfld GameObject DisableButtonInWaveZero::buttonToDisable  /*0x0400132B*/
    IL_0060: ldc.i4.1
    IL_0061: callvirt void UnityEngine.GameObject::SetActive(bool)  /*0x0A000017*/
    IL_0066: ret

  .method DisableButtonInWaveZero::.ctor()  // token 0x0600104D rva 0x4a4df attrs Public, HideBySig, SpecialName, RTSpecialName
    // code size 21 (0x15), max stack 8
    IL_0000: ldarg.0
    IL_0001: ldc.i4.1
    IL_0002: stfld bool DisableButtonInWaveZero::alwaysDisableInTutorial  /*0x04001329*/
    IL_0007: ldarg.0
    IL_0008: ldc.i4.1
    IL_0009: stfld bool DisableButtonInWaveZero::disableInWaveZero  /*0x0400132A*/
    IL_000e: ldarg.0
    IL_000f: call void UnityEngine.MonoBehaviour::.ctor()  /*0x0A000008*/
    IL_0014: ret

