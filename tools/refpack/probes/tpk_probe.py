from UnityPy.helpers import Tpk
from UnityPy.enums import ClassIDType
from UnityPy.helpers.UnityVersion import UnityVersion
v = UnityVersion.from_str("2022.3.62f2")
def dump(cid, want=None, maxlines=400):
    node = Tpk.get_typetree_node(cid, v)
    out=[]
    def walk(n, depth, inside):
        hit = inside or (want is None) or (n.m_Name in want) or (n.m_Type in want)
        if hit: out.append("%s%s %s  meta=0x%X" % ("  "*depth, n.m_Type, n.m_Name, n.m_MetaFlag or 0))
        for c in n.m_Children: walk(c, depth+1, hit and want is not None or (want is None))
    walk(node,0,False)
    print("\n".join(out[:maxlines]))
print("=== MonoBehaviour(114)"); dump(ClassIDType.MonoBehaviour.value)
print("=== LineRenderer gradient"); dump(ClassIDType.LineRenderer.value, want={"colorGradient"}, maxlines=80)
print("=== AudioSource curve"); dump(ClassIDType.AudioSource.value, want={"rolloffCustomCurve"}, maxlines=40)
print("=== MonoScript(115)"); dump(ClassIDType.MonoScript.value)
