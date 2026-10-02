#!/usr/bin/env python3
"""MiniMax engineer: lets an LLM (MiniMax, reached through an injected chat function) edit the bot's code SAFELY.

Pipeline (every step is gated, nothing reaches the live tree or the game by surprise):

  engineer-queue.jsonl  (append-only, written by the command center)           <agent>/engineer-queue.jsonl
        |  run_task(id)      isolated workspace copy  <agent>/engineer/work/<id>/{base,work}
        |                    agent loop (ls/read/grep/edit/create/build/test/finish) - text JSON protocol
        |                    gates: build + tests + lint (vs BASE) + size limits + static safety scan
        v
  status "patched"  + <agent>/engineer/<id>.diff   (unified diff base->work, a/ b/ repo-relative paths)
        |  apply_patch(id)   git apply --check on the CURRENT real tree -> git apply -> build gate on the real tree
        v                    (backups in <id>.prev/, automatic restore if the build fails, "conflict" if the tree moved)
  status "applied"
        |  deploy(id, confirm=True)   cooldown + backup of the deployed DLL + deploy script + health check
        v                             (automatic rollback of DLL and source if the health check fails)
  status "deployed" | "rolled-back"

The queue file is never rewritten; per-task state lives in the sidecar <agent>/engineer-status.json.
The module never imports coach-server: the chat function, runner and deploy hooks are injected, so tests run with fakes.
See docs/ENGINEER.md for the safety model, configuration and the integration contract.
"""
import ast
import bisect
import codecs
import difflib
import fnmatch
import hashlib
import json
import os
import re
import shutil
import stat
import subprocess
import sys
import tempfile
import threading
import time
import traceback
from pathlib import Path

__version__ = "1.0"

# ====================================================================================================== configuration
DEFAULT_CFG = {
    "mode": "semi",                    # off | semi (prepare patches only) | auto (also apply)
    "auto_deploy": False,              # auto mode may deploy only when this is literally true
    "max_steps": 28,
    "max_tokens_total": 400000,
    "wall_timeout_s": 840,             # 14 min per task
    "max_changed_lines": 400,          # added + removed
    "max_files": 6,
    "min_gap_s": 600,                  # autorun: at most one task per this many seconds
    "max_pending_patches": 3,          # autorun pauses while this many patches wait for approval
    "max_attempts": 3,                 # autorun never runs the same task more than this many times (conflicts/failures included)
    "deploy_cooldown_s": 900,
    "health_timeout_s": 150,
    "health_fresh_s": 20,
    "health_require_caps": True,
    "model_max_tokens": 8000,
    "model_retries": 2,                # extra attempts when the chat function raises
    "max_invalid": 3,                  # invalid replies in a row before the run is aborted
    "obs_chars": 6000,                 # observation size cap
    "keep_obs": 6,                     # full observations kept in the conversation
    "read_max_lines": 220,
    "grep_max": 40,
    "grep_line_chars": 160,
    "build_timeout_s": 420,
    "test_timeout_s": 1200,
    "deploy_timeout_s": 600,
    "keep_workspaces": 4,
    "max_copy_file_bytes": 3000000,
    "max_edit_file_bytes": 1500000,
    "max_create_bytes": 200000,
    "auto_apply_max_lines": 400,
    "auto_deploy_max_lines": 150,
    "auto_deploy_max_files": 3,
    "relaunch_after_restore": True,
    "require_backup": True,
    "game_dir": "",                    # default: derived from the agent dir (<game>/BepInEx/plugins/agent)
    "deployed_dll": "",                # default: <agent>/../ThronefallTrainer.dll
    "python_tests": ["test_incidents.py", "test_command_center.py"],   # allowlist (names or globs, "*" = discover all) of tests/test_*.py the production runner runs:
                                       # unknown scripts may open windows, drive a browser or capture the screen (tests/test_wgc_real.py does) - never run those unasked
    "test_projects": ["GatePlanner.Tests", "ActLogic.Tests", "Replay"],   # allowlist (names or globs) of tests/<dir>/*.csproj console test projects
    "skip_python_tests": [],           # tests/test_*.py file names the production runner must not run (read when the Engineer is constructed)
    "skip_test_projects": [],          # tests/<dir> C# test project dirs to skip (e.g. a fixture suite that is known to be flaky)
    "project_notes": "",               # extra text appended to the first user message (e.g. sandbox hints)
}
# numeric settings are clamped to (lo, hi): a typo like 1e999 or -5 in cc-config.json must not disable a limit or crash the constructor
CFG_RANGE = {"max_steps": (1, 200), "max_tokens_total": (1, 5000000), "wall_timeout_s": (1, 7200), "max_changed_lines": (1, 5000), "max_files": (1, 50),
             "min_gap_s": (0, 86400), "max_pending_patches": (1, 50), "max_attempts": (1, 20), "deploy_cooldown_s": (0, 86400), "health_timeout_s": (0, 1800),
             "health_fresh_s": (1, 600), "model_max_tokens": (16, 64000), "model_retries": (0, 10), "max_invalid": (1, 20), "obs_chars": (500, 40000),
             "keep_obs": (1, 20), "read_max_lines": (5, 1000), "grep_max": (1, 500), "grep_line_chars": (20, 2000), "build_timeout_s": (1, 7200),
             "test_timeout_s": (1, 14400), "deploy_timeout_s": (1, 7200), "keep_workspaces": (1, 50), "max_copy_file_bytes": (1000, 100000000),
             "max_edit_file_bytes": (1000, 20000000), "max_create_bytes": (100, 5000000), "auto_apply_max_lines": (0, 5000), "auto_deploy_max_lines": (0, 5000),
             "auto_deploy_max_files": (0, 50)}
PRIORITY_RANK = {"urgent": 0, "high": 1, "normal": 2, "low": 3}
MODES = ("off", "semi", "auto")

ALLOWED_ACTIONS = {
    "queued": ["run", "reject"], "working": [], "patched": ["diff", "apply", "reject"], "applying": [],
    "applied": ["diff", "deploy", "revert"], "apply-failed": ["diff", "requeue", "reject"], "deploying": [],
    "deployed": ["diff"], "rolled-back": ["diff", "requeue"], "failed": ["requeue", "reject"],
    "no-change": ["requeue", "reject"], "rejected": ["requeue"],
}

# ====================================================================================================== path policy
EDIT_ROOTS = ("src", "tests", "tools", "docs")
FORBIDDEN_DIRS = {".git", "bin", "obj", "dist", "reference", "node_modules", "__pycache__", ".vs", ".vscode", "desktop"}
FORBIDDEN_PREFIXES = ("decompiled",)
# Files/extensions the model may never create or edit: the gates themselves, the deploy/supervisor scripts and anything executable.
PROTECTED_FILES = {"tools/mm_engineer.py", "tools/engineer-sim.py", "tests/test_mm_engineer.py", "tools/bot-lint.ps1",
                   "tools/build-and-deploy.ps1", "tools/coach-supervisor.ps1", "tools/install-supervisor.ps1"}
PROTECTED_EXTS = {".ps1", ".psm1", ".psd1", ".bat", ".cmd", ".sh", ".vbs", ".wsf", ".exe", ".dll", ".so", ".dylib", ".reg",
                  ".lnk", ".msi", ".jar", ".pdb", ".zip", ".7z"}
SERVER_FILES_BASE = ("tools/coach-server.py", "tools/command_center.py")      # edits need a coach-server restart (+ modules they import)
TEXT_EXTS = {".cs", ".py", ".md", ".json", ".txt", ".csproj", ".props", ".targets", ".sln", ".ps1", ".js", ".css", ".html", ".xml",
             ".ini", ".cfg", ".toml", ".yml", ".yaml", ".jsonl", ".csv", ".bat", ".cmd", ".sh", ".editorconfig", ".gitignore", ""}
WIN_RESERVED = {"con", "prn", "aux", "nul", "conin$", "conout$"} | {"com%d" % i for i in range(1, 10)} | {"lpt%d" % i for i in range(1, 10)}
# extensions the model may create/edit: text only (an allow-list - .pyw .hta .scr .com .pyz ... are not text the project uses and would run when double-clicked/imported)
WRITABLE_EXTS = TEXT_EXTS - PROTECTED_EXTS
# build/test/import machinery that a file of this NAME changes at any depth (nuget feeds, MSBuild imports, python startup hooks, git attribute filters)
PROTECTED_NAMES = {"global.json", "nuget.config", "directory.build.props", "directory.build.targets", "directory.packages.props", "packages.lock.json",
                   "sitecustomize.py", "usercustomize.py", "conftest.py", "__init__.py", "__main__.py", "pyvenv.cfg", ".gitattributes", ".gitmodules"}
PROTECTED_MODULES = {"mm_engineer"}                                         # importable gate modules: no package/module of this name may be created next to them
_STDLIB_FALLBACK = set("""abc argparse array ast asyncio base64 bisect builtins calendar cgi cmd code codecs codeop collections colorsys concurrent configparser contextlib copy csv ctypes
dataclasses datetime decimal difflib dis doctest email encodings enum errno faulthandler filecmp fnmatch fractions ftplib functools gc getopt getpass gettext glob gzip hashlib heapq hmac
html http imaplib importlib inspect io ipaddress itertools json keyword linecache locale logging lzma mailbox marshal math mimetypes mmap msvcrt multiprocessing netrc nt numbers
operator optparse os pathlib pdb pickle pkgutil platform plistlib poplib posix pprint profile pty pwd queue quopri random re readline reprlib resource runpy sched secrets select
selectors shelve shlex shutil signal site smtplib socket socketserver sqlite3 ssl stat statistics string stringprep struct subprocess sys sysconfig tarfile telnetlib tempfile test
textwrap threading time timeit tkinter token tokenize trace traceback tracemalloc types typing unicodedata unittest urllib uuid venv warnings wave weakref webbrowser winreg winsound
xml xmlrpc zipapp zipfile zipimport zlib _thread _winapi _ctypes _socket _ssl _io _json _pickle""".split())


def stdlib_names():
    names = getattr(sys, "stdlib_module_names", None)
    return {str(n).lower() for n in names} if names else _STDLIB_FALLBACK


class ActionError(Exception):
    """A bad action or a refused operation: reported to the model as an ERROR observation."""


class PolicyError(ActionError):
    pass


class ProtocolError(Exception):
    """The model's reply was not one valid action."""


class DiffError(Exception):
    pass


def norm_rel(raw):
    """Validate a model-supplied path string and return a clean repo-relative POSIX path ('.' for the root). No filesystem access."""
    if not isinstance(raw, str) or not raw.strip():
        raise PolicyError("path is empty")
    p = raw.strip().replace("\\", "/")
    if any(ord(c) < 32 for c in p):
        raise PolicyError("path contains control characters")
    if any(ord(c) > 126 for c in p):
        # NTFS compares names with its own case table (e.g. U+0131 matches 'I'), so a non-ASCII spelling could alias a protected file
        raise PolicyError("only ASCII characters are allowed in paths")
    if any(c in '<>"|?*' for c in p):
        raise PolicyError("characters < > \" | ? * are not allowed in a path")
    if p.startswith("/") or re.match(r"^[A-Za-z]:", p):
        raise PolicyError("absolute paths are not allowed - use a path relative to the repo root (e.g. src/Bot.cs)")
    if ":" in p:
        raise PolicyError("':' is not allowed in a path")
    parts = [x for x in p.split("/") if x not in ("", ".")]
    for x in parts:
        if x == "..":
            raise PolicyError("'..' is not allowed in a path")
        if x.rstrip(". ") != x:
            raise PolicyError("path components may not end with '.' or a space")
        if re.search(r"~\d", x):
            raise PolicyError("8.3 short names ('~1') are not allowed - they can alias another file")
        if x.split(".")[0].lower() in WIN_RESERVED:
            raise PolicyError("reserved device name in path: %s" % x)
    return "/".join(parts) if parts else "."


def check_not_forbidden(rel):
    for part in rel.split("/"):
        low = part.lower()
        if low in FORBIDDEN_DIRS or low.startswith(FORBIDDEN_PREFIXES):
            raise PolicyError("'%s' is inside a forbidden location (%s) - generated/decompiled/build output is off limits" % (rel, part))


def check_writable(rel):
    """rel is already normalised and not forbidden. Raise PolicyError unless the model may create/edit it."""
    parts = rel.split("/")
    if rel == "." or parts[0].lower() not in EDIT_ROOTS:
        raise PolicyError("edits are only allowed under src/, tests/, tools/ or docs/ (got '%s')" % rel)
    low = rel.lower()
    ext = os.path.splitext(low)[1]
    if low in PROTECTED_FILES:
        raise PolicyError("'%s' is protected (it is part of the gates/deploy tooling) and cannot be edited by the engineer" % rel)
    if ext in PROTECTED_EXTS:
        raise PolicyError("'%s': scripts and binaries (%s) cannot be created or edited by the engineer" % (rel, ext))
    if ext not in WRITABLE_EXTS:
        raise PolicyError("'%s': only text files (%s) can be created or edited by the engineer, not '%s'" % (rel, ", ".join(sorted(e for e in WRITABLE_EXTS if e)), ext))
    base = low.rsplit("/", 1)[-1]
    if base in PROTECTED_NAMES:
        raise PolicyError("'%s' is a build/import configuration file (%s) that changes how everything else is built or loaded - it cannot be edited by the engineer" % (rel, base))
    if parts[0].lower() in ("tools", "tests") and len(parts) >= 2:
        stem = parts[1].split(".")[0].lower()                               # a new module/package next to the python scripts shadows an import: tools/json.py, tools/mm_engineer/__init__.py
        if stem in stdlib_names() or stem in PROTECTED_MODULES:
            raise PolicyError("'%s' would shadow the python module '%s' (python searches this folder first, so every script that imports it would load the new file instead)" % (rel, stem))


def shadow_conflict(root, rel):
    """A NEW top-level entry of tools/ or tests/ must not reuse the name of an existing python module or package there (a package beats a module, and a tests/ module
    can beat a tools/ one). Returns the existing entry it would shadow, or None. Touches the filesystem (read only)."""
    parts = rel.split("/")
    if len(parts) < 2 or parts[0].lower() not in ("tools", "tests"):
        return None
    stem = parts[1].split(".")[0].lower()
    mine = "/".join(parts[:2]).lower()
    for top in ("tools", "tests"):
        try:
            entries = list(os.scandir(Path(root) / top))
        except OSError:
            continue
        for e in entries:
            n = e.name.lower()
            hit = (e.is_dir(follow_symlinks=False) and n == stem) or (n.endswith(".py") and n[:-3] == stem)
            if hit and "%s/%s" % (top, n) != mine:
                return "%s/%s" % (top, e.name)
    return None


def is_reparse(path):
    """True for symlinks, junctions and any other reparse point."""
    try:
        st = os.lstat(path)
    except OSError:
        return False
    return stat.S_ISLNK(st.st_mode) or bool(getattr(st, "st_file_attributes", 0) & 0x400)


def skip_dir_name(name):
    low = name.lower()
    return low in FORBIDDEN_DIRS or low.startswith(FORBIDDEN_PREFIXES)


# ====================================================================================================== small utilities
def jdump(o):
    return json.dumps(o, default=str, separators=(",", ":"))


def clip(text, n):
    text = text if isinstance(text, str) else str(text)
    if len(text) <= n:
        return text
    return text[:n] + "\n...[truncated %d chars]" % (len(text) - n)


def clip1(text, n):
    """clip() for one-line contexts (lists, step summaries): newlines folded, cut with an ellipsis."""
    text = " ".join((text if isinstance(text, str) else str(text)).split())
    return text if len(text) <= n else text[:max(0, n - 3)] + "..."


def sha256_hex(b):
    return hashlib.sha256(b).hexdigest()


def read_bytes(p):
    with open(p, "rb") as f:
        return f.read()


def atomic_write(path, data):
    path = str(path)
    tmp = "%s.tmp%d" % (path, os.getpid())
    with open(tmp, "wb") as f:
        f.write(data)
    for i in range(8):
        try:
            os.replace(tmp, path)
            return
        except PermissionError:
            if i == 7:
                try:
                    os.remove(tmp)
                except OSError:
                    pass
                raise
            time.sleep(0.05 * (i + 1))


def read_json_retry(path, tries=8):
    """Read a JSON file that another thread/process may be replacing right now. Returns (obj, state) with state in ok | missing | corrupt | error.
    On Windows an open() that races an os.replace fails with PermissionError for a few milliseconds - that must never be mistaken for 'empty'."""
    last = "error"
    for i in range(tries):
        try:
            with open(path, encoding="utf-8") as f:
                return json.load(f), "ok"
        except FileNotFoundError:
            return None, "missing"
        except ValueError:
            last = "corrupt"                                                # a torn/garbled file: look again, the writer may have finished meanwhile
        except OSError:
            last = "error"
        time.sleep(0.01 * (i + 1))
    return None, last


def rmtree_force(path):
    path = str(path)

    def _fix(func, p, exc):
        try:
            os.chmod(p, stat.S_IWRITE)
            func(p)
        except OSError:
            pass
    for _ in range(3):
        if not os.path.lexists(path):
            return
        try:
            if sys.version_info >= (3, 12):
                shutil.rmtree(path, onexc=lambda f, p, e: _fix(f, p, e))
            else:
                shutil.rmtree(path, onerror=lambda f, p, e: _fix(f, p, e))
        except OSError:
            pass
        if os.path.lexists(path):
            time.sleep(0.2)


def count_lines(raw):
    return raw.count(b"\n") + (1 if raw and not raw.endswith(b"\n") else 0)


def split_keepends(raw):
    """Split bytes on b'\\n' only, keeping the terminator (a final unterminated line is kept as is)."""
    parts = raw.split(b"\n")
    out = [p + b"\n" for p in parts[:-1]]
    if parts[-1]:
        out.append(parts[-1])
    return out


def pid_alive(pid):
    """Does a process with this pid exist? (never signals it - on Windows only a query handle is opened)"""
    try:
        pid = int(pid)
    except (TypeError, ValueError):
        return False
    if pid <= 0:
        return False
    if os.name == "nt":
        try:
            import ctypes
            k32 = ctypes.WinDLL("kernel32", use_last_error=True)
            k32.OpenProcess.argtypes = [ctypes.c_ulong, ctypes.c_int, ctypes.c_ulong]
            k32.OpenProcess.restype = ctypes.c_void_p
            k32.GetExitCodeProcess.argtypes = [ctypes.c_void_p, ctypes.POINTER(ctypes.c_ulong)]
            k32.CloseHandle.argtypes = [ctypes.c_void_p]
            h = k32.OpenProcess(0x1000, False, pid)                         # PROCESS_QUERY_LIMITED_INFORMATION
            if not h:
                return ctypes.get_last_error() == 5                         # ERROR_ACCESS_DENIED: it exists but belongs to another account/elevation - alive; anything else: gone
            code = ctypes.c_ulong()
            ok = k32.GetExitCodeProcess(h, ctypes.byref(code))
            k32.CloseHandle(h)
            return bool(ok) and code.value == 259                           # STILL_ACTIVE
        except Exception:
            return True                                                     # unknown -> assume alive (the lock stays respected)
    try:
        os.kill(pid, 0)
        return True
    except PermissionError:
        return True
    except OSError:
        return False


def tokens_of(usage, msgs, reply):
    try:
        if isinstance(usage, dict):
            if usage.get("total_tokens"):
                return int(usage["total_tokens"])
            pt, ct = int(usage.get("prompt_tokens") or 0), int(usage.get("completion_tokens") or 0)
            if pt or ct:
                return pt + ct
    except (TypeError, ValueError):
        pass
    return (sum(len(m.get("content", "")) for m in msgs) + len(reply or "")) // 4


# ====================================================================================================== text files + exact edits
class TextFile:
    """A UTF-8 text file read for editing: LF-normalised text plus what is needed to write it back byte-exactly
    (BOM, per-line CRLF positions). The model only ever sees/types '\\n'."""

    def __init__(self, raw):
        self.bom = raw.startswith(codecs.BOM_UTF8)
        body = raw[3:] if self.bom else raw
        if b"\x00" in body[:65536]:
            raise PolicyError("binary file - not editable")
        try:
            self.raw_text = body.decode("utf-8")
        except UnicodeDecodeError:
            raise PolicyError("not a UTF-8 text file - not editable")
        self.crs = []
        k = 0
        for m in re.finditer("\r\n", self.raw_text):
            self.crs.append(m.start() - k)          # normalised index of the '\n' that was '\r\n'
            k += 1
        self.text = self.raw_text.replace("\r\n", "\n") if self.crs else self.raw_text
        nl = self.text.count("\n")
        self.eol = "\r\n" if self.crs and len(self.crs) * 2 >= nl else "\n"

    def raw_index(self, n):
        return n + bisect.bisect_left(self.crs, n)

    def eol_at(self, n):
        nl = self.text.find("\n", n)
        if nl < 0:
            return self.eol
        i = bisect.bisect_left(self.crs, nl)
        return "\r\n" if i < len(self.crs) and self.crs[i] == nl else "\n"

    def replaced(self, n_start, n_end, new):
        local = self.eol_at(n_start)
        new_raw = new.replace("\r\n", "\n")
        if local != "\n":
            new_raw = new_raw.replace("\n", local)
        out = self.raw_text[:self.raw_index(n_start)] + new_raw + self.raw_text[self.raw_index(n_end):]
        return (codecs.BOM_UTF8 if self.bom else b"") + out.encode("utf-8")

    def line_of(self, n):
        return self.text.count("\n", 0, n) + 1


def find_all(text, sub, limit=6):
    out, i = [], text.find(sub)
    while i >= 0 and len(out) < limit:
        out.append(i)
        i = text.find(sub, i + 1)
    return out


def diagnose_missing(text, old):
    """Explain why `old` was not found: whitespace-only differences are the usual cause."""
    toks = old.split()
    if toks and len(toks) <= 400:
        try:
            ms = list(re.finditer(r"\s+".join(re.escape(t) for t in toks), text))
        except re.error:
            ms = []
        if len(ms) == 1:
            m = ms[0]
            l1, l2 = text.count("\n", 0, m.start()) + 1, text.count("\n", 0, m.end()) + 1
            snippet = "\n".join(text.split("\n")[l1 - 1:l2][:25])
            hint = ""
            if "\t" in snippet and "\t" not in old:
                hint = " The file indents with TABs - write them as \\t in the JSON string."
            return ("not found as written, but the same text exists with DIFFERENT WHITESPACE at lines %d-%d. The exact text is:\n%s\n"
                    "Copy it exactly.%s" % (l1, l2, snippet, hint))
        if len(ms) > 1:
            lines = [text.count("\n", 0, m.start()) + 1 for m in ms[:6]]
            return "not found as written; the tokens match %d places ignoring whitespace (lines %s) - include more context and copy the exact text" % (len(ms), lines)
    first = next((l for l in old.split("\n") if l.strip()), "").strip()
    if first:
        stripped = [l.strip() for l in text.split("\n")]
        cands = difflib.get_close_matches(first, stripped, n=3, cutoff=0.6)
        if cands:
            found = []
            for c in cands:
                if c in stripped:
                    found.append("line %d: %s" % (stripped.index(c) + 1, clip(c, 120)))
            return "old text not found. The closest existing lines are: " + " | ".join(found) + ". Use read to copy the exact text."
    return "old text not found anywhere in the file - re-read the region with read and copy it exactly"


_TRUNC_MARK = re.compile(r"\.\.\.(?:\[\+\d+ chars\]|\(\+\d+ chars\)|\[truncated \d+ chars\]|\(output cut at line \d+|\(more entries not shown\))")


def refuse_markers(text, what):
    """Observations and the conversation history shorten long text with '...[+N chars]'-style markers. Copying one into the code would silently
    commit a truncated line, so such text is refused."""
    if isinstance(text, str):
        m = _TRUNC_MARK.search(text)
        if m:
            raise ActionError("%s contains the truncation marker '%s' that the system inserted into an observation - that text is NOT in the file. "
                              "Re-read the full line with read (a narrower start/end range) and write the real code." % (what, m.group(0)))


def apply_edit(tf, old, new):
    """Replace the single exact occurrence of `old` in the file. Returns (new_raw_bytes, info). Raises ActionError."""
    if not isinstance(old, str) or not isinstance(new, str):
        raise ActionError("'old' and 'new' must be strings")
    refuse_markers(new, "'new'")
    old_n = old.replace("\r\n", "\n")
    new_n = new.replace("\r\n", "\n")
    if not old_n:
        raise ActionError("'old' is empty - give the exact existing text to replace (use create for new files)")
    if old_n == new_n:
        raise ActionError("'old' and 'new' are identical - nothing to change")
    hits = find_all(tf.text, old_n)
    if not hits:
        raise ActionError("old text occurs 0 times: " + diagnose_missing(tf.text, old_n))
    if len(hits) > 1:
        shown = ", ".join(str(tf.line_of(h)) for h in hits[:6])
        raise ActionError("old text occurs %d%s times (lines %s) - it must occur EXACTLY ONCE. Add surrounding lines (the line before/after) to make it unique." %
                          (len(hits), "+" if len(hits) >= 6 else "", shown))
    n0 = hits[0]
    new_raw = tf.replaced(n0, n0 + len(old_n), new_n)
    info = {"line": tf.line_of(n0), "removed": old_n.count("\n") + 1, "added": new_n.count("\n") + 1 if new_n else 0}
    return new_raw, info


# ====================================================================================================== diffs
def _fmt_range(start, stop):
    beginning, length = start + 1, stop - start
    if length == 1:
        return "%d" % beginning
    if not length:
        beginning -= 1
    return "%d,%d" % (beginning, length)


def _emit(prefix, line):
    if line.endswith(b"\n"):
        return prefix + line
    return prefix + line + b"\n\\ No newline at end of file\n"


def make_file_diff(rel, a, b, ctx=3):
    """Unified diff of one file as bytes (a/ b/ prefixes, LF headers, content lines byte-exact incl. CRLF). a/b None = absent."""
    if a == b:
        return b""
    relb = rel.encode("utf-8")
    out = [b"diff --git a/" + relb + b" b/" + relb + b"\n"]
    if a is None:
        out.append(b"new file mode 100644\n--- /dev/null\n+++ b/" + relb + b"\n")
    elif b is None:
        out.append(b"deleted file mode 100644\n--- a/" + relb + b"\n+++ /dev/null\n")
    else:
        out.append(b"--- a/" + relb + b"\n+++ b/" + relb + b"\n")
    al, bl = split_keepends(a or b""), split_keepends(b or b"")
    sm = difflib.SequenceMatcher(None, al, bl, autojunk=False)
    for group in sm.get_grouped_opcodes(ctx):
        f, l = group[0], group[-1]
        out.append(("@@ -%s +%s @@\n" % (_fmt_range(f[1], l[2]), _fmt_range(f[3], l[4]))).encode("ascii"))
        for tag, i1, i2, j1, j2 in group:
            if tag == "equal":
                out.extend(_emit(b" ", x) for x in al[i1:i2])
                continue
            if tag in ("replace", "delete"):
                out.extend(_emit(b"-", x) for x in al[i1:i2])
            if tag in ("replace", "insert"):
                out.extend(_emit(b"+", x) for x in bl[j1:j2])
    return b"".join(out)


def changed_lines(a, b):
    """added + removed line count between two byte strings (None = absent)."""
    if a == b:
        return 0
    al, bl = split_keepends(a or b""), split_keepends(b or b"")
    n = 0
    for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, al, bl, autojunk=False).get_opcodes():
        if tag != "equal":
            n += (i2 - i1) + (j2 - j1)
    return n


_HUNK = re.compile(r"^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@")


def parse_diff(data):
    """Parse a unified/git diff into per-file dicts {path,new,deleted,added[],removed[],hunks}. Raises DiffError when malformed."""
    text = data.decode("utf-8", "surrogateescape") if isinstance(data, (bytes, bytearray)) else data
    lines = text.split("\n")
    files, cur, i = [], None, 0
    while i < len(lines):
        ln = lines[i]
        if ln.startswith("diff --git "):
            m = re.match(r"diff --git a/(.+?) b/(.+?)\r?$", ln)
            cur = {"path": m.group(2) if m else None, "new": False, "deleted": False, "special": False, "added": [], "removed": [], "added_at": [], "removed_at": [], "hunks": 0}
            files.append(cur)
            i += 1
            continue
        if cur is None:
            i += 1
            continue
        if ln.startswith("new file mode"):
            cur["new"] = True
            if ln.strip() != "new file mode 100644":                        # only regular non-executable files: 120000 (symlink), 100755, 160000 (submodule) are refused
                cur["special"] = True
        elif ln.startswith("deleted file mode"):
            cur["deleted"] = True
        elif ln.startswith(("rename ", "copy ", "old mode", "new mode", "similarity ", "Binary files", "GIT binary patch")):
            cur["special"] = True
        elif ln.startswith("+++ "):
            p = ln[4:].rstrip("\r")
            if p.startswith("b/"):
                cur["path"] = p[2:]
        elif ln.startswith("@@"):
            m = _HUNK.match(ln)
            if not m:
                raise DiffError("bad hunk header: %r" % ln[:60])
            old_n = int(m.group(2)) if m.group(2) is not None else 1
            new_n = int(m.group(4)) if m.group(4) is not None else 1
            old_no, new_no = int(m.group(1)), int(m.group(3))                # 1-based line numbers in the old / new file (the scan maps added lines back to the whole files)
            i += 1
            co = cn = 0
            while co < old_n or cn < new_n:
                if i >= len(lines):
                    raise DiffError("truncated hunk in %s" % cur["path"])
                l = lines[i]
                if l.startswith("\\"):
                    i += 1
                    continue
                tag, body = l[:1], l[1:].rstrip("\r")
                if tag == " " or l == "":
                    co += 1
                    cn += 1
                    old_no += 1
                    new_no += 1
                elif tag == "-":
                    co += 1
                    cur["removed"].append(body)
                    cur["removed_at"].append(old_no)
                    old_no += 1
                elif tag == "+":
                    cn += 1
                    cur["added"].append(body)
                    cur["added_at"].append(new_no)
                    new_no += 1
                else:
                    raise DiffError("unexpected line in hunk of %s: %r" % (cur["path"], l[:60]))
                i += 1
            while i < len(lines) and lines[i].startswith("\\"):
                i += 1
            cur["hunks"] += 1
            continue
        i += 1
    for f in files:
        if not f["path"]:
            raise DiffError("diff entry without a path")
    return files


def diff_stats(files):
    return {"files": [f["path"] for f in files], "added": sum(len(f["added"]) for f in files), "removed": sum(len(f["removed"]) for f in files)}


# ====================================================================================================== static safety scan
class Rule:
    def __init__(self, rid, rx, exts, msg, severity="violation", exempt=None):
        self.id, self.rx, self.exts, self.msg, self.severity, self.exempt = rid, re.compile(rx, re.I if rid == "net-nonlocal" else 0), exts, msg, severity, exempt

    def hit(self, line):
        if not self.rx.search(line):
            return False
        return not (self.exempt and self.exempt(line))


CS, PY, JS, MSB = (".cs",), (".py",), (".js",), (".csproj", ".props", ".targets", ".sln")
ANYCODE = (".cs", ".py", ".js", ".html", ".css", ".csproj", ".props", ".targets")
SCAN_EXTS = frozenset(ANYCODE) | {".sln"}                                  # .json .txt .md .xml .ini ... are data, not scanned (nothing runs them)
_AGENT_HINT = re.compile(r"AgentDir|agentDir|\bAgent\b|\bP\(|\.tmp\b|\btmp\b|GetTempPath|\"agent\"", re.I)
_DELETE_CALL = re.compile(r"\b(?:File|Directory)\s*\.\s*Delete\s*\(")


def _delete_args_ok(line):
    """True when EVERY File/Directory.Delete(...) call on the line visibly targets the agent directory or a temp file."""
    found = False
    for m in _DELETE_CALL.finditer(line):
        found = True
        depth, i = 1, m.end()
        while i < len(line) and depth:
            depth += {"(": 1, ")": -1}.get(line[i], 0)
            i += 1
        if not _AGENT_HINT.search(line[m.end():i - 1] if depth == 0 else line[m.end():]):
            return False
    return found


def _instance_delete_ok(line):
    return bool(_AGENT_HINT.search(line))


_HINT_VALUE = re.compile(r"<HintPath>([^<]*)</HintPath>", re.I)


def _hintpath_ok(line):
    """A game assembly reference ($(GameDir)\\...\\Managed\\X.dll) is how the project is built; any other HintPath (or one split over several lines) is not."""
    vals = _HINT_VALUE.findall(line)
    return bool(vals) and len(vals) == len(re.findall(r"<HintPath\b", line, re.I)) and all(v.strip().lower().startswith("$(gamedir)") and ".." not in v for v in vals)


_SDK_ATTR = re.compile(r"""\bSdk\s*=\s*"([^"]*)\"""")


def _sdk_ok(line):
    """The standard SDK is fine; any other MSBuild SDK may run arbitrary code at restore/build time."""
    vals = _SDK_ATTR.findall(line)
    return bool(vals) and all(v == "Microsoft.NET.Sdk" for v in vals)


_LOCAL_URL = re.compile(r"https?://(?:127\.0\.0\.1|localhost|\[::1\])(?![\w.-])", re.I)
_LOCAL_PROTO_REL = re.compile(r"//\s*(?:127\.0\.0\.1|localhost|\[::1\])(?![\w.-])", re.I)
_ANY_URL = re.compile(r"https?://[^\s\"')<>]+", re.I)
_NET_CLASS = re.compile(r"\b(?:WebClient|HttpClient|HttpWebRequest|WebRequest\s*\.\s*Create|UnityWebRequest|TcpClient|UdpClient|FtpWebRequest|SmtpClient|"
                        r"Socket|NetworkStream|TcpListener|HttpListener|WWW|ClientWebSocket|System\s*\.\s*Net\s*\.\s*Sockets|Dns\s*\.\s*Get\w+|"
                        r"urllib\.request|http\.client|requests\.(?:get|post|put|request)|socket\.socket|socket\.create_connection)\b")


_NAMESPACE_URL = re.compile(r"https?://(?:www\.w3\.org|schemas\.microsoft\.com|schemas\.xmlsoap\.org|json-schema\.org)/", re.I)    # XML/SVG namespace identifiers, not network targets


def _net_exempt(line):
    """Network use is only acceptable towards localhost, and only when the target is visible on the same line."""
    urls = _ANY_URL.findall(line)
    if urls and not _NET_CLASS.search(line):
        return all(_LOCAL_URL.match(u) or _NAMESPACE_URL.match(u) for u in urls)      # a bare URL string: fine when local or a namespace id
    if urls:
        return all(_LOCAL_URL.match(u) for u in urls)                                  # a network class next to a URL: it must be local
    return False


def _js_net_exempt(line):
    """Browser code talking to ITS OWN origin (location.host/origin) or to a visible local URL."""
    if re.search(r"\blocation\s*\.\s*(?:host|hostname|origin|port)\b", line):
        return True
    urls = _ANY_URL.findall(line)
    return bool(urls) and all(_LOCAL_URL.match(u) or _NAMESPACE_URL.match(u) for u in urls)


# an absolute Windows path or UNC share inside a string literal: new code derives its paths from the agent dir / repo root, it does not reach for other folders
# (K:\private\.env holds the API key). "x:\tab" style format strings do not match: after the drive a path segment AND another separator (or a well-known root) must follow.
_ABS_PATH = re.compile(r"""(?:["']|@")\s*(?:[A-Za-z]:(?:\\\\|\\|/)+(?:[\w.$ -]+(?:\\\\|\\|/)|(?:Windows|Users|Program|private|ProgramData|Temp)\b)|(?:\\\\\\\\|\\\\)[\w.$-]+(?:\\\\|\\))""")
_ABS_PATH_VALUE = re.compile(r"^\s*(?:[A-Za-z]:[\\/]|\\\\[\w.$-]+\\)")

RULES = [
    Rule("process-spawn", r"\bProcess\b|\bProcessStartInfo\b|\bShellExecute\w*\b|\bCreateProcess\w*\b|System\.Diagnostics\.Process\b", CS,
         "starting/killing/inspecting OS processes from bot code (Process, ProcessStartInfo, System.Diagnostics.Process)"),
    Rule("process-spawn", r"\bsubprocess\b|\bos\.(?:system|popen|exec\w*|spawn\w*|posix_spawn\w*|startfile|fork\w*)\b|"
                          r"\bfrom\s+os\s+import\b[^#\n]*\b(?:system|popen|exec\w*|spawn\w*|posix_spawn\w*|startfile)\b|\bShellExecute\b|\btaskkill\b|"
                          r"\bcreate_subprocess_\w+|\bsubprocess_(?:exec|shell)\b|\b_winapi\b|\bmultiprocessing\b|\bimport\s+pty\b", PY,
         "spawning OS processes from python code"),
    Rule("file-delete", r"\b(?:File|Directory)\s*\.\s*Delete\s*\(", CS, "File.Delete/Directory.Delete outside the agent directory (the target must be visibly under the agent dir/tmp)",
         exempt=_delete_args_ok),
    Rule("file-delete", r"\b(?:File|Directory)\s*\.\s*Delete\b(?!\s*\()|\.\s*Delete\s*\(\s*(?:true|false)?\s*\)|\bFileSystem\s*\.\s*Delete\w+", CS,
         "deleting files through FileInfo/DirectoryInfo.Delete() or a File.Delete method group outside the agent directory", exempt=_instance_delete_ok),
    Rule("file-delete", r"\bshutil\.rmtree\b|\bos\.(?:remove|unlink|rmdir|removedirs)\b|\.unlink\s*\(|\.rmdir\s*\(|"
                        r"\bfrom\s+(?:os|shutil)\s+import\b[^#\n]*\b(?:remove|unlink|rmdir|removedirs|rmtree)\b", PY, "deleting files from python code"),
    Rule("registry", r"\bRegistry(?:Key)?\b|Microsoft\.Win32", CS, "Windows registry access"),
    Rule("net-nonlocal", r"\bhttps?://|(?-i:" + _NET_CLASS.pattern + ")", ANYCODE,
         "network access to a non-localhost host (WebClient/HttpClient/HttpWebRequest/Socket/URL literal); only 127.0.0.1/localhost with a visible target is allowed",
         exempt=_net_exempt),
    Rule("net-nonlocal", r"\bfrom\s+socket\s+import\b|\bimport\s+socket\b|\bfrom\s+http\s+import\s+client\b|\bfrom\s+urllib\s+import\s+request\b|\basyncio\.open_connection\b|"
                         r"\b(?:ftplib|smtplib|telnetlib|poplib|imaplib)\b|\bimport\s+requests\b", PY,
         "network access from python code (socket/http.client/urllib.request/ftplib/...); only 127.0.0.1/localhost with a visible target is allowed"),
    Rule("net-nonlocal", r"""\bfetch\s*\(|\.\s*open\s*\(\s*["'`][A-Za-z]+["'`]\s*,|\bsendBeacon\s*\(|\bimportScripts\s*\(|\bimport\s*\(|\bnew\s+(?:WebSocket|EventSource)\s*\(""", JS + (".html",),
         "browser code reaching a protocol-relative or non-local address (fetch/XMLHttpRequest/WebSocket/EventSource/sendBeacon with //host/...)",
         exempt=lambda line: not re.search(r"""(?:wss?:)?//""", line) or bool(_LOCAL_PROTO_REL.search(line)) or _js_net_exempt(line)),
    Rule("net-nonlocal", r"""\bnew\s+(?:WebSocket|EventSource|XMLHttpRequest|SharedWorker)\b|\bsendBeacon\s*\(""", JS + (".html",),
         "browser code opening a WebSocket/EventSource/XMLHttpRequest/beacon: only to its own origin (location.host) or a visible local URL", exempt=_js_net_exempt),
    Rule("net-nonlocal", r"""\burl\s*\(\s*["']?\s*//|@import\b""", (".css",), "a stylesheet loading something from another host (url(//...), @import)"),
    Rule("net-nonlocal", r"""\b(?:src|href|action|data|poster|srcset)\s*=\s*["']?\s*//""", (".html",), "an HTML element loading something from another host (src=//host/...)"),
    Rule("exit", r"\bEnvironment\s*\.\s*(?:Exit|FailFast)\b|\bApplication\s*\.\s*(?:Quit|Exit)\b", CS, "terminating the game/process (Environment.Exit, Application.Quit)"),
    Rule("exit", r"\bos\._exit\b", PY, "hard-terminating the python process"),
    Rule("dynamic-load", r"\bAssembly\s*\.\s*(?:Load\w*|UnsafeLoadFrom)\b|\bAppDomain\b|\bActivator\s*\.\s*CreateInstanceFrom\b|\bDllImport\w*|\bLibraryImport\w*|"
                         r"\bNativeLibrary\b|\bLoadLibrary\w*|\bGetProcAddress\b|\bReflection\s*\.\s*Emit\b|\bCodeDom\b|\bCSharpScript\b|\bMarshal\s*\.\s*GetDelegateForFunctionPointer\b", CS,
         "dynamic assembly loading / native interop / runtime code generation"),
    Rule("dynamic-load", r"\bType\s*\.\s*GetType\s*\(|\bAssembly\s*\.\s*GetType\s*\(|\.\s*GetType\s*\(\s*[@$]?\"", CS,
         "looking a type up BY NAME (Type.GetType(\"...\")) hides what is called from the scan - use the type directly"),
    Rule("unicode-escape", r"[A-Za-z_]\\u[0-9A-Fa-f]{4}|\\u[0-9A-Fa-f]{4}[A-Za-z_]", CS,
         "a unicode escape glued to letters (Pro\\u0063ess): inside an identifier it would hide a name from the scan - needs human review", severity="warning"),
    Rule("dynamic-load", r"\bctypes\b|\bimportlib\b|\b__import__\b|(?<![\w.])eval\s*\(|(?<![\w.])exec\s*\(|(?<![\w.])compile\s*\(|\bpickle\b|\bmarshal\b|\brunpy\b|"
                         r"\b__builtins__\b|\b__subclasses__\b|\b__globals__\b|\bsys\.modules\b", PY,
         "dynamic code loading/execution in python code"),
    Rule("dynamic-load", r"(?<![\w.$])eval\s*\(|\bnew\s+Function\s*\(|\bimportScripts\s*\(|\bimport\s*\(", JS + (".html",), "dynamic code execution in browser code (eval, new Function, import())"),
    Rule("engineer-api", r"""["'`]/engineer\b""", JS + (".html",),
         "browser code calling the engineer API (/engineer/...): applying or deploying patches is the human's decision, the engineer must not wire it up"),
    Rule("abs-path", _ABS_PATH.pattern, (".cs", ".py", ".js"),
         "absolute path literal (drive or UNC): derive paths from the agent dir / repo root; never reach for other folders (K:\\private holds secrets)"),
    Rule("msbuild-exec", r"<Exec\b|PreBuildEvent|PostBuildEvent|<UsingTask\b|<Target\b|<Import\b|<PackageReference\b|<ProjectReference\b|DownloadFile|\bCommand\s*=|"
                         r"""<Sdk\b|<Compile\b[^>]*\bInclude\s*=\s*"(?![^"]*\.cs")|<Analyzer\b|<COMReference\b|<NativeReference\b|"""
                         r"<RestoreSources\b|<RestoreAdditionalProjectSources\b|<GameDir\b|<OutDir\b|<OutputPath\b|<BaseOutputPath\b|<IntermediateOutputPath\b|<BaseIntermediateOutputPath\b|"
                         r"<ArtifactsPath\b|<UseArtifactsOutput\b", MSB,
         "build-system hooks (Exec/Target/Import/Sdk/PackageReference/Analyzer/HintPath/pre-post build events/output or GameDir overrides) run arbitrary code or redirect the build"),
    Rule("msbuild-exec", r"""\bSdk\s*=""", MSB, "a project SDK other than Microsoft.NET.Sdk (MSBuild SDKs run arbitrary code at restore/build)", exempt=_sdk_ok),
    Rule("msbuild-exec", r"""<HintPath\b|\bHintPath\s*=""", MSB, "a <Reference> to a DLL outside $(GameDir) (referenced assemblies are loaded when the test programs run)", exempt=_hintpath_ok),
    Rule("harmony-patch", r"\[\s*Harmony\w*\b|\bnew\s+Harmony\s*\(|\bHarmony\s*\.\s*(?:CreateAndPatchAll|PatchAll)\b|\.PatchAll\s*\(|\bharmony\s*\.\s*Patch\s*\(|\bHarmonyLib\b", CS,
         "new Harmony patch (changes game behaviour globally) - needs human review", severity="warning"),
    Rule("timescale", r"\bTime\s*\.\s*timeScale\s*=(?!=)|\bApplication\s*\.\s*targetFrameRate\s*=(?!=)", CS, "changes game speed/frame rate - needs human review", severity="warning"),
    Rule("threads", r"\bnew\s+Thread\s*\(|\bTask\s*\.\s*Run\b|\bThreadPool\b", CS, "new thread in a Unity plugin - needs human review", severity="warning"),
    Rule("native-memory", r"\bMarshal\s*\.\s*(?:Write|Copy|AllocHGlobal)\w*|\bunsafe\b", CS, "unsafe/native memory access - needs human review", severity="warning"),
    Rule("position-write", r"\.\s*(?:position|localPosition)\s*=(?!=)|\bSetPositionAndRotation\s*\(|\.\s*MovePosition\s*\(|\.\s*Translate\s*\(", CS,
         "writes a transform/rigidbody position (could move the hero or the world: a teleport in disguise) - needs human review", severity="warning"),
    Rule("engineer-api", r"""["']/engineer/(?:deploy|apply|config|autorun|revert|requeue|reject|run)\b""", PY,
         "server code touching the engineer's action endpoints - needs human review", severity="warning"),
]
CHEAT_BUILTIN = [
    r"\bTeleportTo\s*\(", r"\.Teleport\s*\(", r"\bTakeDamage\s*\(", r"\bheroAttack\s*\.\s*Attack\s*\(", r"\bManualAttack\b[^;\n]*\.Attack\s*\(\s*\)",
    r"\bCheats\s*\.\s*(?:GodHero|GodAll|InstantRevive|FreeBuild|GoldDrip|InstantBuild|CoinMagnet|InstantKill|DamageMultEnabled|NoCooldown|"
    r"AttackSpeedEnabled|RegenEnabled|MultiShotEnabled|EnemySpeedEnabled|EnemyDamageEnabled|EnemyHpEnabled|EndlessWaves)\b",
]


def lint_cheat_patterns(lint_script_text):
    """The cheat-call regexes tools/bot-lint.ps1 flags ($cheatCalls entries: rx = '...'), converted to python regexes."""
    out = []
    for m in re.finditer(r"rx\s*=\s*'((?:[^']|'')*)'", lint_script_text or ""):
        pat = m.group(1).replace("''", "'")
        try:
            re.compile(pat)
            out.append(pat)
        except re.error:
            pass
    return out


# ---- comment stripping: string-aware state machines (a '//' or '/*' inside a string literal is not a comment, a block comment may span lines)
def _lang_of(ext):
    return {".cs": "cs", ".js": "js", ".css": "css"}.get(ext, "cs")


def _strip_c_like(text, lang):
    """C#/JS/CSS source -> the same lines with comments removed (string/char/template literals are kept verbatim). Always returns text.count('\\n') + 1 lines."""
    out, line = [], []
    i, n = 0, len(text)
    mode, quote = None, ""
    while i < n:
        c = text[i]
        if c == "\n":
            out.append("".join(line))
            line = []
            if mode in ("str", "char"):                                      # a plain string/char literal cannot span lines: resynchronise
                mode = None
            i += 1
            continue
        if mode == "block":
            if text.startswith("*/", i):
                mode = None
                line.append(" ")
                i += 2
            else:
                i += 1
            continue
        if mode in ("str", "char"):
            line.append(c)
            if c == "\\" and i + 1 < n and text[i + 1] != "\n":
                line.append(text[i + 1])
                i += 2
                continue
            if c == quote:
                mode = None
            i += 1
            continue
        if mode == "vstr":                                                   # C# @"..." : "" is an escaped quote, may span lines
            line.append(c)
            if c == '"':
                if i + 1 < n and text[i + 1] == '"':
                    line.append('"')
                    i += 2
                    continue
                mode = None
            i += 1
            continue
        if mode == "tpl":                                                    # JS `...` template literal, may span lines
            line.append(c)
            if c == "\\" and i + 1 < n and text[i + 1] != "\n":
                line.append(text[i + 1])
                i += 2
                continue
            if c == "`":
                mode = None
            i += 1
            continue
        if lang != "css" and text.startswith("//", i):
            j = text.find("\n", i)
            i = n if j < 0 else j
            continue
        if text.startswith("/*", i):
            mode = "block"
            i += 2
            continue
        if c == '"':
            if lang == "cs" and line and (line[-1] == "@" or "".join(line[-2:]) in ("$@", "@$")):
                mode = "vstr"
            else:
                mode, quote = "str", '"'
            line.append(c)
        elif c == "'":
            mode, quote = ("char" if lang == "cs" else "str"), "'"
            line.append(c)
        elif c == "`" and lang == "js":
            mode = "tpl"
            line.append(c)
        else:
            line.append(c)
        i += 1
    out.append("".join(line))
    return out


def _strip_py(text):
    """Python source -> the same lines with '#' comments removed (strings, including triple-quoted ones, are kept verbatim)."""
    out, line = [], []
    i, n = 0, len(text)
    mode = None                                                              # None | "'" | '"' | "'''" | '"""'
    while i < n:
        c = text[i]
        if c == "\n":
            out.append("".join(line))
            line = []
            if mode in ("'", '"'):
                mode = None
            i += 1
            continue
        if mode is None:
            if c == "#":
                j = text.find("\n", i)
                i = n if j < 0 else j
                continue
            if c in "'\"":
                mode = c * 3 if text.startswith(c * 3, i) else c
                line.append(text[i:i + len(mode)])
                i += len(mode)
                continue
            line.append(c)
            i += 1
            continue
        if c == "\\" and i + 1 < n and text[i + 1] != "\n":
            line.append(text[i:i + 2])
            i += 2
            continue
        if text.startswith(mode, i):
            line.append(mode)
            i += len(mode)
            mode = None
            continue
        line.append(c)
        i += 1
    out.append("".join(line))
    return out


def _strip_markup(text):
    """HTML/XML/MSBuild source -> the same lines with <!-- ... --> comments removed."""
    def blank(m):
        return "\n" * m.group(0).count("\n")
    out = re.sub(r"<!--.*?(?:-->|\Z)", blank, text, flags=re.S)
    return out.split("\n")


def strip_comments_text(text, ext):
    """The lines of a whole file with comments removed (same line count as text.split('\\n'))."""
    if ext in (".cs", ".js", ".css"):
        return _strip_c_like(text, _lang_of(ext))
    if ext == ".py":
        return _strip_py(text)
    return _strip_markup(text)


def strip_comment(line, ext):
    """Single-line fallback (used when the whole file is not available): block-comment continuation lines (' * text') are recognised by their shape."""
    if ext in (".cs", ".js", ".css"):
        s = line.lstrip()
        if s == "*" or s.startswith(("* ", "*/", "*\t")):
            return ""
        return _strip_c_like(line, _lang_of(ext))[0]
    if ext == ".py":
        return _strip_py(line)[0]
    return _strip_markup(line)[0]


# ---- python: deny-by-default analysis of the syntax tree (alias aware: `import os as o; o.system(...)`, `from os import system`, `getattr(os, ...)`)
_PY_MSG = {"process-spawn": "spawning OS processes from python code", "file-delete": "deleting files from python code", "net-nonlocal": "network access from python code (only a visible 127.0.0.1/localhost target is allowed)",
           "dynamic-load": "dynamic code loading/execution in python code", "registry": "Windows registry access", "exit": "hard-terminating the python process",
           "abs-path": "absolute path literal (drive or UNC): derive paths from the agent dir / repo root", "engineer-api": "server code touching the engineer's action endpoints - needs human review"}
_PY_IMPORT_RULES = [
    (r"(?:subprocess|multiprocessing|_winapi|_posixsubprocess|pty|pexpect|win32\w*|pywin\w*|pythoncom)(?:\.|$)", "process-spawn"),
    (r"(?:ctypes|_ctypes|importlib|runpy|pickle|_pickle|marshal|code|codeop|imp|zipimport)(?:\.|$)", "dynamic-load"),
    (r"(?:winreg|_winreg)(?:\.|$)", "registry"),
    (r"(?:socket|_socket|ssl|ftplib|smtplib|poplib|imaplib|telnetlib|nntplib|xmlrpc\.client|http\.client|urllib\.request|requests|aiohttp|httpx|websockets?|paramiko|webbrowser)(?:\.|$)", "net-nonlocal"),
]
_PY_NAME_RULES = [
    (r"os\.(?:system|popen|startfile|fork\w*|kill|killpg|exec\w*|spawn\w*|posix_spawn\w*)$", "process-spawn"),
    (r"(?:subprocess|multiprocessing|_winapi|pty|pexpect)(?:\.|$)", "process-spawn"),
    (r"asyncio\.(?:create_subprocess_\w+|subprocess)(?:\.|$)", "process-spawn"),
    (r"os\.(?:remove|unlink|rmdir|removedirs|truncate)$", "file-delete"),
    (r"shutil\.rmtree$", "file-delete"),
    (r"os\.(?:_exit|abort)$", "exit"),
    (r"(?:eval|exec|compile|__import__|__builtins__|__loader__)(?:\.|$)", "dynamic-load"),
    (r"(?:importlib|runpy|pickle|marshal|ctypes|builtins)(?:\.|$)", "dynamic-load"),
    (r"sys\.modules(?:\.|$)", "dynamic-load"),
    (r"(?:os|shutil|sys|subprocess|socket|builtins)\.__dict__$", "dynamic-load"),
    (r"(?:socket|urllib\.request|http\.client|requests|ftplib|smtplib|telnetlib|poplib|imaplib|aiohttp|httpx|websockets?)\.\w+", "net-nonlocal"),
    (r"asyncio\.(?:open_connection|start_server|open_unix_connection|start_unix_server)$", "net-nonlocal"),
    (r"winreg\.\w+", "registry"),
]
_PY_ATTR_RULES = {"unlink": "file-delete", "rmdir": "file-delete", "subprocess_exec": "process-spawn", "subprocess_shell": "process-spawn", "__subclasses__": "dynamic-load",
                  "__globals__": "dynamic-load", "__builtins__": "dynamic-load", "__code__": "dynamic-load", "__import__": "dynamic-load"}
_PY_WATCHED = ("os", "shutil", "sys", "subprocess", "socket", "builtins", "importlib", "ctypes")
_PY_ENGINEER_URL = re.compile(r"/engineer/(?:deploy|apply|config|autorun|revert|requeue|reject|run)\b")


def _py_dotted(node, alias):
    parts = []
    while isinstance(node, ast.Attribute):
        parts.append(node.attr)
        node = node.value
    if isinstance(node, ast.Name):
        return ".".join([alias.get(node.id, node.id)] + parts[::-1])
    return None


def _py_rule(table, dotted):
    for rx, rid in table:
        if re.match(rx, dotted):
            return rid
    return None


def _unparse(node):
    try:
        return ast.unparse(node)
    except Exception:
        return "%s@%s" % (type(node).__name__, getattr(node, "lineno", "?"))


def _py_local_net(call):
    """A network call is acceptable when the arguments visibly name a local target (http://127.0.0.1..., 'localhost', '127.0.0.1')."""
    urls, hosts = [], []
    for c in ast.walk(call):
        if isinstance(c, ast.Constant) and isinstance(c.value, str):
            if re.match(r"https?://", c.value, re.I):
                urls.append(c.value)
            elif c.value.strip().lower() in ("127.0.0.1", "localhost", "::1"):
                hosts.append(c.value)
    if urls:
        return all(_LOCAL_URL.match(u) for u in urls)
    return bool(hosts)


def py_risks(text):
    """[(rule id, key, line number)] for everything in this python source that the safety scan cares about. Raises SyntaxError when it does not parse."""
    tree = ast.parse(text)
    alias = {}
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            for a in node.names:
                alias[a.asname or a.name.split(".")[0]] = a.name if a.asname else a.name.split(".")[0]
        elif isinstance(node, ast.ImportFrom) and node.module and not node.level:
            for a in node.names:
                if a.name != "*":
                    alias[a.asname or a.name] = node.module + "." + a.name
    for _ in range(2):                                                       # x = os / x = os.system: simple aliasing assignments
        for node in ast.walk(tree):
            if isinstance(node, ast.Assign) and len(node.targets) == 1 and isinstance(node.targets[0], ast.Name):
                d = _py_dotted(node.value, alias)
                if d:
                    alias[node.targets[0].id] = d
    bare = set()                                                             # docstrings and bare string statements: text, not data
    for node in ast.walk(tree):
        if isinstance(node, ast.Expr) and isinstance(node.value, ast.Constant) and isinstance(node.value.value, str):
            bare.add(id(node.value))
    risks, consumed = [], set()

    def eat(n):
        while isinstance(n, ast.Attribute):
            consumed.add(id(n))
            n = n.value
        consumed.add(id(n))

    for node in ast.walk(tree):
        if id(node) in consumed:
            continue
        line = getattr(node, "lineno", 0)
        if isinstance(node, ast.Import):
            for a in node.names:
                rid = _py_rule(_PY_IMPORT_RULES, a.name)
                if rid:
                    risks.append((rid, "import " + a.name, line))
        elif isinstance(node, ast.ImportFrom):
            mod = ("." * node.level) + (node.module or "")
            rid = _py_rule(_PY_IMPORT_RULES, node.module or "") if not node.level else None
            for a in node.names:
                if a.name == "*":
                    if rid or (node.module or "") in _PY_WATCHED:
                        risks.append((rid or "dynamic-load", "from %s import *" % mod, line))
                    continue
                full = (node.module or "") + "." + a.name
                r2 = rid or (None if node.level else _py_rule(_PY_NAME_RULES, full))
                if r2:
                    risks.append((r2, "from %s import %s" % (mod, a.name), line))
        elif isinstance(node, ast.Call):
            d = _py_dotted(node.func, alias)
            rid = _py_rule(_PY_NAME_RULES, d) if d else None
            if rid is None and isinstance(node.func, ast.Attribute):
                rid = _PY_ATTR_RULES.get(node.func.attr)
            if rid:
                eat(node.func)                                               # the callee is judged as part of the call (below), not once more on its own
                if rid == "net-nonlocal" and _py_local_net(node):
                    rid = None
            elif isinstance(node.func, ast.Name) and node.func.id == "getattr" and node.args:
                base = _py_dotted(node.args[0], alias)
                if base and base.split(".")[0] in _PY_WATCHED:
                    rid = "dynamic-load"
            if rid:
                risks.append((rid, _unparse(node), line))
        elif isinstance(node, (ast.Attribute, ast.Name)):
            d = _py_dotted(node, alias)
            rid = _py_rule(_PY_NAME_RULES, d) if d else None
            if rid is None and isinstance(node, ast.Attribute):
                rid = _PY_ATTR_RULES.get(node.attr)
            if rid:
                risks.append((rid, d or _unparse(node), line))
            eat(node)
        elif isinstance(node, ast.Constant) and isinstance(node.value, str) and id(node) not in bare:
            v = node.value
            if _ABS_PATH_VALUE.match(v):
                risks.append(("abs-path", v[:80], line))
            for u in _ANY_URL.findall(v):
                if not (_LOCAL_URL.match(u) or _NAMESPACE_URL.match(u)):
                    risks.append(("net-nonlocal", u[:100], line))
            if _PY_ENGINEER_URL.search(v):
                risks.append(("engineer-api", v[:80], line))
    return risks


_PY_WARN_RULES = {"engineer-api"}


def _scan_py_ast(path, base_text, new_text):
    """Fresh (net-new) python risks as scan records, or None when the new text does not parse (the caller falls back to the line rules)."""
    try:
        new = py_risks(new_text)
    except (SyntaxError, ValueError, RecursionError, MemoryError):
        return None
    base = {}
    if base_text:
        try:
            for rid, key, _ln in py_risks(base_text):
                base[(rid, key)] = base.get((rid, key), 0) + 1
        except (SyntaxError, ValueError, RecursionError, MemoryError):
            pass
    lines = new_text.split("\n")
    fresh = {}
    for rid, key, ln in new:
        if base.get((rid, key), 0) > 0:                                      # an identical construct already exists in the file: a move/re-indent is neutral
            base[(rid, key)] -= 1
            continue
        fresh.setdefault(rid, []).append("line %d: %s" % (ln, (lines[ln - 1].strip() if 0 < ln <= len(lines) else key)))
    return [{"rule": rid, "file": path, "message": _PY_MSG.get(rid, rid), "lines": [clip(x, 140) for x in found[:3]],
             "severity": "warning" if rid in _PY_WARN_RULES else "violation"} for rid, found in fresh.items()]


def _decode_text(b):
    if b is None:
        return None
    if b.startswith(codecs.BOM_UTF8):
        b = b[3:]
    return b.decode("utf-8", "surrogateescape")


def texts_for(paths, base_get, new_get):
    """{rel: (base_text|None, new_text|None)} for scan_diff: the whole before/after contents let the scan strip comments exactly and analyse python syntax trees."""
    return {p: (_decode_text(base_get(p)), _decode_text(new_get(p))) for p in paths}


def _code_lines(f, ext, base_text, new_text):
    """([(raw added line, comment-free code)], [comment-free removed lines]). Exact (multi-line comment aware) when the whole files are known and agree with the diff."""
    def pick(lines, nums, text):
        if text is None or nums is None or len(nums) != len(lines):
            return None
        stripped = strip_comments_text(text, ext)
        raw = text.split("\n")
        out = []
        for ln, n in zip(lines, nums):
            if not (0 < n <= len(stripped)) or raw[n - 1].rstrip("\r") != ln.rstrip("\r"):
                return None                                                  # the files do not match the diff: do not trust them
            out.append(stripped[n - 1].rstrip("\r"))
        return out
    a = pick(f["added"], f.get("added_at"), new_text)
    r = pick(f["removed"], f.get("removed_at"), base_text)
    add = [(l, a[i] if a is not None else strip_comment(l, ext)) for i, l in enumerate(f["added"])]
    rem = r if r is not None else [strip_comment(l, ext) for l in f["removed"]]
    return add, rem


def scan_diff(files, lint_text="", texts=None):
    """Static safety scan of a parsed diff. A matching added line is a finding unless the same file removes an identical line (modulo whitespace):
    moving or re-indenting an existing line is neutral, anything new or changed is not. `texts` (see texts_for) gives the whole before/after files: comments are then
    stripped exactly (multi-line, string aware) and python is analysed on its syntax tree. Returns {"violations": [...], "warnings": [...]}.
    This is a safety NET against accidents and naive prompt injection, not a sandbox: see docs/ENGINEER.md (limits)."""
    cheat = [re.compile(p) for p in (lint_cheat_patterns(lint_text) + CHEAT_BUILTIN)]
    viol, warn = [], []
    for f in files:
        path = f["path"]
        ext = os.path.splitext(path.lower())[1]
        if ext not in SCAN_EXTS:
            continue
        base_text, new_text = (texts or {}).get(path, (None, None))
        if ext == ".py" and new_text is not None:
            recs = _scan_py_ast(path, base_text, new_text)
            if recs is not None:
                for rec in recs:
                    (viol if rec.pop("severity") == "violation" else warn).append(rec)
                continue
        add, rem = _code_lines(f, ext, base_text, new_text)
        checks = [(r.id, r.msg, r.severity, r.hit) for r in RULES if ext in r.exts]
        if ext == ".cs":
            checks += [("cheat-api", "cheat/teleport/damage API (the bot must stay a legit player; tools/bot-lint.ps1 patterns)", "violation",
                        (lambda line, rx=rx: bool(rx.search(line)))) for rx in cheat]
        by_rule = {}
        for rid, msg, sev, fn in checks:
            # an added matching line is neutral only when an IDENTICAL line (modulo whitespace) is removed in the same file - a move or a re-indent.
            # Deleting some other matching line does not offset a new one, and a changed line (new arguments) counts as new.
            removed = {}
            for code in rem:
                if code.strip() and fn(code):
                    k = " ".join(code.split())
                    removed[k] = removed.get(k, 0) + 1
            fresh = []
            for raw, code in add:
                if code.strip() and fn(code):
                    k = " ".join(code.split())
                    if removed.get(k, 0) > 0:
                        removed[k] -= 1
                    else:
                        fresh.append(raw)
            by_rule.setdefault((rid, msg, sev), []).extend(fresh)
        for (rid, msg, sev), hits in by_rule.items():
            if hits:
                uniq = []
                for h in hits:
                    if h.strip() not in uniq:
                        uniq.append(h.strip())
                rec = {"rule": rid, "file": path, "message": msg, "lines": [clip(h, 140) for h in uniq[:3]]}
                (viol if sev == "violation" else warn).append(rec)
    for f in files:                                                         # a patch that makes the gate pass by weakening an existing test is not caught by the baseline comparison
        ext = os.path.splitext(f["path"].lower())[1]
        if f["path"].lower().startswith("tests/") and ext in (".py", ".cs") and not f["new"]:
            gone = [l for l in f["removed"] if strip_comment(l, ext).strip()]
            if gone:
                warn.append({"rule": "tests-weakened", "file": f["path"], "lines": [clip(l.strip(), 140) for l in gone[:3]],
                             "message": "existing test code was removed or changed (%d line(s)) - review that the test still checks what it did" % len(gone)})
    return {"violations": viol, "warnings": warn}


# ====================================================================================================== workspace (the model's sandbox)
class Workspace:
    """The `work` tree the model edits. Every path goes through safe_path(); edits keep line endings/BOM; limits are enforced per edit."""

    def __init__(self, root, base_root, cfg):
        self.root = Path(root)
        self.base = Path(base_root)
        self.cfg = cfg
        self.touched = {}               # rel -> "edit" | "create"

    # -- paths
    def safe_path(self, raw, write=False):
        rel = norm_rel(raw)
        if rel != ".":
            check_not_forbidden(rel)
        if write:
            check_writable(rel)
        parts = [] if rel == "." else rel.split("/")
        # canonical on-disk casing: Windows is case-insensitive, 'SRC/Picker.py' and 'src/picker.py' must be ONE file with ONE diff entry
        cur, canon = self.root, []
        for part in parts:
            try:
                match = next((n for n in os.listdir(cur) if n.lower() == part.lower()), None)
            except OSError:
                match = None
            canon.append(match if match is not None else part)
            cur = cur / canon[-1]
        parts = canon
        rel = "/".join(parts) if parts else "."
        cur = self.root
        for part in parts:
            cur = cur / part
            if not os.path.lexists(cur):
                break
            if is_reparse(cur):
                raise PolicyError("'%s' is a symlink/junction - not allowed" % rel)
        full = self.root.joinpath(*parts) if parts else self.root
        try:
            rr, rf = os.path.realpath(self.root), os.path.realpath(full)
            if os.path.commonpath([rr, rf]) != rr:
                raise PolicyError("path escapes the workspace")
        except ValueError:
            raise PolicyError("path escapes the workspace")
        return full, rel

    def base_bytes(self, rel):
        p = self.base / rel
        try:
            return read_bytes(p) if p.is_file() else None
        except OSError:
            return None

    def work_bytes(self, rel):
        p = self.root / rel
        try:
            return read_bytes(p) if p.is_file() else None
        except OSError:
            return None

    # -- read-only actions
    def ls(self, raw):
        p, rel = self.safe_path(raw or ".")
        if not p.exists():
            raise ActionError("no such path: %s" % rel)
        if p.is_file():
            raw_b = read_bytes(p)
            return "%s is a file: %d bytes, %d lines" % (rel, len(raw_b), count_lines(raw_b))
        rows, n = [], 0
        for e in sorted(os.scandir(p), key=lambda x: (not x.is_dir(follow_symlinks=False), x.name.lower())):
            if is_reparse(e.path):
                continue
            if e.is_dir(follow_symlinks=False):
                if skip_dir_name(e.name):
                    continue
                try:
                    cnt = sum(1 for c in os.scandir(e.path) if not (c.is_dir(follow_symlinks=False) and skip_dir_name(c.name)))
                except OSError:
                    cnt = 0
                rows.append("  %s/  (%d entries)" % (e.name, cnt))
            else:
                size = e.stat().st_size
                extra = ""
                if size <= self.cfg["max_edit_file_bytes"] and os.path.splitext(e.name.lower())[1] in TEXT_EXTS:
                    try:
                        extra = ", %d lines" % count_lines(read_bytes(e.path))
                    except OSError:
                        pass
                rows.append("  %s  (%s%s)" % (e.name, "%.1f KB" % (size / 1024.0) if size >= 1024 else "%d B" % size, extra))
            n += 1
            if n >= 150:
                rows.append("  ...(more entries not shown)")
                break
        return "%s/ - %d entries\n%s" % (rel if rel != "." else ".", n, "\n".join(rows))

    def read(self, raw, start=None, end=None, max_chars=6000):
        p, rel = self.safe_path(raw)
        if not p.is_file():
            raise ActionError("not a file: %s%s" % (rel, " (it is a directory - use ls)" if p.is_dir() else ""))
        tf = TextFile(read_bytes(p))
        lines = tf.text.split("\n")
        if lines and lines[-1] == "":
            lines.pop()
        total = len(lines)
        s = 1 if start is None else max(1, int(start))
        cap = self.cfg["read_max_lines"]
        e = min(total, s + cap - 1) if end is None else min(total, int(end), s + cap - 1)
        if s > total:
            raise ActionError("%s has only %d lines (start=%d)" % (rel, total, s))
        if e < s:
            raise ActionError("end (%d) is before start (%d) - give start <= end" % (e, s))
        tabs = sum(1 for l in lines[:400] if l.startswith("\t"))
        spaces = sum(1 for l in lines[:400] if l.startswith("  "))
        out, used = [], 0
        for i in range(s, e + 1):
            l = lines[i - 1]
            if len(l) > 400:
                l = l[:400] + "...[+%d chars]" % (len(lines[i - 1]) - 400)
            row = "%5d| %s" % (i, l)
            if used + len(row) + 1 > max_chars:
                out.append("...(output cut at line %d; continue with start=%d)" % (i - 1, i))
                e = i - 1
                break
            out.append(row)
            used += len(row) + 1
        head = "%s: lines %d-%d of %d (indent: %s%s)" % (rel, s, e, total, "tabs" if tabs > spaces else "spaces", ", CRLF" if tf.crs else "")
        if e < total and not out[-1].startswith("..."):
            head += " - more below, continue with start=%d" % (e + 1)
        return head + "\n" + "\n".join(out)

    def _text_files(self):
        for dp, dns, fns in os.walk(self.root):
            dns[:] = sorted(d for d in dns if not skip_dir_name(d) and not is_reparse(os.path.join(dp, d)))
            for fn in sorted(fns):
                full = os.path.join(dp, fn)
                if is_reparse(full) or os.path.splitext(fn.lower())[1] not in TEXT_EXTS:
                    continue
                yield full, os.path.relpath(full, self.root).replace("\\", "/")

    def grep(self, pattern, glob=None, maxn=None, ignore_case=False):
        if not isinstance(pattern, str) or not pattern:
            raise ActionError("'pattern' is empty")
        if len(pattern) > 240:
            raise ActionError("pattern too long (max 240 chars)")
        note = ""
        flags = re.I if ignore_case else 0
        if re.search(r"\([^()]*[+*][^()]*\)\s*[+*{]", pattern):
            raise ActionError("pattern has a nested quantifier (e.g. (a+)+) which can hang the search - simplify it")
        try:
            rx = re.compile(pattern, flags)
        except re.error as ex:
            rx = re.compile(re.escape(pattern), flags)
            note = "(pattern is not a valid regex (%s) - searched it as literal text)\n" % ex
        try:
            maxn = int(maxn) if maxn else self.cfg["grep_max"]
        except (TypeError, ValueError):
            maxn = self.cfg["grep_max"]
        maxn = max(1, min(maxn, self.cfg["grep_max"]))
        g = (glob or "").replace("\\", "/").lower() or None
        hits, total, nfiles = [], 0, 0
        for full, rel in self._text_files():
            low = rel.lower()
            if g and not (fnmatch.fnmatchcase(low, g) or fnmatch.fnmatchcase(os.path.basename(low), g)
                          or (g.startswith("**/") and fnmatch.fnmatchcase(low, g[3:]))):
                continue
            try:
                if os.path.getsize(full) > 2000000:
                    continue
                raw = read_bytes(full)
            except OSError:
                continue
            if b"\x00" in raw[:4096]:
                continue
            nfiles += 1
            for i, line in enumerate(raw.decode("utf-8", "replace").split("\n"), 1):
                if rx.search(line):
                    total += 1
                    if len(hits) < maxn:
                        hits.append("%s:%d: %s" % (rel, i, clip(line.strip().rstrip("\r"), self.cfg["grep_line_chars"]).replace("\n", " ")))
        if not hits:
            return note + "no matches for /%s/%s (searched %d files)" % (pattern, " in " + glob if glob else "", nfiles)
        more = "\n...(%d more hits not shown - narrow the pattern or glob)" % (total - len(hits)) if total > len(hits) else ""
        return note + "%d hit(s) for /%s/ (%d files searched)\n%s%s" % (total, pattern, nfiles, "\n".join(hits), more)

    # -- limits
    def _changed_for(self, rel, new_raw):
        return changed_lines(self.base_bytes(rel), new_raw)

    def _check_limits(self, rel, new_raw):
        files = set(self.touched) | {rel}
        total, nfiles = 0, 0
        for r in files:
            cur = new_raw if r == rel else self.work_bytes(r)
            n = self._changed_for(r, cur)
            if n:
                total += n
                nfiles += 1
        if nfiles > self.cfg["max_files"]:
            raise ActionError("edit refused: the patch would touch %d files (limit %d) - keep the change small and focused" % (nfiles, self.cfg["max_files"]))
        if total > self.cfg["max_changed_lines"]:
            raise ActionError("edit refused: the patch would change %d lines (limit %d; added+removed) - make a smaller change" % (total, self.cfg["max_changed_lines"]))
        return total, nfiles

    # -- writes
    def edit(self, raw_path, old, new):
        p, rel = self.safe_path(raw_path, write=True)
        if not p.is_file():
            raise ActionError("file not found: %s (use create for a new file)" % rel)
        if p.stat().st_size > self.cfg["max_edit_file_bytes"]:
            raise ActionError("%s is too large to edit (%d bytes)" % (rel, p.stat().st_size))
        tf = TextFile(read_bytes(p))
        new_raw, info = apply_edit(tf, old, new)
        total, nfiles = self._check_limits(rel, new_raw)
        atomic_write(p, new_raw)
        self.touched.setdefault(rel, "edit")
        info.update(path=rel, total_changed=total, files=nfiles)
        return info

    def _eol_for_new(self, p):
        sibs = [x for x in p.parent.glob("*" + p.suffix) if x.is_file()][:8] if p.parent.exists() else []
        crlf = lf = 0
        for s in sibs:
            try:
                d = read_bytes(s)[:20000]
            except OSError:
                continue
            c = d.count(b"\r\n")
            crlf += c
            lf += d.count(b"\n") - c
        return "\r\n" if crlf > lf else "\n"

    def create(self, raw_path, content):
        p, rel = self.safe_path(raw_path, write=True)
        if p.exists():
            raise ActionError("%s already exists - use edit to change it" % rel)
        sh = shadow_conflict(self.root, rel)
        if sh:
            raise PolicyError("'%s' would shadow the existing python module/package '%s' (imports would load the new file instead) - choose a different name" % (rel, sh))
        if not isinstance(content, str) or not content.strip():
            raise ActionError("'content' is empty")
        refuse_markers(content, "'content'")
        if len(content.encode("utf-8")) > self.cfg["max_create_bytes"]:
            raise ActionError("content too large (max %d bytes)" % self.cfg["max_create_bytes"])
        text = content.replace("\r\n", "\n")
        if not text.endswith("\n"):
            text += "\n"
        eol = self._eol_for_new(p)
        data = (text.replace("\n", eol) if eol != "\n" else text).encode("utf-8")
        total, nfiles = self._check_limits(rel, data)
        p.parent.mkdir(parents=True, exist_ok=True)
        atomic_write(p, data)
        self.touched[rel] = "create"
        return {"path": rel, "lines": text.count("\n"), "total_changed": total, "files": nfiles}

    # -- state
    def changed_files(self):
        """touched files whose content really differs from base (an edit that was reverted does not count)."""
        out = []
        for rel in sorted(self.touched):
            if self.work_bytes(rel) != self.base_bytes(rel):
                out.append(rel)
        return out

    def state_hash(self):
        h = hashlib.sha256()
        for rel in sorted(self.touched):
            b = self.work_bytes(rel)
            h.update(rel.encode() + b"\0" + (sha256_hex(b).encode() if b is not None else b"-") + b"\n")
        return h.hexdigest()


# ====================================================================================================== repo copy
COPY_ROOT_FILES = (".md", ".csproj", ".sln", ".props", ".targets")
COPY_ROOT_NAMES = {".gitignore", ".gitattributes", ".editorconfig", "global.json", "nuget.config", "directory.build.props", "directory.build.targets"}


def copy_repo(src, dst, cfg, log=None):
    """Copy src/ tests/ tools/ docs/ plus root md/csproj/sln files (no .git, bin, obj, decompiled*, dist, desktop, reference,
    node_modules, __pycache__, links, huge files) into dst. Returns stats."""
    src, dst = Path(src), Path(dst)
    stats = {"files": 0, "bytes": 0, "skipped_big": [], "errors": []}
    limit = cfg["max_copy_file_bytes"]

    def copy_file(s, d):
        for attempt in range(3):                                            # a file another process is writing right now is retried briefly
            try:
                if os.path.getsize(s) > limit:
                    stats["skipped_big"].append(os.path.relpath(s, src).replace("\\", "/"))
                    return
                os.makedirs(os.path.dirname(d), exist_ok=True)
                shutil.copy2(s, d)
                stats["files"] += 1
                stats["bytes"] += os.path.getsize(d)
                return
            except OSError as ex:
                if attempt == 2:
                    stats["errors"].append("%s: %s" % (os.path.relpath(s, src).replace("\\", "/"), ex))
                else:
                    time.sleep(0.2)

    def walk(sdir, ddir):
        try:
            entries = list(os.scandir(sdir))
        except OSError as ex:
            stats["errors"].append("%s: %s" % (sdir, ex))
            return
        for e in entries:
            if is_reparse(e.path):
                continue
            if e.is_dir(follow_symlinks=False):
                if skip_dir_name(e.name):
                    continue
                walk(e.path, os.path.join(ddir, e.name))
            elif e.is_file(follow_symlinks=False):
                copy_file(e.path, os.path.join(ddir, e.name))

    os.makedirs(dst, exist_ok=True)
    for e in os.scandir(src):
        if is_reparse(e.path):
            continue
        low = e.name.lower()
        if e.is_dir(follow_symlinks=False):
            if low in EDIT_ROOTS:
                walk(e.path, str(dst / e.name))
        elif e.is_file(follow_symlinks=False) and (os.path.splitext(low)[1] in COPY_ROOT_FILES or low in COPY_ROOT_NAMES):
            copy_file(e.path, str(dst / e.name))
    if stats["errors"] and log:
        log("copy_repo: %d file(s) could not be copied (first: %s)" % (len(stats["errors"]), stats["errors"][0]))
    return stats


def sweep_strays(base, work, touched, ignore_dirs=skip_dir_name):
    """Make work == base + the model's own edits: revert test-run side effects (stray new/changed/deleted files). Returns the list of fixes."""
    base, work = Path(base), Path(work)
    fixes = []
    seen = set()
    for dp, dns, fns in os.walk(work):
        dns[:] = [d for d in dns if not ignore_dirs(d) and not is_reparse(os.path.join(dp, d))]
        for fn in fns:
            full = os.path.join(dp, fn)
            rel = os.path.relpath(full, work).replace("\\", "/")
            seen.add(rel)
            if rel in touched or is_reparse(full):
                continue
            bp = base / rel
            try:
                if not bp.is_file():
                    os.remove(full)
                    fixes.append("removed stray new file " + rel)
                elif os.path.getsize(full) != os.path.getsize(bp) or read_bytes(full) != read_bytes(bp):
                    shutil.copy2(bp, full)
                    fixes.append("restored modified " + rel)
            except OSError:
                pass
    for dp, dns, fns in os.walk(base):
        dns[:] = [d for d in dns if not ignore_dirs(d) and not is_reparse(os.path.join(dp, d))]
        for fn in fns:
            rel = os.path.relpath(os.path.join(dp, fn), base).replace("\\", "/")
            if rel not in seen and rel not in touched and not (work / rel).exists():
                try:
                    os.makedirs(os.path.dirname(work / rel), exist_ok=True)
                    shutil.copy2(os.path.join(dp, fn), work / rel)
                    fixes.append("restored deleted " + rel)
                except OSError:
                    pass
    return fixes


# ====================================================================================================== process runner + production Runner
def kill_tree(p):
    try:
        if os.name == "nt":
            subprocess.run(["taskkill", "/PID", str(p.pid), "/T", "/F"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=20)
        else:
            p.kill()
    except Exception:
        try:
            p.kill()
        except Exception:
            pass


def run_cmd(args, cwd=None, timeout=300, env=None, tree=True):
    """Run a command, capture merged output. Returns (returncode, text, timed_out). On timeout the whole process tree is killed (tree=True) or only the
    started process (tree=False - used for the deploy script, whose children include the game it relaunched)."""
    kw = dict(cwd=str(cwd) if cwd else None, env=env, stdin=subprocess.DEVNULL, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if os.name == "nt":
        kw["creationflags"] = subprocess.CREATE_NO_WINDOW
    try:
        p = subprocess.Popen([str(a) for a in args], **kw)
    except OSError as ex:
        return 127, "cannot start %s: %s" % (args[0], ex), False
    try:
        out, _ = p.communicate(timeout=max(1, timeout))
        return p.returncode, out.decode("utf-8", "replace"), False
    except subprocess.TimeoutExpired:
        if tree:
            kill_tree(p)
        else:
            try:
                p.kill()
            except Exception:
                pass
        try:
            out, _ = p.communicate(timeout=15)
        except Exception:
            out = b""
        return -1, out.decode("utf-8", "replace"), True


_ERR_LINE = re.compile(r"^(?:(?P<loc>.*?)[:\s]\s*)?error\s+(?P<code>[A-Za-z]+\d+)\s*:\s*(?P<msg>.*?)(?:\s+\[[^\]]*\])?\s*$")


def parse_msbuild_errors(text, root=None, limit=30):
    """Compiler/MSBuild error lines, de-duplicated, with the workspace root stripped from paths."""
    out, seen = [], set()
    root_variants = []
    if root:
        r = str(root)
        root_variants = [r + os.sep, r.replace("\\", "/") + "/", r + "/", r.replace("/", "\\") + "\\"]
    for raw in text.splitlines():
        line = raw.strip()
        if "error" not in line:
            continue
        m = _ERR_LINE.match(line)
        if not m:
            continue
        loc = (m.group("loc") or "").strip().rstrip(":").strip()
        s = "%serror %s: %s" % (loc + ": " if loc else "", m.group("code"), m.group("msg"))
        for rv in root_variants:
            s = s.replace(rv, "")
        if s not in seen:
            seen.add(s)
            out.append(clip(s, 260))
        if len(out) >= limit:
            break
    return out


_PASS_RX = re.compile(r"^\[PASS\]")
_FAIL_RX = re.compile(r"^\[FAIL\]\s+(?P<name>.*?)(?:\s{2,}(?P<detail>.*))?$")
_REPLAY_RX = re.compile(r"^replay:\s+(?P<name>\S+)\s+-\s+(?P<detail>.*\bFAIL\b.*)$")
_LINT_RX = re.compile(r"^\[(?P<lvl>FAIL|WARN|PASS)\]\s+(?P<name>.*)$")


def parse_suite_output(suite, text, rc):
    """[PASS]/[FAIL] style output (unit tests, python tests, replay) -> {passed, failures{name:detail}}."""
    passed, fails = 0, {}
    for line in text.splitlines():
        line = line.rstrip()
        if _PASS_RX.match(line):
            passed += 1
            continue
        m = _FAIL_RX.match(line) or _REPLAY_RX.match(line)
        if m:
            fails["%s: %s" % (suite, m.group("name").strip())] = (m.groupdict().get("detail") or "")[:300]
    if rc != 0 and not fails:
        fails["%s: exit code %s" % (suite, rc)] = clip(text.strip().splitlines()[-1] if text.strip() else "", 300)
    return passed, fails


def parse_lint_output(text):
    fails, warns = [], []
    for line in text.splitlines():
        m = _LINT_RX.match(line.strip())
        if not m:
            continue
        if m.group("lvl") == "FAIL":
            fails.append(m.group("name").strip())
        elif m.group("lvl") == "WARN":
            warns.append(m.group("name").strip())
    return fails, warns


def _fwd(p):
    return str(p).replace("\\", "/")


class Runner:
    """Production runner: dotnet build (scratch artifacts, never Trainer\\bin), the unit-test projects, the python tests and tools/bot-lint.ps1.
    build/test return plain dicts (see Engineer docs); `run` is injectable so tests can check the command lines without running anything."""

    def __init__(self, game_dir, log=print, run=None, python=None, skip_py=(), skip_cs=(), py_tests=None, cs_projects=None):
        self.game_dir = str(game_dir)
        self.log = log
        self.run = run or run_cmd
        self.python = python or sys.executable or "python"
        self.skip_py = {str(x) for x in (skip_py or ())} | {"test_mm_engineer.py"}          # the engineer's own tests never run inside its own gate
        self.skip_cs = {str(x) for x in (skip_cs or ())}
        self.py_tests = None if py_tests is None else [str(x) for x in py_tests]          # None = every tests/test_*.py (tests with fakes); the Engineer passes its allowlist
        self.cs_projects = None if cs_projects is None else [str(x) for x in cs_projects]

    def _dotnet(self):
        return shutil.which("dotnet") or r"C:\Program Files\dotnet\dotnet.exe"

    def _env(self, extra=None):
        env = dict(os.environ)
        env.update({"DOTNET_CLI_TELEMETRY_OPTOUT": "1", "DOTNET_NOLOGO": "1", "DOTNET_SKIP_FIRST_TIME_EXPERIENCE": "1", "MSBUILDDISABLENODEREUSE": "1",
                    "PYTHONDONTWRITEBYTECODE": "1", "PYTHONIOENCODING": "utf-8", "PYTHONUTF8": "1"})
        env.update(extra or {})
        return env

    def build_command(self, root, art, out):
        csproj = Path(root) / "src" / "ThronefallTrainer.csproj"
        return [self._dotnet(), "build", str(csproj), "-c", "Release", "--artifacts-path", str(art), "-p:OutputPath=" + _fwd(out) + "/",
                "-p:GameDir=" + _fwd(self.game_dir), "-nologo", "-v:m", "-clp:NoSummary;ErrorsOnly", "-nodeReuse:false", "-p:UseSharedCompilation=false"]

    def build(self, root, out_dir=None, timeout=None):
        t0 = time.time()
        root = Path(root)
        if not (root / "src" / "ThronefallTrainer.csproj").exists():
            return {"ok": False, "errors": ["src/ThronefallTrainer.csproj not found in " + str(root)], "seconds": 0.0, "error": "no project"}
        scratch = Path(out_dir) if out_dir else Path(tempfile.mkdtemp(prefix="eng-build-"))
        scratch.mkdir(parents=True, exist_ok=True)
        cmd = self.build_command(root, scratch / "art", scratch / "out")
        rc, out, to = self.run(cmd, cwd=root, timeout=timeout or 420, env=self._env())
        errors = parse_msbuild_errors(out, root)
        ok = rc == 0 and not to
        res = {"ok": ok, "errors": errors, "seconds": round(time.time() - t0, 1), "error": "build timed out" if to else "",
               "dll": str(scratch / "out" / "ThronefallTrainer.dll") if ok else "", "log_tail": clip(out[-1500:], 1500)}
        if not ok and not errors:
            res["errors"] = [clip(out.strip().splitlines()[-1], 260) if out.strip() else "build failed (exit code %s)" % rc]
        if not out_dir:
            rmtree_force(scratch)
        return res

    def suites(self, root):
        root = Path(root)
        def allowed(name, patterns):
            return patterns is None or any(fnmatch.fnmatchcase(name.lower(), pat.lower()) for pat in patterns)
        cs = sorted(p for p in root.glob("tests/*/*.csproj") if p.parent.name not in self.skip_cs and allowed(p.parent.name, self.cs_projects))
        py = sorted(p for p in root.glob("tests/test_*.py") if p.name not in self.skip_py and allowed(p.name, self.py_tests))
        return cs, py

    def unrun_tests(self, root, changed):
        """Changed test files that this runner would NOT execute (not on the allowlists): a new or edited test that never runs verifies nothing."""
        root = Path(root)
        cs, py = self.suites(root)
        run_dirs, run_py = {p.parent.name for p in cs}, {p.name for p in py}
        out = []
        for rel in changed:
            m = re.fullmatch(r"tests/(test_[^/]+\.py)", rel)
            if m:
                if m.group(1) not in run_py:
                    out.append(rel)
                continue
            m = re.match(r"tests/([^/]+)/", rel)
            if m and m.group(1) not in run_dirs and any((root / "tests" / m.group(1)).glob("*.csproj")):
                out.append(rel)
        return out

    def _run_cs_suite(self, root, csproj, timeout):
        name = csproj.parent.name
        tmp = Path(tempfile.mkdtemp(prefix="eng-suite-"))
        try:
            cmd = [self._dotnet(), "build", str(csproj), "-c", "Release", "-o", str(tmp), "-p:GameDir=" + _fwd(self.game_dir), "-nologo", "-v:m",
                   "-clp:NoSummary;ErrorsOnly", "-nodeReuse:false", "-p:UseSharedCompilation=false"]
            rc, out, to = self.run(cmd, cwd=root, timeout=timeout, env=self._env())
            if rc != 0 or to:
                errs = parse_msbuild_errors(out, root, 6)
                return 0, {"%s: build-failed" % name: "; ".join(errs) or "build timed out"}, out
            rcs = list(tmp.glob("*.runtimeconfig.json"))
            if not rcs:
                return 0, {"%s: no runnable output" % name: "no *.runtimeconfig.json produced"}, out
            dll = Path(str(rcs[0])[:-len(".runtimeconfig.json")] + ".dll")
            rc, out, to = self.run([self._dotnet(), str(dll)], cwd=root, timeout=timeout, env=self._env())
            if to:
                return 0, {"%s: timeout" % name: "suite timed out"}, out
            passed, fails = parse_suite_output(name, out, rc)
            return passed, fails, out
        finally:
            rmtree_force(tmp)

    def _run_py_suite(self, root, path, timeout):
        name = "py/" + path.name
        agent_tmp = tempfile.mkdtemp(prefix="eng-agent-")
        try:
            rc, out, to = self.run([self.python, "-u", str(path)], cwd=root, timeout=timeout, env=self._env({"THRONEFALL_AGENT": agent_tmp}))
            if to:
                return 0, {"%s: timeout" % name: "suite timed out"}, out
            passed, fails = parse_suite_output(name, out, rc)
            return passed, fails, out
        finally:
            rmtree_force(agent_tmp)

    def _run_lint(self, root, timeout):
        script = Path(root) / "tools" / "bot-lint.ps1"
        if not script.exists():
            return {"skipped": True, "fails": [], "warns": [], "tail": ""}
        shell = shutil.which("pwsh") or shutil.which("powershell")
        if not shell:
            return {"skipped": True, "fails": [], "warns": [], "tail": "no PowerShell available"}
        rc, out, to = self.run([shell, "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", str(script)], cwd=root, timeout=min(timeout, 180), env=self._env())
        fails, warns = parse_lint_output(out)
        if (rc != 0 or to) and not fails:
            fails = ["lint-script-error (exit %s)" % (rc if not to else "timeout")]
        return {"skipped": False, "fails": fails, "warns": warns, "tail": clip(out[-800:], 800)}

    def test(self, root, timeout=None):
        t0 = time.time()
        root = Path(root)
        deadline = t0 + (timeout or 1200)
        cs, py = self.suites(root)
        res = {"ok": True, "passed": 0, "failed": 0, "failures": [], "details": {}, "suites": {}, "lint_fails": [], "lint_warns": [], "error": "", "log_tail": ""}
        jobs = [("cs", p) for p in cs] + [("py", p) for p in py]
        if not jobs:                                                        # nothing ran: that is NOT a pass (a mis-set allowlist would otherwise make every patch look verified)
            res["error"] = "no test suite ran: the python_tests / test_projects allowlists (cc-config.json, 'engineer') matched nothing under tests/"
        for kind, p in jobs:
            remaining = deadline - time.time()
            if remaining < 5:
                res["error"] = "test run exceeded its time budget before suite %s" % p.name
                break
            per = min(420, remaining)
            passed, fails, out = (self._run_cs_suite(root, p, per) if kind == "cs" else self._run_py_suite(root, p, per))
            nm = p.parent.name if kind == "cs" else "py/" + p.name
            res["suites"][nm] = {"passed": passed, "failed": len(fails), "failures": sorted(fails)}
            res["passed"] += passed
            for k, v in fails.items():
                res["failures"].append(k)
                res["details"][k] = v
        remaining = max(10, deadline - time.time())
        lint = self._run_lint(root, remaining)
        res["suites"]["lint"] = {"passed": 0, "failed": len(lint["fails"]), "failures": ["lint: " + f for f in lint["fails"]], "skipped": lint["skipped"]}
        res["lint_fails"] = ["lint: " + f for f in lint["fails"]]
        res["lint_warns"] = ["lint: " + f for f in lint["warns"]]
        for f in lint["fails"]:
            res["failures"].append("lint: " + f)
            res["details"]["lint: " + f] = "bot-lint.ps1 reports FAIL"
        res["failed"] = len(res["failures"])
        res["ok"] = not res["failures"] and not res["error"]
        res["seconds"] = round(time.time() - t0, 1)
        return res


# ====================================================================================================== grounding (the task's file/function names are guesses)
_STOP = {"the", "and", "for", "with", "not", "from", "that", "this", "when", "then", "into", "after", "before", "only", "must", "should", "also",
         "does", "have", "each", "every", "same", "than", "over", "more", "less", "without", "still", "again", "instead", "while", "which", "their",
         "hero", "bot", "code", "function", "file", "plan", "path", "site", "state", "time", "wave", "mode", "dispatch", "none", "true", "false",
         "cannot", "would", "could", "being", "there", "where", "these", "those", "about", "because", "between", "never", "always", "other", "since",
         "until", "within", "using", "added", "which", "while", "ships", "ship", "needs", "need", "make", "makes", "made", "just", "even", "both"}


_GROUND_SKIP_DIRS = {"_recover", "refpack"}                                  # recovered copies and research scripts only add noise to the symbol search


def _code_files(work, limit=2500000):
    """(relpath, text) of the code files the grounding searches: src/ first, then tools/ and tests/ - without the engineer's own tooling."""
    out, total = [], 0
    for sub in ("src", "tools", "tests"):
        for dp, dns, fns in os.walk(Path(work) / sub):
            dns[:] = [d for d in dns if not skip_dir_name(d) and d.lower() not in _GROUND_SKIP_DIRS and not is_reparse(os.path.join(dp, d))]
            for fn in fns:
                if os.path.splitext(fn.lower())[1] not in (".cs", ".py"):
                    continue
                full = os.path.join(dp, fn)
                if os.path.relpath(full, work).replace("\\", "/").lower() in PROTECTED_FILES:
                    continue
                try:
                    if os.path.getsize(full) > 800000 or total > limit:
                        continue
                    text = read_bytes(full).decode("utf-8", "replace")
                except OSError:
                    continue
                total += len(text)
                out.append((os.path.relpath(full, work).replace("\\", "/"), text.replace("\r\n", "\n")))
    return out


def ground_task(work, task):
    """Search the real code for the names MiniMax guessed. Returns a short text block for the first prompt."""
    work = Path(work)
    files = _code_files(work)
    names = {rel: t.count("\n") + (0 if t.endswith("\n") else 1) for rel, t in files}
    lines = []
    f = str(task.get("file") or "").strip().replace("\\", "/")
    if f:
        try:
            f = norm_rel(f)                                                 # the field is untrusted text: never stat an absolute/UNC/drive path (it could reach out to a remote host)
        except PolicyError:
            lines.append("file '%s' is not a valid repo-relative path (use paths like src/Bot.cs)" % clip1(f, 80))
            f = ""
    if f:
        if f in names or (work / f).is_file():
            lines.append("file '%s' exists (%s lines)" % (f, names.get(f, "?")))
        else:
            base = os.path.basename(f).lower()
            stem = os.path.splitext(base)[0]
            cands = [r for r in names if os.path.basename(r).lower() == base]
            cands += [r for r in names if stem and stem in os.path.basename(r).lower() and r not in cands]
            if not cands:
                cands = difflib.get_close_matches(f, list(names), n=3, cutoff=0.4)
            lines.append("file '%s' does NOT exist%s" % (f, ("; similar: " + ", ".join(cands[:4])) if cands else ""))
    blob = " ".join(str(task.get(k) or "") for k in ("title", "function", "fix", "evidence"))
    ident = []
    for tok in re.findall(r"[A-Za-z_][A-Za-z0-9_]{2,}", str(task.get("function") or "")):
        if tok.lower() not in _STOP and tok not in ident:
            ident.append(tok)
    for tok in re.findall(r"\b[A-Z][a-z0-9]+(?:[A-Z][a-z0-9]+)+\b|\b[a-z]+[A-Z][A-Za-z0-9]+\b|\b[a-z0-9]+(?:_[a-z0-9]+)+\b", blob):
        if tok.lower() not in _STOP and tok not in ident:
            ident.append(tok)
    variants = []
    for tok in ident[:16]:
        variants.append(tok)
        if "_" in tok:
            parts = [p for p in tok.split("_") if p]
            pas = "".join(p[:1].upper() + p[1:] for p in parts)
            variants.extend([pas, pas[:1].lower() + pas[1:]])
        elif re.search(r"[a-z][A-Z]", tok):
            variants.append(re.sub(r"(?<=[a-z0-9])(?=[A-Z])", "_", tok).lower())      # PickNext -> pick_next (python-style twin)
    seen_sym = set()
    sym_lines = []
    defrx_cache = {}
    for tok in variants:
        if tok in seen_sym or len(sym_lines) >= 9:
            continue
        seen_sym.add(tok)
        rx = re.compile(r"\b%s\b" % re.escape(tok))
        defrx = defrx_cache.setdefault(tok, re.compile(
            r"^\s*(?:(?:public|private|protected|internal|static|override|virtual|async|readonly|sealed|abstract|partial|unsafe)\s+)*[\w<>\[\],.?]+\s+%s\s*[\(=;{]|^\s*def\s+%s\s*\(|^\s*(?:class|struct|enum|interface)\s+%s\b" % ((re.escape(tok),) * 3)))
        uses, defs, where = 0, [], {}
        for rel, text in files:
            n = len(rx.findall(text))
            if not n:
                continue
            uses += n
            where[rel] = n
            for i, l in enumerate(text.split("\n"), 1):
                if len(defs) < 3 and defrx.search(l):
                    defs.append("%s:%d" % (rel, i))
        if uses:
            top = ", ".join("%s(%d)" % (r, c) for r, c in sorted(where.items(), key=lambda kv: -kv[1])[:3])
            sym_lines.append("symbol '%s': %s; %d uses in %s" % (tok, ("defined at " + ", ".join(defs)) if defs else "no definition line found", uses, top))
        elif tok in ident[:6]:
            sym_lines.append("symbol '%s': NOT FOUND in src/tools/tests (the name is a guess)" % tok)
    lines.extend(sym_lines)
    kws = []
    for w in re.findall(r"[A-Za-z][A-Za-z\-]{4,}", blob):
        lw = w.lower().strip("-")
        if lw not in _STOP and lw not in kws and not re.fullmatch(r"[0-9.\-]+", lw):
            kws.append(lw)
    heat = []
    for kw in kws[:30]:
        if len(heat) >= 6:
            break
        rx = re.compile(re.escape(kw), re.I)
        per = []
        for rel, text in files:
            if not rel.startswith("src/"):
                continue
            n = len(rx.findall(text))
            if n:
                per.append((n, rel))
        if per and sum(n for n, _ in per) <= 400:
            per.sort(reverse=True)
            heat.append("'%s': %s" % (kw, ", ".join("%s(%d)" % (r, n) for n, r in per[:3])))
    if heat:
        lines.append("keyword hits in src (where related code probably lives): " + "; ".join(heat))
    return "\n".join(" - " + l for l in lines) if lines else " - (nothing in the task could be matched to the code; use grep)"


# ====================================================================================================== prompts + protocol
SYSTEM_PROMPT = """You are a senior C# engineer on call for a LIVE Thronefall autopilot: a BepInEx/Unity plugin (net472, Unity Mono - no APIs newer than .NET Framework 4.7.2) that plays the game for the user. A watchdog found a defect and filed a task. You fix it by editing the code in an isolated workspace copy of the repo; your result is exported as a diff that is built, tested, linted and scanned, and only then applied to the live tree by a human (or by the opt-in auto mode).

PROTOCOL - every reply is EXACTLY ONE JSON object and nothing else (no prose, no markdown fences). The system runs the action and answers with an OBSERVATION. Actions:
{"action":"ls","path":"src"}
{"action":"read","path":"src/Bot.cs","start":2700,"end":2820}          numbered lines, at most @READ@ per call
{"action":"grep","pattern":"PickNext|SelectTarget","glob":"src/*.cs","max":40,"i":true}     regex over the workspace, max @GREP@ hits; "i":true = ignore case
{"action":"edit","path":"src/Bot.cs","old":"<exact existing text>","new":"<replacement>"}     'old' must occur EXACTLY ONCE in the file: copy it from a read observation (a fragment of a line is fine) and add neighbouring lines until it is unique; keep the indentation exactly: the read header says "indent: tabs|spaces" (src/Bot.cs uses TABs and CRLF, the other files use spaces) - write a tab as \\t
{"action":"create","path":"tests/ActLogic.Tests/Extra.cs","content":"<whole new file>"}      new file, only under src/ tests/ tools/ docs/; fails if the file exists
{"action":"build"}      compile the plugin in the workspace
{"action":"test"}       run the unit-test projects, the python tests and the lint
{"action":"finish","summary":"<what you changed and why>"}      only after build and test passed on your final edit
{"action":"finish","no_change":true,"summary":"<why>"}          when the defect is already fixed in the code or is not a code defect

RULES
1. The bot must stay a LEGIT player: no teleports, damage/heal/gold injection, free-build, god mode, cooldown bypass, game-speed changes or any other cheat API; never touch the Legit gating. The safety scan rejects such additions.
2. Make the SMALLEST change that fixes the CAUSE. Prefer fixing the cause (for example: target selection must verify reachability BEFORE committing the hero) over adding retries, timeouts or blacklists. Do not refactor, rename, reformat or "improve" unrelated code.
3. The file and function names in the task are GUESSES by an assistant that cannot see the code and are often wrong. Use grep/read to find the real code (the GROUNDING section lists what was found). Trust the code, not the task text. Pathfinding here is the A* Pathfinding Project (AstarPath), not Unity NavMesh.
4. When the logic you change is pure (no UnityEngine types), add or extend a unit test. tests/GatePlanner.Tests and tests/ActLogic.Tests are console programs that compile specific src files (see their .csproj); BotBrain.cs must stay free of Unity types. House rules enforced by lint: bot timers use Time.unscaledTime (never Time.time); tick log fields are at most 4 characters.
5. Never edit generated/decompiled code, bin/obj, decompiled*/, reference/, dist/, .git/, any script (.ps1 .bat .sh), the lint script, the deploy tooling or the engineer tooling: such edits are refused. tools/coach-server.py and tools/command_center.py may be edited but then need a server restart: do it only when the task is about them.
6. Always run build and then test before finish. At finish the system re-runs build, tests, lint, a size check (max @FILES@ files and @LINES@ changed lines, added+removed) and a safety scan. If a gate fails you get the failure text and keep working.
7. Budget: @STEPS@ steps in total. Observations are cut at about 6 KB, so read windows of at most @READ@ and prefer grep to locate code. The header of each OBSERVATION shows the steps left.
8. The strings in your JSON must be valid JSON (escape quotes, newlines as \\n, tabs as \\t). Output ONLY the JSON object."""

PROTOCOL_REMINDER = 'Reply with exactly ONE JSON object, for example {"action":"read","path":"src/Bot.cs","start":1,"end":80} - no prose, no code fences. Actions: ls, read, grep, edit, create, build, test, finish.'


def render_system(cfg):
    return (SYSTEM_PROMPT.replace("@READ@", "%d lines" % cfg["read_max_lines"]).replace("@GREP@", str(cfg["grep_max"])).replace("@FILES@", str(cfg["max_files"]))
            .replace("@LINES@", str(cfg["max_changed_lines"])).replace("@STEPS@", str(cfg["max_steps"])))


def _strip_think(text):
    return re.sub(r"<think>.*?</think>", "", text, flags=re.S | re.I)


_THINK_SPAN = re.compile(r"<think>.*?(?:</think>|\Z)", re.S | re.I)         # an UNCLOSED block (reply cut off by max_tokens) runs to the end: nothing in it is an action
_STR_OR_COMMA = re.compile(r'("(?:[^"\\]|\\.)*")|,(\s*[}\]])', re.S)


def _fix_trailing_commas(cand):
    """Remove a comma before } or ] - but never inside a string value (code in an edit may legitimately contain ',}')."""
    return _STR_OR_COMMA.sub(lambda m: m.group(1) if m.group(1) is not None else m.group(2), cand)


def extract_json(text):
    """The first balanced, parseable {...} object in text (string/escape aware, tolerant of control chars and trailing commas). Objects that START inside a
    <think>...</think> block are ignored; text inside a JSON string is never rewritten."""
    text = text[:120000]                                                    # a degenerate reply must not turn the scan quadratic
    spans = [(m.start(), m.end()) for m in _THINK_SPAN.finditer(text)]
    pos, tries = 0, 0
    while True:
        start = text.find("{", pos)
        if start < 0:
            return None
        inside = next((sp for sp in spans if sp[0] <= start < sp[1]), None)
        if inside:
            pos = inside[1]
            continue
        tries += 1
        if tries > 40:
            return None
        depth, in_str, esc, end = 0, False, False, -1
        for i in range(start, len(text)):
            c = text[i]
            if in_str:
                if esc:
                    esc = False
                elif c == "\\":
                    esc = True
                elif c == '"':
                    in_str = False
                continue
            if c == '"':
                in_str = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
                if depth == 0:
                    end = i
                    break
        if end < 0:
            return None
        cand = text[start:end + 1]
        for attempt in (cand, _fix_trailing_commas(cand)):
            try:
                obj = json.loads(attempt, strict=False)
                if isinstance(obj, dict):
                    return obj
            except (ValueError, RecursionError):                            # RecursionError: a reply like {[[[[...  (deep nesting) is just invalid
                pass
        pos = start + 1


_ALIASES = {"cat": "read", "open": "read", "view": "read", "search": "grep", "find": "grep", "list": "ls", "dir": "ls", "replace": "edit", "patch": "edit",
            "done": "finish", "submit": "finish", "complete": "finish", "run_tests": "test", "tests": "test", "compile": "build", "make": "build"}


def _intval(v, name):
    if v is None or v == "":
        return None
    if isinstance(v, bool):
        raise ProtocolError("'%s' must be a number" % name)
    try:
        return int(float(v))
    except (TypeError, ValueError, OverflowError):                          # 'inf' / 1e999 raise OverflowError, 'nan' ValueError: the model's mistake, not an engineer crash
        raise ProtocolError("'%s' must be a finite number" % name)


def parse_action(reply):
    """reply text -> (name, args). Raises ProtocolError with a message the model can act on."""
    obj = extract_json(reply or "")
    if obj is None:
        raise ProtocolError("no valid JSON object found in your reply")
    name = None
    for k in ("action", "tool", "type", "name", "command", "cmd"):
        if isinstance(obj.get(k), str) and obj[k].strip():
            name = obj[k].strip().lower()
            break
    if not name:
        raise ProtocolError('the JSON object has no "action" field')
    name = _ALIASES.get(name, name)
    args = dict(obj)
    for k in ("args", "arguments", "parameters", "params", "input"):
        if isinstance(obj.get(k), dict):
            args.update(obj[k])
    if name not in ("ls", "read", "grep", "edit", "create", "build", "test", "finish"):
        raise ProtocolError("unknown action '%s' (use ls, read, grep, edit, create, build, test, finish)" % name)
    if name == "ls":
        args["path"] = args.get("path") or args.get("dir") or "."
    elif name == "read":
        if not isinstance(args.get("path"), str):
            raise ProtocolError('read needs "path"')
        s, e = args.get("start", args.get("from")), args.get("end", args.get("to"))
        if args.get("line") is not None and s is None:
            s = args["line"]
        if isinstance(args.get("lines"), str) and re.match(r"^\s*\d+\s*[-:,]\s*\d+\s*$", args["lines"]):
            a, b = re.split(r"[-:,]", args["lines"])
            s, e = a, b
        args["start"], args["end"] = _intval(s, "start"), _intval(e, "end")
    elif name == "grep":
        if not isinstance(args.get("pattern"), str) or not args["pattern"]:
            raise ProtocolError('grep needs a non-empty "pattern"')
        args["max"] = _intval(args.get("max"), "max")
        args["i"] = bool(args.get("i") or args.get("ignore_case") or args.get("case_insensitive"))
        args["glob"] = args.get("glob") if isinstance(args.get("glob"), str) else None
    elif name == "edit":
        if not isinstance(args.get("path"), str):
            raise ProtocolError('edit needs "path"')
        for k in ("old", "new"):
            if k not in args or not isinstance(args[k], str):
                raise ProtocolError('edit needs string fields "old" and "new" ("new" may be "")')
    elif name == "create":
        if not isinstance(args.get("path"), str) or not isinstance(args.get("content"), str):
            raise ProtocolError('create needs "path" and "content"')
    elif name == "finish":
        args["summary"] = str(args.get("summary", ""))
        args["no_change"] = bool(args.get("no_change"))
    keep = {"ls": ("path",), "read": ("path", "start", "end"), "grep": ("pattern", "glob", "max", "i"), "edit": ("path", "old", "new"),
            "create": ("path", "content"), "build": (), "test": (), "finish": ("summary", "no_change")}[name]
    return name, {k: args[k] for k in keep if k in args}


def fmt_build(res, limit=2500):
    if res.get("ok"):
        return "BUILD OK (%.1f s)" % float(res.get("seconds") or 0)
    errs = res.get("errors") or [res.get("error") or "build failed"]
    return "BUILD FAILED (%.1f s), %d error(s):\n%s" % (float(res.get("seconds") or 0), len(errs), clip("\n".join(" " + e for e in errs[:25]), limit))


def fmt_test(res, base_failures=None, limit=3200):
    fails = res.get("failures") or []
    base = set(base_failures or [])
    new = [f for f in fails if f not in base]
    pre = [f for f in fails if f in base]
    head = "TESTS %s: %d passed, %d failed" % ("OK" if not fails and not res.get("error") else "FAILED", int(res.get("passed") or 0), len(fails))
    if res.get("error"):
        head += "; runner error: " + str(res["error"])[:200]
    parts = [head]
    suites = res.get("suites")
    if isinstance(suites, dict) and suites:                                 # say WHAT ran: a model (or a human) must not read "OK" as "everything was tested"
        parts.append("suites run: " + ", ".join(sorted(str(k) for k in suites)))
    det = res.get("details") or {}
    if new:
        parts.append("NEW failures (caused by your change):")
        parts += [" - %s%s" % (f, (": " + clip(str(det.get(f, "")), 260)) if det.get(f) else "") for f in new[:12]]
        if len(new) > 12:
            parts.append("   (+%d more)" % (len(new) - 12))
    if pre:
        parts.append("Pre-existing failures (they also fail without your change; not blamed on it, but check whether your fix should make them pass):")
        parts += [" - %s" % f for f in pre[:8]]
    if res.get("lint_warns"):
        parts.append("lint warnings: " + ", ".join(res["lint_warns"][:4]))
    return clip("\n".join(parts), limit)


# ====================================================================================================== the agent loop
class _ModelDown(Exception):
    pass


def compact_action(name, args):
    """Valid-JSON, size-bounded rendering of an executed action for the conversation history."""
    a = {"action": name}
    for k, v in args.items():
        if k == "action" or v is None or (v is False and k in ("i", "no_change")):
            continue
        if isinstance(v, str) and len(v) > 300:
            v = v[:300] + "...(+%d chars)" % (len(v) - 300)
        a[k] = v
    return json.dumps(a, ensure_ascii=False)


def norm_build(res):
    r = dict(res or {})
    r.setdefault("ok", False)
    r.setdefault("errors", [])
    r.setdefault("seconds", 0.0)
    r.setdefault("error", "")
    if not r["ok"] and not r["errors"]:
        r["errors"] = [r["error"] or "build failed"]
    return r


def norm_test(res):
    r = dict(res or {})
    r["failures"] = [str(x) for x in (r.get("failures") or [])]
    r.setdefault("passed", 0)
    r.setdefault("details", {})
    r.setdefault("error", "")
    r["lint_fails"] = [str(x) for x in (r.get("lint_fails") or [f for f in r["failures"] if f.startswith("lint:")])]
    r["failed"] = len(r["failures"])
    r["ok"] = not r["failures"] and not r["error"]
    return r


class _Loop:
    """One agent run: the model drives the workspace through the text-JSON protocol; limits, bounded memory and the finish gates live here."""

    def __init__(self, eng, task, base, work, cfg, progress_cb, tlog):
        self.eng, self.task, self.cfg = eng, task, cfg
        self.base, self.work = Path(base), Path(work)
        self.ws = Workspace(self.work, self.base, cfg)
        self.progress_cb, self.tlog = progress_cb, tlog
        self.t0 = eng.clock()
        self.steps = 0
        self.tokens = 0
        self.invalid = 0
        self.gate_fails = 0
        self.hist = []              # (step, one-liner) of exchanges that fell out of the conversation window
        self.recent = []            # [{"n","a","o","s"}] - the last keep_obs exchanges, in full
        self.edit_log = []
        self.last_build = None      # {"hash","res"}
        self.last_test = None
        self.base_test = None
        self.grounding = ""
        self.first_user = ""
        self.tests_run = 0

    # -- bookkeeping
    def _elapsed(self):
        return self.eng.clock() - self.t0

    def _time_left(self):
        return max(30.0, self.cfg["wall_timeout_s"] - self._elapsed())

    def _limit_hit(self):
        c = self.cfg
        if self.steps >= c["max_steps"]:
            return "step-limit", "used all %d steps without a finish that passed the gates" % c["max_steps"]
        if self.tokens >= c["max_tokens_total"]:
            return "token-limit", "token budget of %d exhausted (%d used)" % (c["max_tokens_total"], self.tokens)
        if self._elapsed() >= c["wall_timeout_s"]:
            return "wall-timeout", "wall-clock limit of %d s exceeded" % c["wall_timeout_s"]
        return None

    def _progress(self, phase, action):
        info = {"id": self.task["id"], "op": "run", "step": self.steps, "max_steps": self.cfg["max_steps"], "phase": phase, "action": action,
                "tokens": self.tokens, "elapsed_s": round(self._elapsed(), 1), "edits": len(self.ws.touched)}
        self.eng._set_current(info)
        self.eng._touch_lock()
        if self.progress_cb:
            try:
                self.progress_cb(dict(info))
            except Exception:
                pass

    def _obs(self, body):
        c = self.cfg
        el = int(self._elapsed())
        left = c["max_steps"] - self.steps
        head = "OBSERVATION [step %d/%d, %d left | tokens %dk/%dk | time %d:%02d/%d:%02d]" % (
            self.steps, c["max_steps"], left, self.tokens // 1000, c["max_tokens_total"] // 1000, el // 60, el % 60, c["wall_timeout_s"] // 60, c["wall_timeout_s"] % 60)
        if left <= 3:
            head += "\nWARNING: only %d step(s) left - run build/test and finish now." % max(0, left)
        return head + "\n" + clip(body, c["obs_chars"]) + "\n[Reply with exactly one JSON action object - no prose.]"      # the real model once answered in prose after two reads

    def _remember(self, a_text, obs, one):
        self.recent.append({"n": self.steps, "a": a_text, "o": obs, "s": one})
        while len(self.recent) > self.cfg["keep_obs"]:
            x = self.recent.pop(0)
            self.hist.append((x["n"], x["s"]))

    # -- prompts
    def _inventory(self):
        rows = []
        for sub in ("src", "tests"):
            try:
                rows.append(self.ws.ls(sub))
            except Exception:                                               # the inventory is a courtesy: never let it stop a run
                pass
        return clip("\n".join(rows), 2400)

    def _first_message(self):
        t, c = self.task, self.cfg
        parts = [                                                           # task fields come from the watchdog (text of unknown size): every one is clipped
            "TASK %s (priority %s)" % (t["id"], clip1(t.get("priority", "urgent"), 20)),
            "TITLE: %s" % clip1(t.get("title", ""), 300),
            "INCIDENTS: %s" % (clip1(", ".join(str(i) for i in (t.get("incidents") or [])), 300) or "-"),
            "EVIDENCE (numbers from the live incident): %s" % (clip(t.get("evidence") or "-", 2500)),
            "SUGGESTED FIX from the incident responder (a hint from an assistant that cannot see the code, not a spec): %s" % (clip(t.get("fix") or "-", 1800)),
            "FILE / FUNCTION GUESS: %s :: %s" % (clip1(t.get("file") or "?", 200), clip1(t.get("function") or "?", 200)),
            "", "GROUNDING (automatic search of the real code for the names in the task):", self.grounding, "",
            "WORKSPACE (paths relative to the repo root; use ls for more):", self._inventory(),
        ]
        if c.get("project_notes"):
            parts += ["", "PROJECT NOTES: " + str(c["project_notes"])]
        parts += ["", "LIMITS: %d steps, %dk tokens, %d min, at most %d files / %d changed lines." % (
            c["max_steps"], c["max_tokens_total"] // 1000, c["wall_timeout_s"] // 60, c["max_files"], c["max_changed_lines"])]
        return "\n".join(parts)

    def _state_line(self):
        h = self.ws.state_hash()

        def st(x):
            if x is None:
                return "not run"
            return ("ok" if x["res"].get("ok") else "FAILED") if x["hash"] == h else "stale (edits since)"
        tl = self.last_test
        tst = "not run"
        if tl is not None:
            tst = ("passed" if tl["hash"] == h and tl["res"]["ok"] else "had failures" if tl["hash"] == h else "stale (edits since)")
        return "STATE: %d file(s) edited | build: %s | tests: %s | gate attempts failed: %d" % (len(self.ws.touched), st(self.last_build), tst, self.gate_fails)

    def _messages(self):
        prog = ""
        if self.hist:
            prog += "\n\nEARLIER STEPS (summaries - run read/grep again if you need the text):\n" + "\n".join(" %d. %s" % (n, s) for n, s in self.hist)
        if self.edit_log:
            prog += "\n\nYOUR EDITS SO FAR (already applied in the workspace):\n" + "\n".join(" - " + e for e in self.edit_log[-20:])
        prog += "\n\n" + self._state_line()
        if not self.recent:
            prog += "\n\nReply with your first action as ONE JSON object."
        msgs = [{"role": "system", "content": render_system(self.cfg)}, {"role": "user", "content": self.first_user + prog}]
        for x in self.recent:
            msgs.append({"role": "assistant", "content": x["a"]})
            msgs.append({"role": "user", "content": x["o"]})
        return msgs

    # -- model call
    def _call_model(self, msgs):
        last = None
        for attempt in range(1 + self.cfg["model_retries"]):
            try:
                reply, usage = self.eng.mm_chat(msgs, max_tokens=self.cfg["model_max_tokens"])
                if not isinstance(reply, str):
                    reply = "" if reply is None else str(reply)
                if not reply.strip():
                    raise RuntimeError("empty reply")
                return reply, (usage if isinstance(usage, dict) else {})
            except Exception as ex:                                        # network/timeouts: retry with a short pause
                last = ex
                self.tlog({"n": self.steps + 1, "action": "model-error", "attempt": attempt + 1, "error": clip(str(ex), 200)})
                if self._limit_hit():
                    break
                self.eng.sleep(min(10, 2 * (attempt + 1)))
        raise _ModelDown("%s: %s" % (type(last).__name__, clip(str(last), 200)))

    # -- main loop
    def run(self):
        try:
            self.grounding = ground_task(self.work, self.task)
        except Exception as ex:                                             # grounding is a hint, not a requirement
            self.eng._log("grounding failed: %s: %s" % (type(ex).__name__, ex))
            self.grounding = " - (automatic grounding failed; use grep/read)"
        self.first_user = self._first_message()
        while True:
            lim = self._limit_hit()
            if lim:
                return self._ended(lim[0], lim[1])
            msgs = self._messages()
            self._progress("model", None)
            t_call = time.time()
            try:
                reply, usage = self._call_model(msgs)
            except _ModelDown as ex:
                return self._ended("model-error", str(ex))
            self.steps += 1
            self.tokens += tokens_of(usage, msgs, reply)
            try:
                name, args = parse_action(reply)
            except ProtocolError as ex:
                self.invalid += 1
                self.tlog({"n": self.steps, "action": "invalid", "error": str(ex), "reply": clip(reply, 700), "tokens": self.tokens})
                if self.invalid >= self.cfg["max_invalid"]:
                    return self._ended("protocol", "the model returned %d invalid replies in a row (last: %s)" % (self.invalid, ex))
                obs = self._obs("Your last reply was not accepted: %s.\n%s" % (ex, PROTOCOL_REMINDER))
                self._remember(clip(reply, 400), obs, "invalid reply (%s)" % ex)
                continue
            self.invalid = 0
            self._progress("action", name)
            try:
                done, obs, one = self._dispatch(name, args)
            except ActionError as ex:
                done, obs, one = None, "ERROR: %s" % ex, "%s refused: %s" % (name, clip1(str(ex), 100))
            except Exception as ex:                                         # an engineer-side bug must not kill an unattended run: report it as an error and log the traceback
                self.eng._log("action %s crashed: %s\n%s" % (name, ex, traceback.format_exc()))
                done, obs, one = None, "ERROR: internal error while running %s (%s: %s) - try a different approach" % (name, type(ex).__name__, clip(str(ex), 160)), \
                    "%s crashed (%s)" % (name, type(ex).__name__)
            if len(re.findall(r'"action"\s*:', _strip_think(reply))) > 1:
                obs += "\nNOTE: your reply contained several actions - only the FIRST was executed. Reply with ONE action per turn."
            self.tlog({"n": self.steps, "action": name, "args": json.loads(compact_action(name, args)), "result": clip(obs, 600), "tokens": self.tokens,
                       "model_s": round(time.time() - t_call, 1)})
            if done is not None:
                return done
            self._remember(compact_action(name, args), obs, one)

    def _ended(self, reason, message):
        """The run stopped without an accepted finish. Keep what the model had (as a failed diff) for inspection."""
        diff, stats = b"", None
        try:
            ch = self.ws.changed_files()
            if ch:
                diff = b"".join(make_file_diff(r, self.ws.base_bytes(r), self.ws.work_bytes(r)) for r in ch)
                stats = diff_stats(parse_diff(diff))
        except Exception:
            diff = b""
        return {"ok": False, "status": "failed", "reason": reason, "error": "%s: %s" % (reason, message), "steps": self.steps, "tokens": self.tokens,
                "diff": diff, "stats": stats, "gates": getattr(self, "last_gates", {}), "summary": ""}

    # -- actions
    def _dispatch(self, name, args):
        ws, c = self.ws, self.cfg
        if name == "ls":
            return None, self._obs(ws.ls(args.get("path"))), "ls %s" % args.get("path")
        if name == "read":
            out = ws.read(args["path"], args.get("start"), args.get("end"), max_chars=c["obs_chars"] - 400)
            return None, self._obs(out), "read %s" % out.split("\n", 1)[0][:90]
        if name == "grep":
            out = ws.grep(args["pattern"], args.get("glob"), args.get("max"), args.get("i"))
            return None, self._obs(out), "grep /%s/ -> %s" % (clip1(args["pattern"], 40), out.split("\n", 1)[0][:60])
        if name == "edit":
            info = ws.edit(args["path"], args["old"], args["new"])
            self.edit_log.append("%s line %d: replaced %d line(s) with %d line(s)" % (info["path"], info["line"], info["removed"], info["added"]))
            ctx = ws.read(info["path"], max(1, info["line"] - 2), info["line"] + info["added"] + 2, max_chars=2000)
            body = "EDIT OK in %s at line %d. The patch is now %d changed line(s) in %d file(s). Result:\n%s" % (info["path"], info["line"], info["total_changed"], info["files"], ctx)
            return None, self._obs(body), "edit %s:%d (-%d/+%d lines)" % (info["path"], info["line"], info["removed"], info["added"])
        if name == "create":
            info = ws.create(args["path"], args["content"])
            self.edit_log.append("created %s (%d lines)" % (info["path"], info["lines"]))
            return None, self._obs("CREATE OK %s (%d lines). The patch is now %d changed line(s) in %d file(s)." % (info["path"], info["lines"], info["total_changed"], info["files"])), \
                "create %s (%d lines)" % (info["path"], info["lines"])
        if name == "build":
            return self._do_build()
        if name == "test":
            return self._do_test()
        return self._do_finish(args)

    def _run_build(self, root, tag):
        try:
            return norm_build(self.eng.runner.build(str(root), timeout=min(self.cfg["build_timeout_s"], self._time_left())))
        except Exception as ex:                                             # a crashing runner is feedback for the model, not the end of the run
            return norm_build({"ok": False, "errors": ["the build runner crashed: %s: %s" % (type(ex).__name__, clip(str(ex), 200))], "error": "runner crash"})

    def _preflight(self, what):
        """build/test EXECUTE workspace code (test programs, python tests, the tools they import): the safety scan must pass BEFORE anything runs,
        not only at finish. Raises ActionError (reported to the model) when the current edits contain a violation."""
        changed = self.ws.changed_files()
        if not changed:
            return
        try:
            parsed = parse_diff(b"".join(make_file_diff(r, self.ws.base_bytes(r), self.ws.work_bytes(r)) for r in changed))
            lint_text = (self.base / "tools" / "bot-lint.ps1").read_text(encoding="utf-8", errors="replace") if (self.base / "tools" / "bot-lint.ps1").exists() else ""
        except (DiffError, OSError):
            return
        viol = scan_diff(parsed, lint_text)["violations"]
        if viol:
            v = viol[0]
            raise ActionError("%s NOT run: the safety scan rejects your current edits (%s in %s: %s | e.g. %s). Nothing in the workspace is executed until that is fixed." %
                              (what, v["rule"], v["file"], v["message"], "; ".join(v["lines"][:2])))

    def _do_build(self):
        self._preflight("build")
        h = self.ws.state_hash()
        res = self._run_build(self.work, "work")
        self.last_build = {"hash": h, "res": res}
        return None, self._obs(fmt_build(res)), "build %s" % ("OK" if res["ok"] else "FAILED (%d errors: %s)" % (len(res["errors"]), clip1(res["errors"][0], 70)))

    def _base_failures(self):
        if self.base_test is None:
            self.eng._log("%s: running the base tests once to separate pre-existing failures" % self.task["id"])
            try:
                self.base_test = norm_test(self.eng.runner.test(str(self.base), timeout=min(self.cfg["test_timeout_s"], self._time_left())))
            except Exception as ex:                                         # unknown baseline: every failure counts as new (the safe direction)
                self.base_test = norm_test({"error": "base test run crashed: %s: %s" % (type(ex).__name__, clip(str(ex), 200))})
        return self.base_test

    def _run_test(self):
        try:
            return norm_test(self.eng.runner.test(str(self.work), timeout=min(self.cfg["test_timeout_s"], self._time_left())))
        except Exception as ex:
            return norm_test({"error": "the test runner crashed: %s: %s" % (type(ex).__name__, clip(str(ex), 200))})

    def _do_test(self):
        self._preflight("test")
        h = self.ws.state_hash()
        res = self._run_test()
        self.tests_run += 1
        self.last_test = {"hash": h, "res": res}
        base = self._base_failures() if (res["failures"] or res["error"]) else None
        base_f = base["failures"] if base else []
        new = [f for f in res["failures"] if f not in base_f]
        one = "test OK (%d passed)" % res["passed"] if res["ok"] else "test FAILED (%d new, %d pre-existing)" % (len(new), len(res["failures"]) - len(new))
        return None, self._obs(fmt_test(res, base_f)), one

    def _fail_gates(self, failed, feedback, g, diff=None):
        self.gate_fails += 1
        self.last_gates = g
        return {"ok": False, "failed": failed, "feedback": "\n".join(feedback), "gates": g, "diff": diff}

    def gates(self, args):
        """Everything that must hold before the diff may leave the workspace. Cheap static gates first, then build, then tests."""
        ws, c, eng = self.ws, self.cfg, self.eng
        g = {}
        fixes = sweep_strays(self.base, self.work, ws.touched)
        if fixes:
            g["hygiene"] = {"ok": True, "fixes": fixes[:20], "note": "test runs left stray changes; they were reverted so the diff only contains your edits"}
            self.last_build = self.last_test = None                         # a stray file may be the only reason an earlier build/test passed: the cached results are void
        changed = ws.changed_files()
        if not changed:
            if args.get("no_change"):
                return {"ok": True, "no_change": True, "gates": g, "diff": b"", "stats": {"files": [], "added": 0, "removed": 0}}
            return self._fail_gates(["no-changes"], ['NO CHANGES: your edits leave the workspace identical to the base. If no code change is needed finish with {"action":"finish","no_change":true,"summary":"..."}; otherwise make the fix first.'], g)
        diff = b"".join(make_file_diff(r, ws.base_bytes(r), ws.work_bytes(r)) for r in changed)
        try:
            parsed = parse_diff(diff)
        except DiffError as ex:
            return self._fail_gates(["diff"], ["the exported diff is malformed (%s) - this is an engineer-tool problem" % ex], g)
        stats = diff_stats(parsed)
        failed, fb = [], []
        for rel in changed:
            try:
                check_not_forbidden(rel)
                check_writable(rel)
            except PolicyError as ex:
                failed.append("policy")
                fb.append("POLICY: %s" % ex)
        n = stats["added"] + stats["removed"]
        g["limits"] = {"ok": len(changed) <= c["max_files"] and n <= c["max_changed_lines"], "files": len(changed), "changed_lines": n, "max_files": c["max_files"], "max_changed_lines": c["max_changed_lines"]}
        if not g["limits"]["ok"]:
            failed.append("limits")
            fb.append("SIZE: the diff touches %d files / %d changed lines (limits %d / %d) - revert the unnecessary edits." % (len(changed), n, c["max_files"], c["max_changed_lines"]))
        lint_text = ""
        try:
            lint_text = (self.base / "tools" / "bot-lint.ps1").read_text(encoding="utf-8", errors="replace")
        except OSError:
            pass
        sc = scan_diff(parsed, lint_text)
        g["safety"] = {"ok": not sc["violations"], "violations": sc["violations"], "warnings": sc["warnings"]}
        if sc["violations"]:
            failed.append("safety")
            for v in sc["violations"]:
                fb.append("SAFETY SCAN: %s in %s - %s | e.g. %s. If this line already existed, make your edit smaller so it is not part of the changed lines; otherwise remove it." %
                          (v["rule"], v["file"], v["message"], "; ".join(v["lines"][:2])))
        if failed:
            return self._fail_gates(failed, fb, g, diff)
        h = ws.state_hash()
        self._progress("gates:build", "finish")
        if self.last_build and self.last_build["hash"] == h:
            bres = self.last_build["res"]
        else:
            bres = self._run_build(self.work, "work")
            self.last_build = {"hash": h, "res": bres}
        g["build"] = {"ok": bres["ok"], "seconds": bres.get("seconds"), "errors": bres["errors"][:8]}
        if not bres["ok"]:
            return self._fail_gates(["build"], ["BUILD: " + fmt_build(bres)], g, diff)
        self._progress("gates:tests", "finish")
        if self.last_test and self.last_test["hash"] == h:
            tres = self.last_test["res"]
        else:
            tres = self._run_test()
            self.last_test = {"hash": h, "res": tres}
        base = self._base_failures() if (tres["failures"] or tres["error"]) else None
        base_f = base["failures"] if base else []
        new = [f for f in tres["failures"] if f not in base_f]
        new_lint = [f for f in new if f.startswith("lint:")]
        new_tests = [f for f in new if not f.startswith("lint:")]
        err = bool(tres["error"])                                           # the runner could not verify (crash, time budget): never a pass, even if the base had the same problem
        g["tests"] = {"ok": not new_tests and not err, "passed": tres["passed"], "failures": tres["failures"][:30], "new_failures": new_tests[:30],
                      "preexisting": [f for f in tres["failures"] if f in base_f][:30], "error": tres["error"]}
        g["lint"] = {"ok": not new_lint, "new_fails": new_lint, "base_fails": (base or {}).get("lint_fails", []), "warns": tres.get("lint_warns", [])}
        if new_tests or err:
            failed.append("tests")
            fb.append("TESTS: " + fmt_test(tres, base_f))
        if new_lint:
            failed.append("lint")
            fb.append("LINT regression(s): " + ", ".join(new_lint) + " (these checks pass without your change)")
        if failed:
            return self._fail_gates(failed, fb, g, diff)
        self.last_gates = g
        return {"ok": True, "gates": g, "diff": diff, "stats": stats, "failed": []}

    def _do_finish(self, args):
        report = self.gates(args)
        if report["ok"]:
            if report.get("no_change"):
                return {"ok": True, "status": "no-change", "steps": self.steps, "tokens": self.tokens, "gates": report["gates"], "diff": b"", "stats": report["stats"],
                        "summary": args.get("summary", "")}, self._obs("FINISH ACCEPTED (no code change)."), "finish (no change)"
            return {"ok": True, "status": "patched", "steps": self.steps, "tokens": self.tokens, "gates": report["gates"], "diff": report["diff"], "stats": report["stats"],
                    "summary": args.get("summary", "")}, self._obs("FINISH ACCEPTED: all gates passed."), "finish OK"
        body = "FINISH REFUSED - the gates failed (%s):\n%s\nFix this and call finish again." % (", ".join(report["failed"]), report["feedback"])
        return None, self._obs(body), "finish refused (%s)" % ",".join(report["failed"])


# ====================================================================================================== the Engineer
class Engineer:
    """Queue + sidecar bookkeeping and the run/apply/deploy/reject operations. Thread-safe; one operation at a time."""

    def __init__(self, repo_root, agent_dir, mm_chat, cfg=None, runner=None, deploy_fn=None, clock=time.time, log=print,
                 health_fn=None, restore_fn=None, sleep=time.sleep):
        self.root = Path(repo_root)
        self.agent = Path(agent_dir)
        self.mm_chat = mm_chat
        self._cfg_override = dict(cfg or {})
        self.clock = clock
        self._log_fn = log
        self.sleep = sleep
        self.edir = self.agent / "engineer"
        self.queue_path = self.agent / "engineer-queue.jsonl"
        self.status_path = self.agent / "engineer-status.json"
        self.state_path = self.edir / "state.json"
        self.cfg_path = self.agent / "cc-config.json"
        self.lock_path = self.edir / "engineer.lock"
        self._lock = threading.RLock()
        self._op_lock = threading.Lock()
        self.current = None
        self.thread = None
        _c = self.get_cfg()
        self.runner = runner or Runner(self.game_dir(), log=self._log, skip_py=_c["skip_python_tests"], skip_cs=_c["skip_test_projects"], py_tests=_c["python_tests"], cs_projects=_c["test_projects"])
        self.deploy_fn = deploy_fn or self._default_deploy
        self.health_fn = health_fn or self._default_health
        self.restore_fn = restore_fn or self._default_restore
        try:
            self.recover_interrupted()
        except Exception as ex:                                             # never let bookkeeping stop the server from starting
            self._log("recover_interrupted failed: %s" % ex)

    # ------------------------------------------------------------------ config + small helpers
    def _log(self, msg):
        try:
            self._log_fn("[engineer] " + str(msg))
        except Exception:
            pass

    def get_cfg(self):
        c = dict(DEFAULT_CFG)
        try:
            with open(self.cfg_path, encoding="utf-8") as f:
                d = json.load(f).get("engineer")
            if isinstance(d, dict):
                c.update({k: v for k, v in d.items() if k in DEFAULT_CFG})
        except (OSError, ValueError, AttributeError):
            pass
        c.update(self._cfg_override)
        if c.get("mode") not in MODES:
            c["mode"] = "off"
        raw_auto_deploy = c.get("auto_deploy")                              # restarting the game unattended needs the literal JSON true - "true"/"yes"/1 do not count
        for k, v in DEFAULT_CFG.items():
            if isinstance(v, bool):
                c[k] = c[k] is True or str(c[k]).strip().lower() in ("true", "1", "yes")
            elif isinstance(v, int) and not isinstance(v, bool):
                try:
                    c[k] = int(float(c[k]))
                except (TypeError, ValueError, OverflowError):              # 'inf', 1e999, 'nan', None, text: the default
                    c[k] = v
                lo, hi = CFG_RANGE.get(k, (0, 10 ** 9))
                c[k] = max(lo, min(hi, c[k]))
        for k in ("python_tests", "test_projects", "skip_python_tests", "skip_test_projects"):
            if not isinstance(c.get(k), list):
                c[k] = list(DEFAULT_CFG[k])
        c["auto_deploy"] = raw_auto_deploy is True
        return c

    def set_cfg(self, patch):
        """Persist engineer settings (mode, auto_deploy, limits) into cc-config.json (only the 'engineer' key is touched). Returns the effective config."""
        patch = {k: v for k, v in (patch or {}).items() if k in DEFAULT_CFG}
        if "mode" in patch and patch["mode"] not in MODES:
            raise ValueError("mode must be one of %s" % ", ".join(MODES))
        with self._lock:
            try:
                with open(self.cfg_path, encoding="utf-8") as f:
                    full = json.load(f)
                if not isinstance(full, dict):
                    full = {}
            except (OSError, ValueError):
                full = {}
            eng = full.get("engineer") if isinstance(full.get("engineer"), dict) else {}
            eng.update(patch)
            full["engineer"] = eng
            self.agent.mkdir(parents=True, exist_ok=True)
            atomic_write(self.cfg_path, json.dumps(full, default=str).encode("utf-8"))
        for k in patch:
            self._cfg_override.pop(k, None)
        return self.get_cfg()

    def game_dir(self):
        g = self.get_cfg().get("game_dir") if hasattr(self, "_cfg_override") else ""
        if g:
            return Path(g)
        cand = self.agent.parent.parent.parent
        return cand if (cand / "Thronefall_Data").exists() or (cand / "BepInEx").exists() else Path(r"K:\Downloads-IDM\Thronefall")

    def deployed_dll(self):
        d = self.get_cfg().get("deployed_dll")
        return Path(d) if d else self.agent.parent / "ThronefallTrainer.dll"

    def server_files(self):
        """Files whose edit needs a coach-server restart: the two entry points plus the tools/*.py modules they import."""
        out = set(SERVER_FILES_BASE)
        mods = set()
        for rel in SERVER_FILES_BASE:
            try:
                text = (self.root / rel).read_text(encoding="utf-8", errors="replace")
            except OSError:
                continue
            for m in re.finditer(r"^\s*(?:import|from)\s+([A-Za-z_]\w*)", text, re.M):
                mods.add(m.group(1))
        for m in mods:
            if (self.root / "tools" / (m + ".py")).is_file():
                out.add("tools/%s.py" % m)
        return out

    # ------------------------------------------------------------------ queue + sidecar
    def _read_queue(self):
        rows = {}
        order = []
        try:
            with open(self.queue_path, encoding="utf-8", errors="replace") as f:
                for line in f:
                    line = line.strip()
                    if not line:
                        continue
                    try:
                        r = json.loads(line)
                    except ValueError:
                        continue
                    if isinstance(r, dict) and re.fullmatch(r"[A-Za-z0-9_-]{1,40}", str(r.get("id", ""))):
                        if r["id"] not in rows:
                            order.append(r["id"])
                        rows[r["id"]] = r
        except OSError:
            pass
        return [rows[i] for i in order]

    def _load_status(self, strict=False):
        """The sidecar. A transient read failure raises when strict (read-modify-write paths must never overwrite the file with an empty view);
        a file that stays corrupt is moved aside and replaced by an empty one so the engineer can continue."""
        d, state = read_json_retry(self.status_path)
        if state == "ok":
            return d if isinstance(d, dict) else {}
        if state == "missing":
            return {}
        if state == "corrupt":
            try:
                os.replace(self.status_path, "%s.corrupt-%d" % (self.status_path, int(time.time())))
                self._log("engineer-status.json was corrupt - moved aside, starting with an empty sidecar")
            except OSError:
                pass
            return {}
        if strict:
            raise OSError("cannot read %s right now (locked by another process?)" % self.status_path)
        return {}

    def _update(self, task_id, event=None, **fields):
        with self._lock:
            d = self._load_status(strict=True)
            rec = d.setdefault(task_id, {})
            rec.update(fields)
            if event:
                h = rec.setdefault("history", [])
                h.append({"t": round(self.clock(), 1), "event": event})
                del h[:-30]
            self.agent.mkdir(parents=True, exist_ok=True)
            atomic_write(self.status_path, json.dumps(d, default=str, indent=1).encode("utf-8"))
            return rec

    def _merge(self, row, side):
        m = dict(row)
        m["queue_status"] = row.get("status")
        m.update(side or {})
        m["status"] = (side or {}).get("status") or row.get("status") or "queued"
        m["allowed"] = ALLOWED_ACTIONS.get(m["status"], [])
        return m

    def _task(self, task_id):
        side = self._load_status()
        for r in self._read_queue():
            if r["id"] == task_id:
                return self._merge(r, side.get(task_id))
        return None

    @staticmethod
    def _target_key(r):
        f, fn = str(r.get("file") or "").strip().lower(), str(r.get("function") or "").strip().lower()
        return (f, fn) if f and fn else None

    def queue(self, limit=None):
        """Merged list (queue rows + sidecar state), newest first. Rows that name the same file+function guess as an EARLIER row carry
        same_target_as=<that id> (the responder often files the same defect several times)."""
        side = self._load_status()
        rows = [self._merge(r, side.get(r["id"])) for r in self._read_queue()]
        first = {}
        for r in sorted(rows, key=lambda r: (float(r.get("t") or 0), r["id"])):
            k = self._target_key(r)
            if k is not None:
                if k in first:
                    r["same_target_as"] = first[k]
                else:
                    first[k] = r["id"]
        rows.sort(key=lambda r: (float(r.get("t") or 0), r["id"]), reverse=True)
        return rows[:limit] if limit else rows

    def next_task(self):
        """Oldest queued task by priority (urgent first). Skipped: tasks that used up their attempts, and tasks whose file+function guess matches a task that
        is currently being worked on / awaits approval / is applied (two patches for the same target would only conflict)."""
        cfg = self.get_cfg()
        q = self.queue()
        busy = {self._target_key(r) for r in q if r["status"] in ("working", "patched", "applying", "applied", "deploying")} - {None}
        cand = [r for r in q if r["status"] == "queued" and int(r.get("attempts") or 0) < int(cfg.get("max_attempts", 3)) and self._target_key(r) not in busy]
        cand.sort(key=lambda r: (PRIORITY_RANK.get(str(r.get("priority", "normal")).lower(), 2), float(r.get("t") or 0), r["id"]))
        return cand[0] if cand else None

    def _state(self, strict=False):
        d, state = read_json_retry(self.state_path)
        if state == "ok":
            return d if isinstance(d, dict) else {}
        if state in ("error", "corrupt") and strict:
            raise OSError("cannot read %s right now" % self.state_path)
        return {}

    def _state_set(self, **kw):
        with self._lock:
            d = self._state(strict=True)
            d.update(kw)
            self.edir.mkdir(parents=True, exist_ok=True)
            atomic_write(self.state_path, json.dumps(d).encode("utf-8"))

    # ------------------------------------------------------------------ operation lock (one run/apply/deploy at a time, also across processes)
    def _set_current(self, info):
        self.current = dict(info)

    def _lockfile(self):
        d, state = read_json_retry(self.lock_path, tries=4)
        if state == "ok" and isinstance(d, dict):
            return d
        if state == "error":
            return {"unreadable": True}                                     # exists but cannot be read right now: assume it is held
        return None

    def _foreign_lock_active(self):
        """Another LIVE process holds the lock (fresh heartbeat AND the pid still exists - a crashed server's lock does not block)."""
        d = self._lockfile()
        if d and d.get("unreadable"):
            return True
        return bool(d) and d.get("pid") != os.getpid() and time.time() - float(d.get("t") or 0) < 180 and pid_alive(d.get("pid"))

    def _touch_lock(self, op=None, task_id=None):
        """Refresh the lock's heartbeat (throttled to once per 5 s; the heartbeat thread also does it every 30 s while an operation runs)."""
        now = time.time()
        if not op and now - getattr(self, "_lock_touched", 0.0) < 5.0:
            return
        try:
            d = self._lockfile() or {}
            if d.get("unreadable"):
                d = {}                                                      # the marker means "could not read it just now" - it must never be written back into the file
            if op:
                d["op"] = op
            if task_id:
                d["id"] = task_id
            d["pid"] = os.getpid()
            d["t"] = now
            self.edir.mkdir(parents=True, exist_ok=True)
            atomic_write(self.lock_path, json.dumps(d).encode("utf-8"))
            self._lock_touched = now
        except OSError:
            pass

    def busy(self):
        return self._op_lock.locked() or self._foreign_lock_active()

    def _begin(self, op, task_id):
        if self._foreign_lock_active():
            return False
        if not self._op_lock.acquire(False):
            return False
        self.current = {"id": task_id, "op": op, "step": 0, "phase": "starting", "t": self.clock()}
        self._touch_lock(op, task_id)
        stop = self._hb_stop = threading.Event()

        def beat():                                                         # a long build/test must not let the lock look stale
            while not stop.wait(30):
                self._touch_lock()
        threading.Thread(target=beat, name="mm-engineer-heartbeat", daemon=True).start()
        return True

    def _end(self):
        self.current = None
        stop = getattr(self, "_hb_stop", None)
        if stop is not None:
            stop.set()
        try:
            os.remove(self.lock_path)
        except OSError:
            pass
        try:
            self._op_lock.release()
        except RuntimeError:
            pass

    def recover_interrupted(self):
        """A crash/restart mid-operation leaves transient statuses behind; resolve them honestly (nothing is retried automatically)."""
        if self._op_lock.locked() or self._foreign_lock_active():
            return
        side = self._load_status()
        for tid, rec in side.items():
            st = rec.get("status")
            if st == "working":
                self._update(tid, event="recovered", status="failed", finished=self.clock(), error="interrupted: the engineer process stopped during the run (restart or crash)")
            elif st == "applying":
                self._update(tid, event="recovered", status="apply-failed", error="interrupted during apply; if the tree contains the patch, run --revert/revert() to restore the backups")
            elif st == "deploying":
                self._update(tid, event="recovered", status="applied", error="interrupted during deploy - check the game and audit.json (the DLL backup is in the backups folder)")

    def _spawn(self, fn, *a, **kw):
        t = threading.Thread(target=fn, args=a, kwargs=kw, name="mm-engineer", daemon=True)
        self.thread = t
        t.start()
        return t

    # ------------------------------------------------------------------ run
    def run_task(self, task_id, progress_cb=None, force=False):
        """Synchronous (run it in a worker thread): workspace copy -> agent loop -> gates -> diff + sidecar. Returns a result dict."""
        task = self._task(task_id)
        if task is None:
            return {"ok": False, "status": "unknown", "error": "unknown task %s" % task_id}
        if task["status"] != "queued" and not force:
            return {"ok": False, "status": task["status"], "error": "task %s is %s, not queued (use requeue first)" % (task_id, task["status"])}
        if not self._begin("run", task_id):
            return {"ok": False, "status": task["status"], "error": "busy: another engineer operation is running"}
        try:
            return self._run_locked(task, progress_cb)
        except Exception as ex:
            self._log("run %s crashed: %s\n%s" % (task_id, ex, traceback.format_exc()))
            try:
                self._update(task_id, event="crashed", status="failed", finished=self.clock(), error="internal error: %s: %s" % (type(ex).__name__, clip(str(ex), 200)))
            except Exception as ex2:                                        # the sidecar itself is the problem: do not mask the result, recover_interrupted() fixes the status later
                self._log("run %s: could not record the crash: %s" % (task_id, ex2))
            return {"ok": False, "status": "failed", "error": "internal error: %s" % ex}
        finally:
            try:
                try:
                    self._state_set(last_run_end_t=self.clock())
                except Exception:
                    pass
            finally:
                self._end()                                                 # whatever happened above, the operation lock and the lock file must be released

    def _transcript(self, task_id):
        path = self.edir / ("%s.log.jsonl" % task_id)
        self.edir.mkdir(parents=True, exist_ok=True)
        if path.exists():
            try:
                os.replace(path, str(path) + ".prev")
            except OSError:
                pass
        clock = self.clock
        try:
            fh = open(path, "a", encoding="utf-8", buffering=1)             # line-buffered: the UI can tail it live
        except OSError:
            fh = None

        def tlog(rec):
            rec = dict(rec)
            rec["t"] = round(clock(), 1)
            try:
                if fh is not None:
                    fh.write(json.dumps(rec, default=str) + "\n")
            except (OSError, ValueError):
                pass

        def close():
            try:
                if fh is not None:
                    fh.close()
            except OSError:
                pass
        tlog.close = close
        return path, tlog

    def _run_locked(self, task, progress_cb):
        tid = task["id"]
        cfg = self.get_cfg()
        t0 = self.clock()
        attempts = int(task.get("attempts") or 0) + 1
        self._update(tid, event="run started", status="working", started=t0, finished=None, steps=0, tokens=0, error="", note="", summary="", gates={}, diff_path=None,
                     diff_sha256=None, diff_stats=None, touches_server=False, needs_plugin_deploy=False, safety_warnings=[], attempts=attempts, post_hashes=None, prev_dir=None)
        self._state_set(last_run_start_t=t0)
        wsdir = self.edir / "work" / tid
        rmtree_force(wsdir)
        base, work = wsdir / "base", wsdir / "work"
        cs = copy_repo(self.root, base, cfg, self._log)
        if cs["errors"]:                                                    # a half-copied tree would build wrongly and mislead the model: stop here
            msg = "workspace copy incomplete: %d file(s) could not be read (first: %s) - the live tree may be mid-write; requeue to retry" % (len(cs["errors"]), cs["errors"][0])
            self._update(tid, event="copy failed", status="failed", finished=self.clock(), error=msg)
            self._log("%s: %s" % (tid, msg))
            return {"ok": False, "status": "failed", "error": msg, "id": tid, "steps": 0, "tokens": 0}
        shutil.copytree(base, work)
        self._log("%s: workspace ready (%d files, %.1f MB)" % (tid, cs["files"], cs["bytes"] / 1e6))
        tpath, tlog = self._transcript(tid)
        loop = _Loop(self, task, base, work, cfg, progress_cb, tlog)
        try:
            res = loop.run()
        finally:
            tlog.close()
        fin = self.clock()
        common = dict(finished=fin, steps=res.get("steps", loop.steps), tokens=res.get("tokens", loop.tokens), wall_s=round(fin - t0, 1), workspace=str(wsdir), transcript=str(tpath),
                      summary=str(res.get("summary", ""))[:1500], gates=_jsonable(res.get("gates") or {}))
        status = res["status"]
        if status == "patched":
            diff = res["diff"]
            dpath = self.edir / ("%s.diff" % tid)
            atomic_write(dpath, diff)
            files = res["stats"]["files"]
            warns = (res.get("gates", {}).get("safety") or {}).get("warnings", [])
            self._update(tid, event="patched", status="patched", diff_path=str(dpath), diff_sha256=sha256_hex(diff), diff_stats=res["stats"],
                         touches_server=any(f in self.server_files() for f in files), needs_plugin_deploy=any(f.startswith("src/") for f in files), safety_warnings=warns, error="", **common)
            self._log("%s: PATCHED in %d steps, %d tokens: %s" % (tid, common["steps"], common["tokens"], ", ".join(files)))
        elif status == "no-change":
            self._update(tid, event="no change needed", status="no-change", error="", **common)
            self._log("%s: model says no code change is needed" % tid)
        else:
            extra = {}
            if res.get("diff"):
                fp = self.edir / ("%s.failed.diff" % tid)
                atomic_write(fp, res["diff"])
                extra = {"failed_diff_path": str(fp), "diff_stats": res.get("stats")}
            self._update(tid, event="failed: " + str(res.get("reason")), status="failed", error=res.get("error", ""), **dict(common, **extra))
            self._log("%s: FAILED - %s" % (tid, res.get("error")))
        self._cleanup_workspaces(cfg["keep_workspaces"], keep=tid)
        out = dict(res)
        out.pop("diff", None)
        out.update(id=tid, diff_path=str(self.edir / ("%s.diff" % tid)) if status == "patched" else None)
        return out

    def _cleanup_workspaces(self, keep_n, keep=None):
        wd = self.edir / "work"
        try:
            dirs = sorted((d for d in wd.iterdir() if d.is_dir()), key=lambda d: d.stat().st_mtime, reverse=True)
        except OSError:
            return
        for d in dirs[max(1, keep_n):]:
            if d.name != keep:
                rmtree_force(d)

    # ------------------------------------------------------------------ apply
    def _read_diff(self, t):
        p = Path(t.get("diff_path") or "")
        if not p.is_file():
            raise ActionError("diff file missing: %s" % p)
        data = read_bytes(p)
        if t.get("diff_sha256") and sha256_hex(data) != t["diff_sha256"]:
            raise ActionError("the diff file changed after the gates passed (sha256 mismatch) - refusing to apply it")
        return data

    def apply_patch(self, task_id):
        t = self._task(task_id)
        if t is None:
            return {"ok": False, "status": "unknown", "error": "unknown task %s" % task_id}
        if t["status"] != "patched":
            return {"ok": False, "status": t["status"], "error": "task %s is %s; only a patched task can be applied" % (task_id, t["status"])}
        if not self._begin("apply", task_id):
            return {"ok": False, "status": t["status"], "error": "busy: another engineer operation is running"}
        try:
            return self._apply_locked(t)
        except Exception as ex:
            self._log("apply %s crashed: %s\n%s" % (task_id, ex, traceback.format_exc()))
            try:
                self._update(task_id, event="apply crashed", status="apply-failed", error="internal error during apply: %s" % clip(str(ex), 200))
            except Exception:
                pass                                                        # recover_interrupted() resolves a leftover 'applying' later
            return {"ok": False, "status": "apply-failed", "error": "internal error: %s" % ex}
        finally:
            self._end()

    @staticmethod
    def _git_apply_cmd(git, diff_path, check):
        """git apply must be BYTE-EXACT: with core.autocrlf=true (this repo's system config) git would otherwise rewrite the line endings of
        every patched LF file to CRLF. The diff is generated from the raw bytes, so applying it byte-exactly is both correct and minimal."""
        return [git, "-c", "core.autocrlf=false", "-c", "core.safecrlf=false", "apply"] + (["--check"] if check else []) + ["--whitespace=nowarn", str(diff_path)]

    def _apply_locked(self, t):
        tid, cfg = t["id"], self.get_cfg()
        try:
            data = self._read_diff(t)
            parsed = parse_diff(data)
        except (ActionError, DiffError) as ex:
            self._update(tid, event="apply refused", status="failed", error="cannot apply: %s" % ex)
            return {"ok": False, "status": "failed", "error": str(ex)}
        for f in parsed:                                                    # defence in depth: the diff on disk is re-validated, not trusted
            try:
                rel = norm_rel(f["path"])
                check_not_forbidden(rel)
                check_writable(rel)
                if f["special"] or f["deleted"]:
                    raise PolicyError("renames/mode changes/deletions are not allowed")
            except PolicyError as ex:
                self._update(tid, event="apply refused", status="failed", error="diff re-validation failed: %s" % ex)
                return {"ok": False, "status": "failed", "error": "diff re-validation failed: %s" % ex}
        lint_text = ""
        try:
            lint_text = (self.root / "tools" / "bot-lint.ps1").read_text(encoding="utf-8", errors="replace")
        except OSError:
            pass
        sc = scan_diff(parsed, lint_text)
        if sc["violations"]:
            v = sc["violations"][0]
            self._update(tid, event="apply refused", status="failed", error="safety scan failed on re-validation: %s in %s" % (v["rule"], v["file"]))
            return {"ok": False, "status": "failed", "error": "safety scan failed on re-validation: %s" % v["rule"]}
        git = shutil.which("git")
        if not git:
            return {"ok": False, "status": "patched", "error": "git is not available on PATH"}
        dpath = str(Path(t["diff_path"]))
        self._update(tid, event="apply started", status="applying")
        rc, out, to = run_cmd(self._git_apply_cmd(git, dpath, check=True), cwd=self.root, timeout=60)
        if rc != 0:
            note = "conflict: the real tree changed since this patch was made (git apply --check failed): %s" % clip(out.strip(), 400)
            self._update(tid, event="conflict", status="queued", note=note, conflicts=int(t.get("conflicts") or 0) + 1)
            self._log("%s: %s" % (tid, note))
            return {"ok": False, "status": "conflict", "error": note, "files": [f["path"] for f in parsed]}
        prev = self.edir / ("%s.prev" % tid)
        rmtree_force(prev)
        prev.mkdir(parents=True, exist_ok=True)
        manifest = {}
        for f in parsed:
            rel = f["path"]
            cur = self.root / rel
            if cur.is_file():
                b = read_bytes(cur)
                (prev / rel).parent.mkdir(parents=True, exist_ok=True)
                atomic_write(prev / rel, b)
                manifest[rel] = {"existed": True, "sha": sha256_hex(b)}
            else:
                manifest[rel] = {"existed": False}
        manifest_doc = {"task": tid, "t": self.clock(), "files": manifest, "post": {}}
        atomic_write(prev / "_manifest.json", json.dumps(manifest_doc).encode("utf-8"))
        rc, out, to = run_cmd(self._git_apply_cmd(git, dpath, check=False), cwd=self.root, timeout=60)
        if rc != 0:                                                         # the check passed a moment ago, but git may still die half way (a locked file): undo what it did write
            now = {}
            for f in parsed:
                cur = self.root / f["path"]
                now[f["path"]] = sha256_hex(read_bytes(cur)) if cur.is_file() else None
            self._update(tid, event="apply failed", status="apply-failed", prev_dir=str(prev), post_hashes=now, error="git apply failed after a clean check: %s" % clip(out.strip(), 300))
            rr = self._restore_prev(tid)                                    # the current state counts as 'post-apply', so every touched file goes back to its backup
            self._update(tid, restore=rr)
            return {"ok": False, "status": "apply-failed", "error": "git apply failed: %s" % clip(out.strip(), 300), "restore": rr}
        post = {}
        for f in parsed:
            p = self.root / f["path"]
            post[f["path"]] = sha256_hex(read_bytes(p)) if p.is_file() else None
        manifest_doc["post"] = post                                         # the post-apply hashes live next to the backups too (the restore guard compares against them)
        atomic_write(prev / "_manifest.json", json.dumps(manifest_doc).encode("utf-8"))
        self._update(tid, post_hashes=post, prev_dir=str(prev))
        scratch = self.edir / "scratch" / ("%s-%d" % (tid, int(self.clock())))
        self._set_current({"id": tid, "op": "apply", "phase": "build gate on the real tree"})
        res = norm_build(self.runner.build(str(self.root), out_dir=str(scratch), timeout=cfg["build_timeout_s"]))
        if not res["ok"]:
            rr = self._restore_prev(tid)
            err = "the real tree did not build after applying the patch: %s" % clip("; ".join(res["errors"][:3]), 300)
            self._update(tid, event="apply build failed - restored", status="apply-failed", error=err, apply_errors=res["errors"][:10], restore=rr)
            self._log("%s: %s -> restored %s, skipped %s" % (tid, err, rr["restored"] + rr["removed"], [s["file"] for s in rr["skipped"]]))
            rmtree_force(scratch)
            return {"ok": False, "status": "apply-failed", "error": err, "restore": rr}
        rmtree_force(scratch)
        self._update(tid, event="applied", status="applied", applied_at=self.clock(), error="", note="", restore=None)
        self._log("%s: applied to the real tree (%s); build gate passed" % (tid, ", ".join(post)))
        return {"ok": True, "status": "applied", "files": list(post), "touches_server": bool(t.get("touches_server")), "needs_plugin_deploy": bool(t.get("needs_plugin_deploy"))}

    def _restore_prev(self, task_id):
        """Put the backed-up originals back - but only for files that still hash to what the patch produced (never clobber newer edits)."""
        t = self._task(task_id) or {}
        out = {"restored": [], "removed": [], "skipped": []}
        prev = Path(t.get("prev_dir") or "")
        try:
            doc = json.loads(read_bytes(prev / "_manifest.json").decode("utf-8"))
            manifest = doc["files"]
        except (OSError, ValueError, KeyError):
            out["skipped"].append({"file": "*", "reason": "no backup manifest at %s" % prev})
            return out
        post = t.get("post_hashes") or doc.get("post") or {}
        for rel, m in manifest.items():
            cur = self.root / rel
            cur_h = sha256_hex(read_bytes(cur)) if cur.is_file() else None
            if rel in post and cur_h != post[rel]:
                out["skipped"].append({"file": rel, "reason": "modified since the patch was applied - left as is"})
                continue
            if rel not in post and cur_h is not None and m.get("existed") and cur_h != m.get("sha"):
                out["skipped"].append({"file": rel, "reason": "no post-apply hash and the file differs from the backup - left as is"})
                continue
            if m.get("existed"):
                atomic_write(cur, read_bytes(prev / rel))
                out["restored"].append(rel)
            elif cur.is_file():
                os.remove(cur)
                out["removed"].append(rel)
        return out

    def revert(self, task_id):
        """Undo an applied (not yet deployed) patch from its backups; refuses files that changed since."""
        t = self._task(task_id)
        if t is None:
            return {"ok": False, "error": "unknown task %s" % task_id}
        if t["status"] not in ("applied", "apply-failed"):
            return {"ok": False, "status": t["status"], "error": "only an applied task can be reverted (status is %s)" % t["status"]}
        if not self._begin("revert", task_id):
            return {"ok": False, "error": "busy: another engineer operation is running"}
        try:
            rr = self._restore_prev(task_id)
            clean = not rr["skipped"]
            self._update(task_id, event="reverted", status="patched" if clean else t["status"], note="reverted from backups" + ("" if clean else " (some files were left as they changed since)"), restore=rr)
            return {"ok": clean, "status": "patched" if clean else t["status"], "restore": rr}
        finally:
            self._end()

    # ------------------------------------------------------------------ deploy
    def _deploy_guard(self, t, confirm, cfg):
        """The cheap refusals shared by deploy() and the API pre-check. Returns an error dict, or None when a deploy may start."""
        if t["status"] != "applied":
            return {"ok": False, "status": t["status"], "error": "task %s is %s; only an applied task can be deployed" % (t["id"], t["status"])}
        if confirm is not True:
            return {"ok": False, "status": "applied", "error": "confirmation required: deploying restarts the game - call deploy(task_id, confirm=True)"}
        if not t.get("needs_plugin_deploy", True):
            return {"ok": False, "status": "applied", "error": "this patch changes no src/ files, so there is nothing to deploy to the game (tools/ changes need a coach-server restart)"}
        try:
            last_deploy = float(self._state(strict=True).get("last_deploy_t") or 0)
        except OSError as ex:                                               # an unreadable cooldown record must never read as 'no deploy yet'
            return {"ok": False, "status": "applied", "error": "cannot read the deploy cooldown state (%s) - try again in a moment" % ex}
        wait = cfg["deploy_cooldown_s"] - (self.clock() - last_deploy)
        if wait > 0:
            return {"ok": False, "status": "applied", "error": "deploy cooldown: wait %d more seconds (a deploy restarts the game)" % int(wait + 0.999), "cooldown_remaining_s": int(wait + 0.999)}
        return None

    def deploy(self, task_id, confirm=False):
        """Guarded game deploy: status applied + confirm flag + cooldown + DLL backup + deploy script + health check + automatic rollback."""
        t = self._task(task_id)
        if t is None:
            return {"ok": False, "status": "unknown", "error": "unknown task %s" % task_id}
        cfg = self.get_cfg()
        refused = self._deploy_guard(t, confirm, cfg)
        if refused:
            return refused
        if not self._begin("deploy", task_id):
            return {"ok": False, "status": "applied", "error": "busy: another engineer operation is running"}
        try:
            return self._deploy_locked(t, cfg)
        except Exception as ex:
            self._log("deploy %s crashed: %s\n%s" % (task_id, ex, traceback.format_exc()))
            try:
                self._update(task_id, event="deploy crashed", status="applied", error="internal error during deploy: %s - check the game" % clip(str(ex), 200))
            except Exception:
                pass                                                        # recover_interrupted() resolves a leftover 'deploying' later
            return {"ok": False, "status": "applied", "error": "internal error: %s" % ex}
        finally:
            self._end()

    def _caps_pid(self):
        try:
            return json.loads((self.agent / "caps.json").read_text(encoding="utf-8")).get("pid")
        except (OSError, ValueError, AttributeError):
            return None

    def _deploy_locked(self, t, cfg):
        tid = t["id"]
        dll = self.deployed_dll()
        backup, bsha = None, None
        if dll.is_file():
            backup = self.edir / "backups" / ("ThronefallTrainer.%s.dll" % time.strftime("%Y%m%d-%H%M%S", time.localtime(self.clock())))
            backup.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(dll, backup)
            bsha = sha256_hex(read_bytes(backup))
            if bsha != sha256_hex(read_bytes(dll)):
                return {"ok": False, "status": "applied", "error": "could not back up the deployed DLL (hash mismatch) - not deploying"}
        elif cfg["require_backup"]:
            return {"ok": False, "status": "applied", "error": "no deployed DLL found at %s to back up - refusing to deploy without a rollback path" % dll}
        pid_before = self._caps_pid()
        started = self.clock()
        self._state_set(last_deploy_t=started)
        self._update(tid, event="deploy started", status="deploying", backup_dll=str(backup) if backup else None)
        ok, derr, game_down = True, "", False
        try:
            dres = self.deploy_fn()
            if isinstance(dres, dict):
                ok = bool(dres.get("ok", True))
                derr = str(dres.get("error") or dres.get("output") or "")[-300:] if not ok else ""
                game_down = bool(dres.get("game_down"))
            else:
                ok = bool(dres) or dres is None
        except Exception as ex:
            ok, derr = False, "%s: %s" % (type(ex).__name__, ex)
        after = sha256_hex(read_bytes(dll)) if dll.is_file() else None
        if not ok and backup is not None and after == bsha and not game_down:   # failed before the game was touched: nothing to roll back
            self._update(tid, event="deploy script failed (game untouched)", status="applied", error="deploy script failed: %s" % clip(derr, 250))
            return {"ok": False, "status": "applied", "error": "deploy script failed before replacing the DLL: %s" % clip(derr, 250)}
        detail = derr
        if ok:
            self._set_current({"id": tid, "op": "deploy", "phase": "health check"})
            try:
                hres = self.health_fn({"since_t": started, "pid_before": pid_before, "task": tid})
            except Exception as ex:
                hres = (False, "health check crashed: %s" % ex)
            if isinstance(hres, dict):
                ok, detail = bool(hres.get("ok")), str(hres.get("detail", ""))
            else:
                ok, detail = bool(hres[0]), str(hres[1] if len(hres) > 1 else "")
        if ok:
            self._update(tid, event="deployed", status="deployed", deployed_at=self.clock(), error="", health=detail, backup_dll=str(backup) if backup else None)
            self._log("%s: DEPLOYED (%s)" % (tid, detail))
            return {"ok": True, "status": "deployed", "health": detail, "backup": str(backup) if backup else None}
        # ---- rollback: the game is not healthy (or the deploy half-ran). DLL first, then the source patch.
        rr_dll = None
        if backup is not None:
            try:
                rr_dll = self.restore_fn(str(backup))
            except Exception as ex:
                rr_dll = {"ok": False, "detail": "restore crashed: %s" % ex}
        else:
            rr_dll = {"ok": False, "detail": "no backup DLL existed"}
        rr_src = self._restore_prev(tid)
        self._update(tid, event="rolled back", status="rolled-back", rolled_back_at=self.clock(), error="deploy rolled back: %s" % clip(detail, 250),
                     rollback={"dll": _jsonable(rr_dll), "source": rr_src}, backup_dll=str(backup) if backup else None)
        self._log("%s: ROLLED BACK (%s); dll=%s source restored=%s" % (tid, detail, rr_dll, rr_src["restored"] + rr_src["removed"]))
        return {"ok": False, "status": "rolled-back", "error": "health check failed: %s" % detail, "rollback": {"dll": _jsonable(rr_dll), "source": rr_src}}

    # production hooks -------------------------------------------------
    def _default_deploy(self):
        shell = shutil.which("pwsh") or shutil.which("powershell")
        script = self.root / "tools" / "build-and-deploy.ps1"
        if not shell or not script.is_file():
            return {"ok": False, "error": "PowerShell or tools/build-and-deploy.ps1 not found"}
        before = self._game_running()
        rc, out, to = run_cmd([shell, "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", str(script)], cwd=self.root, timeout=self.get_cfg()["deploy_timeout_s"], tree=False)
        ok = rc == 0 and not to
        # the script kills the game before it copies the DLL: a failure after that point leaves the game DOWN even though the DLL is unchanged
        game_down = (not ok) and before is True and self._game_running() is False
        return {"ok": ok, "rc": rc, "output": clip(out[-600:], 600), "error": "timed out" if to else "", "game_down": game_down}

    @staticmethod
    def _game_running():
        """True/False when tasklist can tell whether thronefall.exe runs, None when unknown (non-Windows, tasklist failed)."""
        if os.name != "nt":
            return None
        rc, out, _to = run_cmd(["tasklist", "/FI", "IMAGENAME eq thronefall.exe", "/NH"], timeout=20)
        if rc != 0:
            return None
        return "thronefall.exe" in out.lower()

    def _default_health(self, ctx):
        """The NEW plugin process must come up: audit.json fresh again (<health_fresh_s old, written after the deploy) and caps.json present
        (written by the new process: newer than the deploy start and, when known, with a different pid)."""
        cfg = self.get_cfg()
        deadline = time.time() + cfg["health_timeout_s"]
        audit, caps = self.agent / "audit.json", self.agent / "caps.json"
        since = float(ctx.get("since_t") or 0)
        last = "no audit.json yet"
        while True:
            now = time.time()
            try:
                am = audit.stat().st_mtime
                fresh = now - am < cfg["health_fresh_s"] and am >= since
                last = "audit.json %.0fs old%s" % (now - am, "" if am >= since else " (older than the deploy: still the previous process)")
            except OSError:
                fresh = False
            caps_ok = True
            if cfg["health_require_caps"]:
                try:
                    cm = caps.stat().st_mtime
                    newpid = self._caps_pid()
                    caps_ok = cm >= since and (ctx.get("pid_before") is None or newpid != ctx.get("pid_before"))
                    last += "; caps.json %s" % ("new" if caps_ok else "not rewritten by a new process")
                except OSError:
                    caps_ok = False
                    last += "; caps.json missing"
            if fresh and caps_ok:
                return True, last
            if now >= deadline:
                return False, "no healthy plugin within %ds: %s" % (cfg["health_timeout_s"], last)
            time.sleep(3)

    def _default_restore(self, backup_path):
        """Stop the game, put the backed-up DLL back (hash verified), relaunch - the mirror image of tools/build-and-deploy.ps1."""
        cfg = self.get_cfg()
        dll, game = self.deployed_dll(), self.game_dir()
        if os.name == "nt":
            run_cmd(["taskkill", "/F", "/IM", "thronefall.exe"], timeout=30)
            for _ in range(20):
                rc, out, _t = run_cmd(["tasklist", "/FI", "IMAGENAME eq thronefall.exe", "/NH"], timeout=15)
                if "thronefall.exe" not in out.lower():
                    break
                time.sleep(0.5)
        want = sha256_hex(read_bytes(backup_path))
        ok = False
        for _ in range(8):
            try:
                shutil.copy2(backup_path, dll)
                if sha256_hex(read_bytes(dll)) == want:
                    ok = True
                    break
            except OSError:
                time.sleep(0.8)
        launched = False
        exe = game / "thronefall.exe"
        if ok and cfg["relaunch_after_restore"] and exe.is_file():
            try:
                subprocess.Popen([str(exe)], cwd=str(game), stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                launched = True
            except OSError:
                pass
        return {"ok": ok, "detail": "restored %s (hash %s)%s" % (dll, "verified" if ok else "NOT verified", ", game relaunched" if launched else "")}

    # ------------------------------------------------------------------ reject / requeue
    def reject(self, task_id, reason=""):
        t = self._task(task_id)
        if t is None:
            return {"ok": False, "error": "unknown task %s" % task_id}
        if t["status"] in ("working", "applying", "deploying", "applied", "deployed"):
            return {"ok": False, "status": t["status"], "error": "a %s task cannot be rejected%s" % (t["status"], " - revert it first" if t["status"] == "applied" else "")}
        self._update(task_id, event="rejected", status="rejected", rejected_at=self.clock(), reject_reason=str(reason)[:300])
        return {"ok": True, "status": "rejected"}

    def requeue(self, task_id):
        t = self._task(task_id)
        if t is None:
            return {"ok": False, "error": "unknown task %s" % task_id}
        if t["status"] not in ("failed", "no-change", "rejected", "rolled-back", "apply-failed"):
            return {"ok": False, "status": t["status"], "error": "only failed/no-change/rejected/rolled-back/apply-failed tasks can be requeued (status is %s)" % t["status"]}
        self._update(task_id, event="requeued", status="queued", error="", note="requeued", attempts=0)
        return {"ok": True, "status": "queued"}

    # ------------------------------------------------------------------ views
    def diff_text(self, task_id, cap=200000):
        t = self._task(task_id)
        if t is None:
            return None
        for key in ("diff_path", "failed_diff_path"):
            p = Path(t.get(key) or "")
            if p.is_file():
                return read_bytes(p)[:cap].decode("utf-8", "replace")
        return None

    def log_tail(self, task_id, n=60):
        p = self.edir / ("%s.log.jsonl" % re.sub(r"[^A-Za-z0-9_-]", "", task_id))
        try:
            rows = [json.loads(l) for l in read_bytes(p).decode("utf-8", "replace").splitlines() if l.strip()]
        except (OSError, ValueError):
            return []
        return rows[-n:]

    def status(self):
        cfg = self.get_cfg()
        q = self.queue()
        counts = {}
        for r in q:
            counts[r["status"]] = counts.get(r["status"], 0) + 1
        counts["total"] = len(q)
        st = self._state()
        now = self.clock()
        fin = sorted((r for r in q if r.get("finished")), key=lambda r: -float(r.get("finished") or 0))[:8]
        nxt = self.next_task()
        keys = ("id", "title", "status", "finished", "steps", "tokens", "summary", "error", "note", "touches_server", "needs_plugin_deploy", "diff_stats", "applied_at", "deployed_at", "attempts")
        return {
            "t": round(now, 1), "mode": cfg["mode"], "auto_deploy": cfg["auto_deploy"], "counts": counts,
            "current": dict(self.current) if self.current else None, "busy": self.busy(),
            "next": {"id": nxt["id"], "title": nxt.get("title"), "priority": nxt.get("priority")} if nxt else None,
            "awaiting_approval": [r["id"] for r in q if r["status"] == "patched"], "awaiting_deploy": [r["id"] for r in q if r["status"] == "applied"],
            "last_results": [{k: r.get(k) for k in keys} for r in fin],
            "cooldown": {"deploy_remaining_s": max(0, int(cfg["deploy_cooldown_s"] - (now - float(st.get("last_deploy_t") or 0)))),
                         "next_run_in_s": max(0, int(cfg["min_gap_s"] - (now - float(st.get("last_run_start_t") or 0))))},
            "git": bool(shutil.which("git")), "config": cfg,
        }

    # ------------------------------------------------------------------ autorun (called by the command center scheduler every minute)
    def maybe_autorun(self, sync=False):
        """Decide and (asynchronously, unless sync=True) do the next unattended step. semi: only prepares patches; auto: also applies;
        deploy happens only when auto_deploy is true AND the auto-confirm guards pass. Returns a description of what was decided."""
        cfg = self.get_cfg()
        mode = cfg["mode"]
        if mode == "off":
            return {"action": "idle", "reason": "mode is off"}
        if self.busy():
            return {"action": "busy", "reason": "an engineer operation is running"}
        try:
            self.recover_interrupted()                                      # a 'working'/'applying'/'deploying' left behind by a crash must not block the queue forever
        except Exception as ex:
            self._log("recover_interrupted failed: %s" % ex)
        q = self.queue()
        if mode == "auto":
            for r in sorted(q, key=lambda r: float(r.get("t") or 0)):
                if r["status"] == "patched" and self._auto_apply_ok(r, cfg):
                    return self._launch(sync, self._pipeline_apply, r["id"], {"action": "apply", "task": r["id"]})
                if r["status"] == "applied" and cfg["auto_deploy"] and self._auto_deploy_ok(r, cfg)[0]:
                    return self._launch(sync, self._pipeline_deploy, r["id"], {"action": "deploy", "task": r["id"]})
        st = self._state()
        gap = cfg["min_gap_s"] - (self.clock() - float(st.get("last_run_start_t") or 0))
        if gap > 0:
            return {"action": "wait", "reason": "min_gap_s", "wait_s": int(gap + 0.999)}
        pending = sum(1 for r in q if r["status"] == "patched")
        if pending >= cfg["max_pending_patches"]:
            return {"action": "wait", "reason": "%d patches already wait for approval" % pending}
        t = self.next_task()
        if t is None:
            return {"action": "idle", "reason": "no queued task"}
        return self._launch(sync, self._pipeline_run, t["id"], {"action": "run", "task": t["id"]})

    def _launch(self, sync, fn, tid, desc):
        if sync:
            desc = dict(desc)
            desc["result"] = fn(tid)
            return desc
        self._spawn(fn, tid)
        return dict(desc, started=True)

    def _auto_apply_ok(self, r, cfg):
        if r.get("touches_server") or r.get("safety_warnings"):
            return False                                                    # server edits and reviewed-worthy findings always need a human
        s = r.get("diff_stats") or {}
        return (int(s.get("added", 0)) + int(s.get("removed", 0))) <= cfg["auto_apply_max_lines"]

    def _auto_deploy_ok(self, r, cfg):
        if not cfg["auto_deploy"]:
            return False, "auto_deploy is off"
        if r.get("touches_server") or r.get("safety_warnings"):
            return False, "needs a human (server files or reviewed-worthy findings)"
        s = r.get("diff_stats") or {}
        if len(s.get("files") or []) > cfg["auto_deploy_max_files"] or (int(s.get("added", 0)) + int(s.get("removed", 0))) > cfg["auto_deploy_max_lines"]:
            return False, "patch is larger than the auto-deploy limits"
        if not r.get("needs_plugin_deploy", True):
            return False, "nothing to deploy"
        return True, "ok"

    def _pipeline_run(self, tid):
        res = self.run_task(tid)
        if res.get("status") == "patched" and self.get_cfg()["mode"] == "auto":
            t = self._task(tid)
            if t and self._auto_apply_ok(t, self.get_cfg()):
                res["applied"] = self._pipeline_apply(tid)
        return res

    def _pipeline_apply(self, tid):
        res = self.apply_patch(tid)
        cfg = self.get_cfg()
        if res.get("ok"):
            t = self._task(tid)
            if t and cfg["auto_deploy"] and self._auto_deploy_ok(t, cfg)[0]:
                res["deployed"] = self.deploy(tid, confirm=True)
        return res

    def _pipeline_deploy(self, tid):
        return self.deploy(tid, confirm=True)

    # ------------------------------------------------------------------ JSON API for the command center's HTTP handler
    @staticmethod
    def _int_arg(args, key, default, lo=1, hi=500):
        try:
            return max(lo, min(hi, int(args.get(key, default))))
        except (TypeError, ValueError):
            return default

    _LOOPBACK_HOST = re.compile(r"(?:127\.0\.0\.1|localhost|\[::1\])(?::\d+)?", re.I)
    _LOOPBACK_ORIGIN = re.compile(r"https?://(?:127\.0\.0\.1|localhost|\[::1\])(?::\d+)?", re.I)

    @classmethod
    def request_guard(cls, headers, write):
        """Browser-attack guard for the HTTP API (pass the request headers). A web page the user has open could otherwise POST to 127.0.0.1 (CORS only hides the
        response) or rebind a hostname to it: the Host must be loopback, a present Origin must be loopback, and state-changing requests must be application/json
        (a content type a cross-site form/fetch cannot send without a CORS preflight, which the server never grants). Returns (code, obj) to refuse, or None."""
        if headers is None:
            return None                                                     # direct call (tests, CLI, in-process)
        h = {str(k).lower(): str(v) for k, v in dict(headers.items()).items()}
        if h.get("host") and not cls._LOOPBACK_HOST.fullmatch(h["host"].strip()):
            return 403, {"ok": False, "error": "refused: Host '%s' is not loopback (DNS rebinding guard)" % clip1(h["host"], 60)}
        if h.get("origin") and not cls._LOOPBACK_ORIGIN.fullmatch(h["origin"].strip()):
            return 403, {"ok": False, "error": "refused: cross-origin request from '%s'" % clip1(h["origin"], 60)}
        if write and h.get("content-type", "").split(";")[0].strip().lower() != "application/json":
            return 415, {"ok": False, "error": "refused: state-changing requests must be sent with Content-Type: application/json"}
        return None

    def api_get(self, path, headers=None):
        """(code, obj) for GET /engineer, /engineer/queue, /engineer/diff?id=, /engineer/log?id= ; None when the path is not ours."""
        base, _, q = path.partition("?")
        if base.startswith("/engineer"):
            refused = self.request_guard(headers, write=False)
            if refused:
                return refused
        args = {}
        for p in q.split("&"):
            if "=" in p:
                k, v = p.split("=", 1)
                args[k] = v
        if base == "/engineer":
            return 200, self.status()
        if base == "/engineer/queue":
            return 200, self.queue(self._int_arg(args, "n", 60))
        if base == "/engineer/diff":
            tid = re.sub(r"[^A-Za-z0-9_-]", "", args.get("id", ""))
            d = self.diff_text(tid)
            return (200, {"id": tid, "diff": d, "task": self._task(tid)}) if d is not None else (404, {"error": "no diff for %s" % tid})
        if base == "/engineer/log":
            tid = re.sub(r"[^A-Za-z0-9_-]", "", args.get("id", ""))
            return 200, {"id": tid, "log": self.log_tail(tid, self._int_arg(args, "n", 60, 1, 400))}
        return None

    def api_post(self, path, data, sync=False, headers=None):
        """(code, obj) for POST /engineer/{run,apply,deploy,reject,requeue,revert,config,autorun}; None when the path is not ours.
        run/apply/deploy start a worker thread and return 202 immediately (poll GET /engineer) unless sync=True; obvious refusals
        (wrong status, missing confirm, cooldown, busy) are answered synchronously with 409. Pass the request `headers` from the HTTP handler
        to enable the browser-attack guard (loopback Host/Origin, Content-Type: application/json) - see request_guard()."""
        if path.startswith("/engineer"):
            refused = self.request_guard(headers, write=True)
            if refused:
                return refused
        data = data if isinstance(data, dict) else {}
        tid = re.sub(r"[^A-Za-z0-9_-]", "", str(data.get("id", "")))
        if path == "/engineer/config":
            try:
                return 200, {"ok": True, "config": self.set_cfg({k: data[k] for k in ("mode", "auto_deploy", "min_gap_s", "deploy_cooldown_s", "max_steps") if k in data})}
            except ValueError as ex:
                return 400, {"ok": False, "error": str(ex)}
        if path == "/engineer/autorun":
            return 200, self.maybe_autorun(sync=sync)
        if path not in ("/engineer/run", "/engineer/apply", "/engineer/deploy", "/engineer/reject", "/engineer/requeue", "/engineer/revert"):
            return None
        t = self._task(tid) if tid else None
        if t is None:
            return 404, {"ok": False, "error": "unknown task id"}
        if path == "/engineer/reject":
            return 200, self.reject(tid, data.get("reason", ""))
        if path == "/engineer/requeue":
            return 200, self.requeue(tid)
        if path == "/engineer/revert":
            return 200, self.revert(tid)
        op = path.rsplit("/", 1)[1]
        need = {"run": "queued", "apply": "patched", "deploy": "applied"}[op]
        confirm = data.get("confirm") is True
        if t["status"] != need:
            return 409, {"ok": False, "status": t["status"], "error": "task %s is %s; %s needs a task in status %s" % (tid, t["status"], op, need)}
        if op == "deploy":
            refused = self._deploy_guard(t, confirm, self.get_cfg())
            if refused:
                return 409, refused
        if self.busy():
            return 409, {"ok": False, "error": "busy: another engineer operation is running"}
        fn = {"run": lambda: self.run_task(tid), "apply": lambda: self.apply_patch(tid), "deploy": lambda: self.deploy(tid, confirm=confirm)}[op]
        if sync:
            return 200, fn()
        self._spawn(fn)
        return 202, {"ok": True, "started": tid, "op": op}


def _jsonable(o):
    try:
        return json.loads(json.dumps(o, default=str))
    except (TypeError, ValueError):
        return str(o)


# ====================================================================================================== MiniMax chat factory (same call as coach-server.mm_chat)
def mm_key():
    if os.environ.get("MM_KEY_OVERRIDE"):
        return os.environ["MM_KEY_OVERRIDE"]
    for p in (r"K:\private\.env", r"K:\private\minimax-m3-ultra.env"):
        try:
            for ln in Path(p).read_text(errors="replace").splitlines():
                ln = ln.strip()
                if ln.startswith(("MINIMAX_API_KEY=", "minimax=")) and "=" in ln:
                    return ln.split("=", 1)[1].strip()
        except OSError:
            continue
    return os.environ.get("MINIMAX_API_KEY", "")


def make_minimax_chat(timeout=90, retries=1, url=None, model=None):
    """Returns chat(messages, max_tokens=8000) -> (content, usage). Reads the key lazily from the usual file; never logs or raises it."""
    import urllib.error
    import urllib.request
    url = url or os.environ.get("MM_URL", "https://api.minimax.io/v1/chat/completions")
    model = model or os.environ.get("MINIMAX_MODEL", "MiniMax-M3")

    def chat(messages, max_tokens=8000):
        key = mm_key()
        if not key:
            raise RuntimeError("MINIMAX_API_KEY missing")
        body = {"model": model, "stream": False, "max_tokens": max_tokens, "temperature": 0.3, "reasoning_split": True, "messages": messages}
        last = None
        for _ in range(retries + 1):
            try:
                req = urllib.request.Request(url, data=json.dumps(body).encode(), headers={"Authorization": "Bearer " + key, "Content-Type": "application/json"})
                with urllib.request.urlopen(req, timeout=timeout) as r:
                    out = json.loads(r.read())
                msg = out["choices"][0]["message"]
                content = msg.get("content") or ""
                if not content.strip():                                    # never fall back to reasoning_content (rejected thoughts)
                    raise RuntimeError("empty MiniMax reply: %s" % str(out)[:160])
                return content, out.get("usage", {})
            except urllib.error.HTTPError as ex:
                last = RuntimeError("MiniMax HTTP %s" % ex.code)
            except (KeyError, IndexError, TypeError) as ex:
                last = RuntimeError("MiniMax bad response (%s)" % type(ex).__name__)
            except Exception as ex:
                last = RuntimeError("MiniMax call failed: %s" % str(ex).replace(key, "***")[:160])
        raise last
    return chat


# ====================================================================================================== CLI
def main(argv=None):
    import argparse
    for stream in (sys.stdout, sys.stderr):                                 # titles/summaries are model text: never die on a console that cannot encode a character
        try:
            stream.reconfigure(errors="replace")
        except Exception:
            pass
    argv = list(sys.argv[1:] if argv is None else argv)
    if "--deploy" in argv:
        print("deploy is intentionally not available from the CLI: it restarts the game. Approve it in the Live View (POST /engineer/deploy with confirm=true).")
        return 2
    here = Path(__file__).resolve().parent
    ap = argparse.ArgumentParser(description="MiniMax engineer: prepare, inspect, apply or reject code patches (no deploy from here).")
    ap.add_argument("--agent", default=os.environ.get("THRONEFALL_AGENT", r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent"))
    ap.add_argument("--repo", default=str(here.parent))
    g = ap.add_mutually_exclusive_group(required=True)
    g.add_argument("--list", action="store_true", help="show the merged queue")
    g.add_argument("--status", action="store_true", help="summary for the UI")
    g.add_argument("--run", metavar="ID", help="run the agent on a queued task (calls MiniMax; takes minutes)")
    g.add_argument("--apply", metavar="ID", help="apply a patched task to the real tree (git apply + build gate, auto-restore on failure)")
    g.add_argument("--diff", metavar="ID", help="print the exported diff")
    g.add_argument("--reject", metavar="ID", help="reject a task (give the reason as the next argument)")
    g.add_argument("--requeue", metavar="ID", help="put a failed/rejected task back in the queue")
    g.add_argument("--revert", metavar="ID", help="undo an applied (not deployed) patch from its backups")
    ap.add_argument("reason", nargs="?", default="")
    a = ap.parse_args(argv)
    eng = Engineer(a.repo, a.agent, make_minimax_chat(), log=print)
    if a.list:
        for r in eng.queue():
            print("%-7s %-12s %-6s %s" % (r["id"], r["status"], r.get("priority", ""), clip1(r.get("title", ""), 90)))
        return 0
    if a.status:
        print(json.dumps(eng.status(), indent=1, default=str))
        return 0
    if a.diff:
        d = eng.diff_text(a.diff)
        if d is None:
            print("no diff for %s" % a.diff)
            return 1
        sys.stdout.write(d)
        return 0
    if a.run:
        res = eng.run_task(a.run, progress_cb=lambda i: print("  step %d/%d %s %s tokens=%d" % (i["step"], i["max_steps"], i["phase"], i.get("action") or "", i["tokens"])))
    elif a.apply:
        res = eng.apply_patch(a.apply)
    elif a.reject:
        res = eng.reject(a.reject, a.reason)
    elif a.requeue:
        res = eng.requeue(a.requeue)
    else:
        res = eng.revert(a.revert)
    print(json.dumps({k: v for k, v in res.items() if k != "diff"}, indent=1, default=str))
    return 0 if res.get("ok") else 1


if __name__ == "__main__":
    sys.exit(main())
