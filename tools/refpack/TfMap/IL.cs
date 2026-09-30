using System.Globalization;
using System.Reflection;
using System.Reflection.Emit;
using System.Reflection.Metadata;
using System.Reflection.Metadata.Ecma335;
using System.Text;

namespace TfMap;

/// <summary>Cross-references collected from one method body.</summary>
sealed class XMethod
{
    public int Id;
    public string Key = "";
    public string Logical = "";
    public int Token;
    public string TypeKey = "";
    public readonly List<(string callee, int off, string op)> Calls = new();
    public readonly List<(string field, int off, char mode)> Fields = new();
    public readonly List<(int off, string text)> Strings = new();
    public readonly List<(string type, int off, string kind)> Types = new();
    public bool HasBody;
    public int IlSize, Locals, MaxStack, EhCount;
}

/// <summary>An IL operand resolved through metadata tokens (never executed, only read).</summary>
readonly record struct Resolved(string Kind, string Key, string Text);

sealed class Disassembler
{
    static readonly Dictionary<ushort, OpCode> Ops = BuildOps();

    static Dictionary<ushort, OpCode> BuildOps()
    {
        var d = new Dictionary<ushort, OpCode>();
        foreach (var f in typeof(OpCodes).GetFields(BindingFlags.Public | BindingFlags.Static))
            if (f.GetValue(null) is OpCode oc) d.TryAdd((ushort)oc.Value, oc);
        return d;
    }

    readonly World W;
    readonly Dictionary<(Module, int), Resolved> cache = new();

    public Disassembler(World w) => W = w;

    // ------------------------------------------------------------------ keys

    static string TypeKey(TypeSig s) => Naming.Show(s, full: true);

    /// <summary>Canonical key of a method definition; identical to the key produced for a MemberRef to the same method.</summary>
    public string DefKey(Module m, MethodDefinitionHandle h)
    {
        var def = m.MD.GetMethodDefinition(h);
        var owner = TypeKey(W.P.GetTypeFromDefinition(m.MD, def.GetDeclaringType(), 0));
        var sig = def.DecodeSignature(W.P, SigCtx.For(m));
        return $"{owner}::{m.MD.GetString(def.Name)}({string.Join(",", sig.ParameterTypes.Select(TypeKey))})";
    }

    public string FieldKey(Module m, FieldDefinitionHandle h)
    {
        var f = m.MD.GetFieldDefinition(h);
        var owner = TypeKey(W.P.GetTypeFromDefinition(m.MD, f.GetDeclaringType(), 0));
        return $"{owner}::{m.MD.GetString(f.Name)}";
    }

    string OwnerText(Module m, EntityHandle parent)
    {
        switch (parent.Kind)
        {
            case HandleKind.TypeDefinition:
            case HandleKind.TypeReference:
            case HandleKind.TypeSpecification:
                return TypeKey(W.SigOf(m, parent, SigCtx.For(m)));
            case HandleKind.MethodDefinition:
                return TypeKey(W.P.GetTypeFromDefinition(m.MD, m.MD.GetMethodDefinition((MethodDefinitionHandle)parent).GetDeclaringType(), 0));
            default:
                return "<" + parent.Kind + ">";
        }
    }

    // ------------------------------------------------------------------ token resolution

    public Resolved Resolve(Module m, int token)
    {
        if (cache.TryGetValue((m, token), out var hit)) return hit;
        Resolved r;
        try { r = ResolveCore(m, token); }
        catch (Exception e) { r = new("error", $"<token 0x{token:X8}: {e.GetType().Name}>", $"<token 0x{token:X8}>"); }
        cache[(m, token)] = r;
        return r;
    }

    Resolved ResolveCore(Module m, int token)
    {
        var md = m.MD;
        int table = token >>> 24;
        if (table == 0x70)
        {
            var s = md.GetUserString(MetadataTokens.UserStringHandle(token & 0x00FFFFFF));
            return new("string", s, Quote(s, 160));
        }
        var h = MetadataTokens.EntityHandle(token);
        var ctx = SigCtx.For(m);
        switch (h.Kind)
        {
            case HandleKind.MethodDefinition:
            {
                var mh = (MethodDefinitionHandle)h;
                var def = md.GetMethodDefinition(mh);
                var sig = def.DecodeSignature(W.P, ctx);
                var key = DefKey(m, mh);
                return new("method", key, $"{Naming.Show(sig.ReturnType)} {key}");
            }
            case HandleKind.MemberReference:
            {
                var mr = md.GetMemberReference((MemberReferenceHandle)h);
                var owner = OwnerText(m, mr.Parent);
                var name = md.GetString(mr.Name);
                if (mr.GetKind() == MemberReferenceKind.Method)
                {
                    var sig = mr.DecodeMethodSignature(W.P, ctx);
                    var key = $"{owner}::{name}({string.Join(",", sig.ParameterTypes.Select(TypeKey))})";
                    return new("method", key, $"{Naming.Show(sig.ReturnType)} {key}");
                }
                var ft = mr.DecodeFieldSignature(W.P, ctx);
                return new("field", $"{owner}::{name}", $"{Naming.Show(ft)} {owner}::{name}");
            }
            case HandleKind.MethodSpecification:
            {
                var ms = md.GetMethodSpecification((MethodSpecificationHandle)h);
                var inner = ResolveCore(m, MetadataTokens.GetToken(ms.Method));
                var args = ms.DecodeSignature(W.P, ctx);
                var suffix = "<" + string.Join(",", args.Select(TypeKey)) + ">";
                return new("method", inner.Key + suffix, inner.Text + suffix);
            }
            case HandleKind.FieldDefinition:
            {
                var fh = (FieldDefinitionHandle)h;
                var f = md.GetFieldDefinition(fh);
                var ft = f.DecodeSignature(W.P, ctx);
                var key = FieldKey(m, fh);
                return new("field", key, $"{Naming.Show(ft)} {key}");
            }
            case HandleKind.TypeDefinition:
            case HandleKind.TypeReference:
            case HandleKind.TypeSpecification:
            {
                var k = TypeKey(W.SigOf(m, h, ctx));
                return new("type", k, k);
            }
            case HandleKind.StandaloneSignature:
                return new("sig", "calli", "calli-signature");
            default:
                return new("other", h.Kind.ToString(), h.Kind.ToString());
        }
    }

    static string Quote(string s, int max)
    {
        if (s.Length > max) s = s[..max] + "…";
        var sb = new StringBuilder("\"");
        foreach (var c in s)
        {
            switch (c)
            {
                case '"': sb.Append("\\\""); break;
                case '\\': sb.Append("\\\\"); break;
                case '\n': sb.Append("\\n"); break;
                case '\r': sb.Append("\\r"); break;
                case '\t': sb.Append("\\t"); break;
                default: if (c < 0x20) sb.Append($"\\u{(int)c:x4}"); else sb.Append(c); break;
            }
        }
        return sb.Append('"').ToString();
    }

    // ------------------------------------------------------------------ decoding

    /// <summary>
    /// Decodes one method body. Fills <paramref name="x"/> with xrefs and appends readable IL to <paramref name="il"/> (either may be null).
    /// Returns false when the method has no body.
    /// </summary>
    public bool Decode(Module m, MethodDefinitionHandle mh, XMethod? x, StringBuilder? il)
    {
        var def = m.MD.GetMethodDefinition(mh);
        if (def.RelativeVirtualAddress == 0) return false;
        MethodBodyBlock body;
        try { body = m.PE.GetMethodBody(def.RelativeVirtualAddress); }
        catch { il?.AppendLine("    // <unreadable body>"); return false; }
        var code = body.GetILBytes() ?? Array.Empty<byte>();

        ImmutableArrayOrEmpty(out var locals, m, body);
        if (x != null)
        {
            x.HasBody = true; x.IlSize = code.Length; x.Locals = locals.Length; x.MaxStack = body.MaxStack; x.EhCount = body.ExceptionRegions.Length;
        }
        if (il != null)
        {
            il.AppendLine($"    // code size {code.Length} (0x{code.Length:x}), max stack {body.MaxStack}{(body.LocalVariablesInitialized ? ", init locals" : "")}");
            if (locals.Length > 0)
                il.AppendLine("    .locals (" + string.Join(", ", locals.Select((t, i) => $"[{i}] {Naming.Show(t)}")) + ")");
        }

        int p = 0;
        while (p < code.Length)
        {
            int start = p;
            ushort raw = code[p++];
            if (raw == 0xFE) { if (p >= code.Length) break; raw = (ushort)(0xFE00 | code[p++]); }
            if (!Ops.TryGetValue(raw, out var op)) { il?.AppendLine($"    IL_{start:x4}: .byte 0x{raw:x2}"); continue; }

            string operandText = "";
            Resolved? res = null;
            try
            {
                switch (op.OperandType)
                {
                    case OperandType.InlineNone: break;
                    case OperandType.ShortInlineBrTarget: { int rel = (sbyte)code[p]; p += 1; operandText = $"IL_{p + rel:x4}"; break; }
                    case OperandType.InlineBrTarget: { int rel = BitConverter.ToInt32(code, p); p += 4; operandText = $"IL_{p + rel:x4}"; break; }
                    case OperandType.ShortInlineI: { operandText = op.Name is "unaligned." or "no." ? code[p].ToString(CultureInfo.InvariantCulture) : ((sbyte)code[p]).ToString(CultureInfo.InvariantCulture); p += 1; break; }
                    case OperandType.ShortInlineVar: { operandText = code[p].ToString(CultureInfo.InvariantCulture); p += 1; break; }
                    case OperandType.InlineVar: { operandText = BitConverter.ToUInt16(code, p).ToString(CultureInfo.InvariantCulture); p += 2; break; }
                    case OperandType.InlineI: { operandText = BitConverter.ToInt32(code, p).ToString(CultureInfo.InvariantCulture); p += 4; break; }
                    case OperandType.InlineI8: { operandText = BitConverter.ToInt64(code, p).ToString(CultureInfo.InvariantCulture); p += 8; break; }
                    case OperandType.ShortInlineR: { operandText = BitConverter.ToSingle(code, p).ToString("R", CultureInfo.InvariantCulture) + "f"; p += 4; break; }
                    case OperandType.InlineR: { operandText = BitConverter.ToDouble(code, p).ToString("R", CultureInfo.InvariantCulture); p += 8; break; }
                    case OperandType.InlineSwitch:
                    {
                        int n = BitConverter.ToInt32(code, p); p += 4;
                        int baseOff = p + 4 * n;
                        var targets = new List<string>(n);
                        for (int k = 0; k < n; k++) targets.Add($"IL_{baseOff + BitConverter.ToInt32(code, p + 4 * k):x4}");
                        p = baseOff;
                        operandText = "(" + string.Join(", ", targets) + ")";
                        break;
                    }
                    case OperandType.InlineString:
                    case OperandType.InlineField:
                    case OperandType.InlineMethod:
                    case OperandType.InlineSig:
                    case OperandType.InlineTok:
                    case OperandType.InlineType:
                    {
                        int tok = BitConverter.ToInt32(code, p); p += 4;
                        var r = Resolve(m, tok);
                        res = r;
                        operandText = r.Kind == "string" ? r.Text : $"{r.Text}  /*0x{tok:X8}*/";
                        break;
                    }
                    default: operandText = "?"; break;
                }
            }
            catch (Exception e)
            {
                il?.AppendLine($"    IL_{start:x4}: {op.Name} <operand decode failed: {e.GetType().Name}>");
                break;
            }

            il?.Append("    IL_").Append(start.ToString("x4")).Append(": ").Append(op.Name).Append(operandText.Length > 0 ? " " : "").AppendLine(operandText);

            if (x != null && res is { } rr) Record(x, start, op.Name ?? "", rr);
        }

        if (il != null && body.ExceptionRegions.Length > 0)
        {
            foreach (var r in body.ExceptionRegions)
            {
                string extra = r.Kind switch
                {
                    ExceptionRegionKind.Catch => " catch " + (r.CatchType.IsNil ? "?" : Resolve(m, MetadataTokens.GetToken(r.CatchType)).Key),
                    ExceptionRegionKind.Filter => $" filter IL_{r.FilterOffset:x4}",
                    ExceptionRegionKind.Finally => " finally",
                    _ => " fault"
                };
                il.AppendLine($"    .try IL_{r.TryOffset:x4}-IL_{r.TryOffset + r.TryLength:x4}{extra} handler IL_{r.HandlerOffset:x4}-IL_{r.HandlerOffset + r.HandlerLength:x4}");
            }
        }
        return true;
    }

    void ImmutableArrayOrEmpty(out TypeSig[] locals, Module m, MethodBodyBlock body)
    {
        locals = Array.Empty<TypeSig>();
        if (body.LocalSignature.IsNil) return;
        try { locals = m.MD.GetStandaloneSignature(body.LocalSignature).DecodeLocalSignature(W.P, SigCtx.For(m)).ToArray(); }
        catch { /* leave empty */ }
    }

    static void Record(XMethod x, int off, string op, Resolved r)
    {
        switch (op)
        {
            case "call": case "callvirt": case "newobj": case "ldftn": case "ldvirtftn": case "jmp":
                if (r.Kind == "method") x.Calls.Add((r.Key, off, op));
                break;
            case "ldfld": case "ldsfld":
                if (r.Kind == "field") x.Fields.Add((r.Key, off, 'r'));
                break;
            case "ldflda": case "ldsflda":
                if (r.Kind == "field") x.Fields.Add((r.Key, off, 'a'));
                break;
            case "stfld": case "stsfld":
                if (r.Kind == "field") x.Fields.Add((r.Key, off, 'w'));
                break;
            case "ldstr":
                x.Strings.Add((off, r.Key.Length > 200 ? r.Key[..200] + "…" : r.Key));
                break;
            case "ldtoken":
                if (r.Kind == "type") x.Types.Add((r.Key, off, "ldtoken"));
                else if (r.Kind == "method") x.Calls.Add((r.Key, off, "ldtoken"));
                else if (r.Kind == "field") x.Fields.Add((r.Key, off, 'a'));
                break;
            case "castclass": case "isinst": case "newarr": case "box": case "unbox": case "unbox.any":
            case "initobj": case "ldelem": case "stelem": case "sizeof": case "constrained.": case "ldobj": case "stobj":
            case "cpobj": case "mkrefany": case "refanyval":
                if (r.Kind == "type") x.Types.Add((r.Key, off, op));
                break;
        }
    }
}
