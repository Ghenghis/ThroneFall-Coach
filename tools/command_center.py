"""Command center brain for the Thronefall coach server.

Wires the incident engine (tools/incidents.py) to MiniMax and to the UI:

  * a 1 Hz watchdog thread polls the engine; incidents that reach warn/crit WAKE MiniMax immediately (event-driven, coalesced,
    rate-limited, budgeted) instead of waiting for the 30 s watch loop;
  * an always-on scheduler thread runs system jobs (pulse every 60 s, MiniMax review every 5 min, self-check, hourly report) with
    visible last/next-run times, and keeps a heartbeat file the external supervisor checks;
  * MiniMax answers with a structured plan; every action is validated, executed (or queued in semi mode) and logged with its
    outcome in mm-actions.jsonl and on the incident itself;
  * HTTP handlers for the Live View command center (/incidents /botpulse /mmactions /scheduler /incident/* /cc.js).

Everything the server owns (mm_chat, write_cmd, validate_patch, ...) is injected through `ctx`, so tests run with fakes.
"""
import json
import os
import re
import subprocess
import sys
import threading
import time
import traceback
import urllib.request
from collections import deque

import incidents as inc_mod

HERE = os.path.dirname(os.path.abspath(__file__))
GAMELOG = os.environ.get("THRONEFALL_GAMELOG", r"K:\Downloads-IDM\Thronefall\BepInEx\LogOutput.log")

DEFAULT_CFG = {
    "enabled": True,
    "wake": {"enabled": True, "min_gap_crit_s": 30, "min_gap_warn_s": 60, "max_per_10min": 5, "coalesce_s": 6},
    "jobs": {"pulse_s": 60, "review_s": 300, "report_s": 3600, "selfcheck_s": 30},
    "livecap": {"enabled": True, "port": 8097, "check_s": 10},
}

PLUGIN_ACTIONS = {"retreat", "avoid", "goto", "clear_ignores", "forgive"}          # how= values the plugin command 'act' understands
KNOB_KEYS = ("squad_size", "reserve_size", "escort_size", "army_target", "build_focus", "hero_posture", "night_call", "clear")

INCIDENT_SYS = """You are MiniMax Incident Responder, the on-call engineer for a Thronefall autopilot. A watchdog woke you because the bot
is stuck, idle or broken RIGHT NOW. Do not just describe: decide and act. Reply with ONLY one JSON object, no prose:
{"diagnosis":"<2 sentences: what is happening and why>",
 "cause":"immovable-boundary|player-structure|unreachable-target|target-loop|idle-gold|ui-wedge|feed-dead|code-error|unknown",
 "confidence":0.0,
 "actions":[ <up to 4 action objects> ]}
Action objects (type + fields):
 {"type":"unstick","how":"retreat|avoid|goto|clear_ignores|forgive","x":<world x>,"z":<world z>,"r":<metres>,"ttl_s":<seconds>,"why":"..."}
     movement correction the bot executes within ~1 s. retreat = walk back along the trail and drop the current target; avoid = ban a
     circle (x,z,r) from targeting for ttl_s; goto = walk to (x,z); clear_ignores / forgive = reset the bot's parked/ignored targets.
 {"type":"command","patch":{"build_focus":"...","hero_posture":"builder","army_target":N}}   strategy knobs - ONLY for idle/loop incidents;
     knobs cannot move a pinned hero and are dropped for stuck/hotspot/wedge/feed/code incidents. Never send "clear" (it wipes the user's overrides).
 {"type":"code_task","title":"...","file":"src/Bot.cs","function":"...","evidence":"<numbers from the incident>","fix":"<concrete change>"}
     a defect that retreat/avoid/knobs cannot cure. It goes to the engineer queue as URGENT - give file, function, threshold.
 {"type":"relaunch","why":"..."}   only when the session is wedged or dead (feed incident with the game running, wedge > 60 s)
 {"type":"ack","note":"..."}      you looked and nothing needs doing now
How to read an incident: obstacle.class tells WHAT the hero is pinned on. map boundary / terrain are IMMOVABLE: no gate or sidestep will
ever open them - the target behind them is unreachable, so avoid a circle of >= 12 m around the pin for 600 s and retreat. player wall /
player building / gate can be walked around or opened: retreat first, avoid for 120-300 s if it repeats. A HOTSPOT (the same spot pinned
again and again) means the first remedy did not hold: escalate (bigger avoid radius, longer ttl) or file a code_task for the target
selector. IDLE with gold waiting = the build picker is stuck: clear_ignores/forgive, then a command that changes build_focus, then a
code_task. Never repeat an action that PREVIOUS ACTIONS shows already failed at this spot - change the approach. probe_at_spot (when present) is what the game itself reports at the pin:
collider class, name, size, static flag - trust it over the guessed obstacle class. Coordinates are the
world (x, z) used in the incident pos and the TRAIL. Keep answers short; prefer one decisive unstick over four timid ones."""

REVIEW_SYS = """You are MiniMax Watch doing a scheduled REVIEW of a Thronefall autopilot (the watchdog found nothing urgent or you were
woken by the timer). Use the incident statistics, ratings and the effect of earlier actions to decide whether anything systematic needs
fixing. Same JSON reply format as an incident response (diagnosis, cause, confidence, actions). Return {"actions":[]} when all is well.
Repeated incidents at the same place, a low health rating, or time lost to pins are reasons for a code_task or a bigger avoid radius."""


def _jdump(o):
    return json.dumps(o, default=str, separators=(",", ":"))


def extract_json(text):
    i0, i1 = text.find("{"), text.rfind("}")
    if i0 < 0 or i1 <= i0:
        return None
    try:
        return json.loads(text[i0:i1 + 1])
    except Exception:
        return None


class CommandCenter:
    def __init__(self, ctx, engine=None, clock=time.time, autostart_threads=False):
        self.ctx = ctx
        self.clock = clock
        self.agent = ctx.AGENT
        self.cfg_path = os.path.join(self.agent, "cc-config.json")
        self.cfg = self._load_cfg()
        self.engine = engine or inc_mod.IncidentEngine(inc_mod.FsSource(str(self.agent)), clock=clock)
        self.lock = threading.RLock()
        self.wake_lock = threading.Lock()                       # one MiniMax incident call at a time
        self.calls = deque()                                    # timestamps of recent MiniMax calls (budget window)
        self.pending = {}                                       # incident id -> reason, waiting for the next wake
        self.pending_since = 0.0
        self.last_wake = {"t": 0.0, "reason": "", "ok": None, "latency_s": None, "error": ""}
        self.inflight = False
        self.stats = {"wakes": 0, "wake_errors": 0, "alerts_seen": 0, "alerts_suppressed": 0, "actions": 0, "actions_failed": 0, "reviews": 0}
        self.started = clock()
        self.threads = {}
        self.jobs = self._load_jobs()
        self.engine_hb = 0.0
        self.last_error = ""
        self.livecap = {}                                       # last /stats summary of the live video process
        self._livecap_spawn_t = 0.0
        self.act_lock = threading.Lock()                        # one command in the act-commands.json slot at a time
        self.act_seq = 0
        self.act_timeout = 8.0                                  # how long an unstick waits for the plugin to confirm it
        self.probes_left = 0                                    # probes still allowed while building the current incident prompt
        self.probe_cache = {}                                   # incident id -> (t, hits)
        self._pid_cache = (0.0, None)
        if autostart_threads:
            self.start()

    # ------------------------------------------------------------------ config + scheduler registry
    def _load_cfg(self):
        c = json.loads(json.dumps(DEFAULT_CFG))
        try:
            d = json.load(open(self.cfg_path, encoding="utf-8"))
            for k, v in d.items():
                if isinstance(v, dict) and isinstance(c.get(k), dict):
                    c[k].update(v)
                else:
                    c[k] = v
        except Exception:
            pass
        return c

    def save_cfg(self):
        self._atomic(self.cfg_path, self.cfg)

    def _atomic(self, path, obj):
        """Write JSON via a temp file + rename. Windows refuses the rename while a reader (the plugin, the UI) has the target open,
        so retry briefly. Returns False when the file could not be replaced."""
        tmp = path + ".tmp"
        for attempt in range(6):
            try:
                with open(tmp, "w", encoding="utf-8") as f:
                    json.dump(obj, f, default=str)
                os.replace(tmp, path)
                return True
            except OSError:
                time.sleep(0.03 * (attempt + 1))
        return False

    def _load_jobs(self):
        j = self.cfg["jobs"]
        now = self.clock()
        jobs = {
            "pulse": {"every_s": j["pulse_s"], "desc": "heartbeat: refresh ratings, write botpulse.json, wake MiniMax when something is wrong", "fn": self._job_pulse},
            "review": {"every_s": j["review_s"], "desc": "MiniMax reviews incidents, ratings and the effect of its earlier actions", "fn": self._job_review},
            "selfcheck": {"every_s": j["selfcheck_s"], "desc": "verify the watchdog thread is alive, restart it if not; write cc-heartbeat.json", "fn": self._job_selfcheck},
            "livecap": {"every_s": self.cfg["livecap"]["check_s"], "desc": "keeps the live video process (tools/livecap.py) running - it is a separate process, restarted within seconds of a crash", "fn": self._job_livecap},
            "report": {"every_s": j["report_s"], "desc": "hourly summary of incidents, time lost and actions taken, posted to the chat feed", "fn": self._job_report},
        }
        saved = {}
        try:
            saved = {x["id"]: x for x in json.load(open(os.path.join(self.agent, "cc-scheduler.json"), encoding="utf-8")).get("jobs", [])}
        except Exception:
            pass
        for jid, jb in jobs.items():
            s = saved.get(jid, {})
            jb.update(id=jid, enabled=s.get("enabled", True), last=s.get("last", 0.0), last_ok=s.get("last_ok"), runs=s.get("runs", 0), last_note=s.get("last_note", ""),
                      every_s=max(10, float(s.get("every_s", jb["every_s"]))))
            jb["next"] = now + min(jb["every_s"], 5 if jid in ("pulse", "selfcheck") else 2 if jid == "livecap" else jb["every_s"])
        return jobs

    def _save_jobs(self):
        out = [{k: v for k, v in jb.items() if k != "fn"} for jb in self.jobs.values()]
        self._atomic(os.path.join(self.agent, "cc-scheduler.json"), {"t": self.clock(), "jobs": out})

    def set_job(self, jid, enabled=None, every_s=None):
        jb = self.jobs.get(jid)
        if not jb:
            return False
        if enabled is not None:
            jb["enabled"] = bool(enabled)
        if every_s is not None:
            jb["every_s"] = max(10.0, min(86400.0, float(every_s)))
            jb["next"] = self.clock() + jb["every_s"]
        self._save_jobs()
        return True

    def run_job(self, jid):
        jb = self.jobs[jid]
        t0 = self.clock()
        try:
            note = jb["fn"]() or ""
            jb.update(last_ok=True, last_note=str(note)[:160])
        except Exception as ex:
            jb.update(last_ok=False, last_note=("ERROR " + str(ex))[:160])
            self.last_error = "%s: %s" % (jid, ex)
            self._log_err("job %s failed: %s" % (jid, ex), traceback.format_exc())
        jb["last"] = t0
        jb["runs"] = jb.get("runs", 0) + 1
        jb["next"] = self.clock() + jb["every_s"]

    def scheduler_tick(self):
        now = self.clock()
        for jb in self.jobs.values():
            if jb["enabled"] and now >= jb["next"]:
                self.run_job(jb["id"])
        self._save_jobs()

    # ------------------------------------------------------------------ threads
    def start(self):
        for name, fn in (("watchdog", self._watch_loop), ("scheduler", self._sched_loop)):
            t = threading.Thread(target=fn, name="cc-" + name, daemon=True)
            self.threads[name] = t
            t.start()

    def _watch_loop(self):
        while True:
            try:
                self.engine_tick()
            except Exception as ex:
                self.last_error = "watchdog: %s" % ex
                self._log_err("watchdog tick failed: %s" % ex, traceback.format_exc())
            time.sleep(1.0)

    def _sched_loop(self):
        while True:
            try:
                self.scheduler_tick()
            except Exception as ex:
                self.last_error = "scheduler: %s" % ex
            time.sleep(1.0)

    def _log_err(self, msg, tb=""):
        try:
            with open(os.path.join(self.agent, "cc-errors.log"), "a", encoding="utf-8") as f:
                f.write("%s %s\n%s\n" % (time.strftime("%H:%M:%S"), msg, tb))
        except OSError:
            pass

    # ------------------------------------------------------------------ the watchdog tick
    def engine_tick(self):
        with self.lock:
            ch = self.engine.poll()
            self.engine_hb = self.clock()
        for a in ch["alerts"]:
            self.stats["alerts_seen"] += 1
            self.pending[a["id"]] = a["reason"]
            if not self.pending_since:
                self.pending_since = self.clock()
        for i in ch["opened"]:
            if i["sev"] in ("warn", "crit"):
                self.ctx.append_log("mm", "[%s INCIDENT %s %s] %s" % (time.strftime("%H:%M"), i["id"], i["sev"].upper(), i.get("detail") or i["kind"]))
        for i in ch["resolved"]:
            if i["sev"] == "crit" or (i.get("dur_s") or 0) >= 30:
                self.ctx.append_log("mm", "[%s resolved %s] %s after %.0fs (%s)" % (time.strftime("%H:%M"), i["id"], i["kind"], i.get("dur_s") or 0, i.get("resolved_by")))
        self.maybe_wake()
        return ch

    def _budget_ok(self, now):
        w = self.cfg["wake"]
        while self.calls and now - self.calls[0] > 600:
            self.calls.popleft()
        return len(self.calls) < w["max_per_10min"]

    def maybe_wake(self):
        """Decide whether the pending alerts justify a MiniMax call right now (coalesced, spaced, budgeted)."""
        w = self.cfg["wake"]
        if not self.pending or not w.get("enabled", True):
            return False
        now = self.clock()
        worst = "crit" if any((self.engine.get(i) or {}).get("sev") == "crit" for i in self.pending) else "warn"
        gap = w["min_gap_crit_s"] if worst == "crit" else w["min_gap_warn_s"]
        if now - self.last_wake["t"] < gap or now - self.pending_since < w["coalesce_s"]:
            return False
        if self.inflight:
            return False
        mode = self.ctx.mm_cfg().get("mode", "auto")
        if mode == "off":
            self.stats["alerts_suppressed"] += len(self.pending)
            for i in list(self.pending):
                self.engine.record_action(i, "system", {"type": "wake"}, "suppressed: MiniMax mode is OFF")
            self.pending.clear()
            self.pending_since = 0.0
            return False
        if not self._budget_ok(now):
            return False
        ids, self.pending, self.pending_since = list(self.pending), {}, 0.0
        threading.Thread(target=self.wake, args=("incident", ids), name="cc-wake", daemon=True).start()
        return True

    # ------------------------------------------------------------------ prompts
    def _trail(self):
        try:
            run = self.ctx.latest_run()
            rows = [json.loads(l) for l in self.ctx.tail_lines(run / "ticks.jsonl", 60, cap=90000)]
            return [[round(r["t"], 1), round(r["pos"][0], 1), round(r["pos"][1], 1)] for r in rows[::6] if r.get("pos")][-12:], rows[-1] if rows else {}
        except Exception:
            return [], {}

    def _recent_events(self, n=25):
        try:
            run = self.ctx.latest_run()
            out = []
            for l in self.ctx.tail_lines(run / "events.jsonl", n, cap=40000):
                e = json.loads(l)
                out.append("%.0f:%s%s" % (e.get("t", 0), e.get("note", ""), (" [" + e["what"] + "]") if e.get("what") else ""))
            return out
        except Exception:
            return []

    def _history_at(self, inc, radius=12.0, mins=45):
        """What happened at this spot before, and what was tried - so MiniMax does not repeat a failed remedy."""
        out = []
        pos = inc.get("pos")
        if not pos:
            return out
        cut = self.clock() - mins * 60
        for i in self.engine.closed[-80:]:
            if i["id"] == inc["id"] or not i.get("pos") or i.get("t_open", 0) < cut:
                continue
            if inc_mod._dist(i["pos"], pos) <= radius:
                out.append({"id": i["id"], "kind": i["kind"], "dur_s": i.get("dur_s"), "resolved_by": i.get("resolved_by"),
                            "actions": [{"by": a["by"], "action": a.get("action"), "result": a.get("result")} for a in i.get("actions", [])][-4:]})
        return out[-5:]

    def _brief_incident(self, i, last_tick):
        now = self.clock()
        pos = i.get("pos")
        near = {}
        if pos and last_tick:
            for key, label in (("cast", "castle"), ("bpos", "build_target"), ("ta", "aim")):
                p = last_tick.get(key)
                if p and len(p) >= 2:
                    near[label] = {"pos": [round(p[0], 1), round(p[1], 1)], "dist_m": round(inc_mod._dist(pos, p), 1)}
        return {"id": i["id"], "kind": i["kind"], "sev": i["sev"], "age_s": round(now - i["t_open"]), "dur_s": i.get("dur_s"), "pos": [round(x, 1) for x in pos] if pos else None,
                "scene": i.get("scene"), "mode": i.get("mode"), "obstacle": i.get("obstacle"), "count": i.get("count"), "pins": i.get("pins"), "target": i.get("target"),
                "detail": i.get("detail"), "near": near, "previous_actions": [{"by": a["by"], "action": a.get("action"), "result": a.get("result")} for a in i.get("actions", [])][-5:],
                "history_at_spot": self._history_at(i), "probe_at_spot": self._probe_for(i)}

    def _probe_for(self, i):
        """What the plugin says is at the incident's spot (colliders: class/name/size/static). Cached 60 s per incident."""
        if i.get("kind") not in ("stuck", "hotspot") or not i.get("pos"):
            return None
        hit = self.probe_cache.get(i["id"])
        if hit and self.clock() - hit[0] < 60:
            return hit[1]
        if self.probes_left <= 0 or "probe.v1" not in self._caps():
            return None
        self.probes_left -= 1                                   # each probe can take a few seconds - bound the prompt latency
        res = None
        try:
            res = self.probe_world(i["pos"], 4.0, tag="inc-" + i["id"])
        except Exception:
            res = None
        self.probe_cache[i["id"]] = (self.clock(), res)
        if len(self.probe_cache) > 200:
            for k in sorted(self.probe_cache, key=lambda k: self.probe_cache[k][0])[:100]:
                del self.probe_cache[k]
        return res

    def build_incident_prompt(self, ids, reason):
        self.probes_left = 3
        trail, last_tick = self._trail()
        with self.lock:
            opens = [self.engine.get(i) for i in ids]
            opens = [i for i in opens if i is not None]
            others = [i for i in self.engine.open_list() if i["id"] not in ids]
            ratings = dict(self.engine.ratings)
            recent = [self.engine._brief(i) for i in self.engine.closed[-8:]]
        pkg = {
            "WAKE REASON": reason,
            "INCIDENTS (act on these)": [self._brief_incident(i, last_tick) for i in sorted(opens, key=lambda x: (x["sev"] != "crit", -x["t_open"]))],
            "OTHER OPEN": [self.engine._brief(i) for i in others][:6],
            "RATINGS": ratings,
            "TRAIL [t,x,z] (oldest first)": trail,
            "RECENT EVENTS": self._recent_events(),
            "RECENTLY RESOLVED": recent,
            "OPEN PROPOSALS": self.ctx.recent_proposals(6),
            "AUDIT": {k: (self._audit().get(k)) for k in ("scene", "t", "mode", "gold", "ally", "since_prog", "useful_pct", "waste_s", "bld", "bld_blocked", "cur_build", "caps")},
        }
        return "INCIDENT PACKAGE (live data, JSON):\n" + _jdump(pkg) + "\nDecide and reply with the JSON object only."

    def build_review_prompt(self):
        with self.lock:
            st = {"ratings": dict(self.engine.ratings), "counters": dict(self.engine.counters),
                  "open": [self.engine._brief(i) for i in self.engine.open_list()],
                  "last_30min": [self.engine._brief(i) for i in self.engine.closed[-30:]]}
        acts = self.read_actions(8)
        pkg = {"STATS": st, "RECENT MINIMAX ACTIONS + OUTCOMES": [{k: a.get(k) for k in ("t", "reason", "cause", "diagnosis", "actions")} for a in acts],
               "OPEN PROPOSALS": self.ctx.recent_proposals(8), "AUDIT": {k: self._audit().get(k) for k in ("scene", "t", "mode", "gold", "since_prog", "useful_pct", "waste_s", "caps")}}
        return "SCHEDULED REVIEW (live data, JSON):\n" + _jdump(pkg) + "\nReply with the JSON object only."

    def _audit(self):
        try:
            return json.loads((self.agent / "audit.json").read_text(errors="replace"))
        except Exception:
            return {}

    # ------------------------------------------------------------------ waking MiniMax
    def wake(self, reason, ids=None, manual=False, system=None, prompt=None):
        """One MiniMax call + plan execution. Safe to call from any thread; serialised."""
        if not self.wake_lock.acquire(blocking=False):
            for i in ids or []:
                self.pending[i] = reason
            return {"ok": False, "why": "another wake is in flight (re-queued)"}
        self.inflight = True
        t0 = self.clock()
        rec = {"t": round(t0, 1), "reason": reason, "incidents": ids or [], "manual": manual}
        try:
            if not self.ctx.mm_cfg() or self.ctx.mm_cfg().get("mode") == "off" and not manual:
                rec.update(error="MiniMax mode is off")
                return rec
            self.calls.append(t0)
            prompt = prompt or self.build_incident_prompt(ids or [i["id"] for i in self.engine.open_list()], reason)
            reply, usage = self.ctx.mm_chat([{"role": "system", "content": system or INCIDENT_SYS}, {"role": "user", "content": prompt}], max_tokens=8000)
            rec["usage"] = usage
            plan = extract_json(reply) or {}
            rec.update(diagnosis=str(plan.get("diagnosis", ""))[:400], cause=str(plan.get("cause", ""))[:40], confidence=plan.get("confidence"), raw=reply[:300] if not plan else "")
            results = self.execute_plan(plan, ids or [], manual)
            rec["actions"] = results
            self.last_wake = {"t": t0, "reason": reason, "ok": True, "latency_s": round(self.clock() - t0, 1), "error": ""}
            self.stats["wakes"] += 1
            self.ctx.append_log("mm", "[%s mm-incident %s] %s :: %s" % (time.strftime("%H:%M"), ",".join(ids or []) or reason, rec["diagnosis"][:240],
                                " | ".join("%s%s=%s" % (r["type"], ("/" + r.get("how")) if r.get("how") else "", r["result"][:50]) for r in results) or "no actions"))
        except Exception as ex:
            rec["error"] = str(ex)[:300]
            self.last_wake = {"t": t0, "reason": reason, "ok": False, "latency_s": round(self.clock() - t0, 1), "error": str(ex)[:200]}
            self.stats["wake_errors"] += 1
            for i in ids or []:
                self.engine.record_action(i, "minimax", {"type": "wake"}, "ERROR " + str(ex)[:120])
            self.ctx.append_log("mm", "[%s mm-incident ERROR] %s" % (time.strftime("%H:%M"), str(ex)[:200]))
        finally:
            rec["latency_s"] = round(self.clock() - t0, 1)
            self._append_action_log(rec)
            self.inflight = False
            self.wake_lock.release()
        return rec

    # ------------------------------------------------------------------ plan validation + execution
    def _pid_alive(self, pid):
        """Is `pid` the running game? Cached 10 s. CC_SKIP_PID_CHECK=1 (simulations) trusts caps.json."""
        if os.environ.get("CC_SKIP_PID_CHECK") == "1":
            return True
        t, v = self._pid_cache
        if time.time() - t < 10 and v is not None:
            return v
        ok = False
        try:
            import subprocess
            out = subprocess.run(["tasklist", "/FI", "PID eq %d" % int(pid), "/FO", "CSV", "/NH"], capture_output=True, text=True, timeout=5).stdout.lower()
            ok = "thronefall" in out
        except Exception:
            ok = False
        self._pid_cache = (time.time(), ok)
        return ok

    def plugin_info(self):
        """What the running plugin build can do: caps.json (written by Act.cs every 30 s, tied to the game's pid) plus audit.json's own list."""
        info = {"caps": sorted(self._audit().get("caps") or []), "build": None, "view_ok": None, "age_s": None}
        try:
            c = json.loads((self.agent / "caps.json").read_text(errors="replace"))
            age = self.clock() - float(c.get("t", 0))
            if age < 120 and self._pid_alive(c.get("pid")):
                info.update(caps=sorted(set(info["caps"]) | set(c.get("caps") or [])), build=c.get("build"), view_ok=c.get("view_ok"), age_s=round(age, 1))
        except Exception:
            pass
        return info

    def _caps(self):
        return set(self.plugin_info()["caps"])

    def send_act(self, cmd, tag="cc", timeout=8.0):
        """Write one command into act-commands.json (the plugin polls it every 0.4 s) and wait for the plugin's act-ack.json with our note.
        Serialised: a second command waits for the first so the single slot is never overwritten before it was read. Returns the ack dict or None."""
        with self.act_lock:
            self.act_seq += 1
            note = "%s#%d-%d" % (tag, int(self.clock() * 1000), self.act_seq)    # unique even if two commands share a millisecond: the plugin dedupes by note
            before = self._log_size()
            if not self._atomic(os.path.join(self.agent, "act-commands.json"), dict(cmd, note=note)):
                return {"note": note, "ok": False, "detail": "could not write act-commands.json (file locked?)", "via": "server"}
            end = time.time() + timeout
            while time.time() < end:
                time.sleep(0.1)
                try:
                    ack = json.load(open(os.path.join(self.agent, "act-ack.json"), encoding="utf-8"))
                    if ack.get("note") == note:
                        return ack
                except Exception:
                    pass
            # no ack file: the game log is an independent witness (Act.cs logs every executed command together with its note)
            line = self._find_in_log("(note %s)" % note, before, 2.0)
            if line:
                return {"note": note, "ok": " OK ::" in line, "detail": line.split("::", 1)[-1].strip()[:140], "via": "gamelog"}
            return None

    def probe_world(self, pos, r=4.0, tag="probe", timeout=4.0):
        """Ask the plugin what is at a world position (colliders within r m): returns a trimmed hit list, or None when unsupported/unanswered."""
        if "probe.v1" not in self._caps():
            return None
        pid = "%s-%d" % (tag, int(self.clock() * 1000))
        ack = self.send_act({"act": "probe", "wx": round(pos[0], 1), "wz": round(pos[1], 1), "wr": r, "id": pid}, tag="probe", timeout=timeout)
        if not ack or not ack.get("ok"):
            return None
        return self._read_probe(pid)

    def _read_probe(self, pid):
        try:
            d = json.load(open(os.path.join(self.agent, "probe.json"), encoding="utf-8"))
        except Exception:
            return None
        if d.get("id") != pid:
            return None
        hits = [h for h in d.get("hits", []) if not h.get("decor")]
        return {"world": d.get("world"), "mode": d.get("mode"),
                "hits": [{"cls": h.get("cls"), "name": h.get("name"), "path": h.get("path"), "layer": h.get("lay"), "static": h.get("stat"), "size": h.get("size"), "centre": h.get("c"), "dist_m": h.get("dist")} for h in hits[:6]]}

    def validate_action(self, a):
        """Return a cleaned action dict or None. Strict whitelist + clamps - the model never reaches the plugin or the OS directly."""
        if not isinstance(a, dict):
            return None
        t = a.get("type")
        if t == "unstick":
            how = a.get("how")
            if how not in PLUGIN_ACTIONS:
                return None
            out = {"type": "unstick", "how": how, "why": str(a.get("why", ""))[:160]}
            for k, lo, hi in (("x", -2000, 2000), ("z", -2000, 2000), ("r", 2, 40), ("ttl_s", 10, 1800)):
                if isinstance(a.get(k), (int, float)) and not isinstance(a.get(k), bool):
                    out[k] = max(lo, min(hi, float(a[k])))
            if how in ("avoid", "goto") and ("x" not in out or "z" not in out):
                return None
            if how == "avoid":
                out.setdefault("r", 12.0)
                out.setdefault("ttl_s", 600.0)
            return out
        if t == "command":
            patch = self.ctx.validate_patch(a.get("patch"))
            return {"type": "command", "patch": patch} if patch else None
        if t == "code_task":
            if not str(a.get("title", "")).strip():
                return None
            return {"type": "code_task", "title": str(a["title"])[:120], "file": str(a.get("file", ""))[:80], "function": str(a.get("function", ""))[:80],
                    "evidence": str(a.get("evidence", ""))[:600], "fix": str(a.get("fix", ""))[:800]}
        if t == "relaunch":
            return {"type": "relaunch", "why": str(a.get("why", ""))[:160]}
        if t == "ack":
            return {"type": "ack", "note": str(a.get("note", ""))[:200]}
        return None

    def execute_plan(self, plan, ids, manual=False):
        mode = self.ctx.mm_cfg().get("mode", "auto")
        acts = plan.get("actions") if isinstance(plan, dict) else None
        results = []
        for raw in (acts or [])[:4]:
            a = self.validate_action(raw)
            if a is None:
                results.append({"type": str((raw or {}).get("type", "?")) if isinstance(raw, dict) else "?", "result": "rejected: failed validation"})
                continue
            res = {"type": a["type"], "how": a.get("how"), "params": {k: v for k, v in a.items() if k not in ("type", "how", "why")}, "why": a.get("why")}
            try:
                res["result"] = self._run_action(a, ids, mode, manual)
            except Exception as ex:
                res["result"] = "ERROR %s" % str(ex)[:120]
                self.stats["actions_failed"] += 1
            self.stats["actions"] += 1
            for i in ids:
                self.engine.record_action(i, "minimax", {k: v for k, v in a.items() if k != "why"}, res["result"])
            results.append(res)
        return results

    def _run_action(self, a, ids, mode, manual):
        t = a["type"]
        if t == "ack":
            for i in ids:
                self.engine.ack(i, "minimax", a.get("note", ""))
            return "acked"
        if t == "code_task":
            return self.enqueue_code_task(a, ids)
        if t == "command" and ids:
            kinds = {(self.engine.get(i) or {}).get("kind") for i in ids} - {None}
            if kinds and kinds <= {"stuck", "hotspot", "wedge", "feed", "code"}:
                # strategy knobs cannot move a pinned hero; a blanket "clear" would also wipe the army/focus the user set
                return "dropped: strategy knobs cannot fix a %s incident (use unstick or code_task)" % "/".join(sorted(kinds))
        if t == "relaunch":
            worst = [self.engine.get(i) or {} for i in ids]
            if not any(w.get("kind") in ("feed", "wedge") and (w.get("sev") == "crit" or (w.get("dur_s") or 0) >= 60) for w in worst):
                return "refused: a relaunch needs a feed/wedge incident that has lasted >= 60 s (a pin or idle incident never justifies killing the game)"
        if mode == "semi" and t in ("unstick", "command", "relaunch") and not manual:
            # the stored patch is exactly what /mmapprove will write for the plugin (or hand to apply_side_effects)
            if t == "command":
                patch = dict(a.get("patch") or {})
            elif t == "unstick":
                patch = {"act": a["how"], **{k: a[k] for k in ("x", "z", "r", "ttl_s") if k in a}}
            else:
                patch = {"relaunch": True}
            patch["note"] = "incident %s#semi" % ",".join(ids)
            pend = self.ctx.pending_list()
            pend.append({"t": round(self.clock(), 1), "patch": patch, "note": "incident %s: %s" % (",".join(ids), t)})
            self.ctx.pending_write(pend[-20:])
            return "queued for approval (semi mode)"
        if t == "command":
            patch = self.ctx.guard_patch(dict(a["patch"]), self.ctx.live_state())
            if not patch:
                return "dropped by guard"
            patch["note"] = "incident-%s#%d" % ((ids or ["x"])[0], int(self.clock()))
            self.ctx.write_cmd(patch)
            return "written (plugin applies within ~4 s)"
        if t == "relaunch":
            if mode not in ("auto", "aggressive"):
                return "needs auto/aggressive mode"
            se = self.ctx.apply_side_effects({"relaunch": True}, mode, self.ctx.live_state())
            return se or "relaunch requested"
        if t == "unstick":
            return self.send_unstick(a, ids)
        return "unknown action"

    def send_unstick(self, a, ids):
        caps = self._caps()
        if "act.v1" not in caps:
            # the deployed plugin build cannot execute movement commands yet - say so, and make sure the engineer hears about it once
            self.enqueue_code_task({"type": "code_task", "title": "Plugin lacks act.v1 - incident responder cannot unstick the hero",
                                    "file": "src/Act.cs", "function": "Act.PerFrame", "evidence": "plugin caps=%s; MiniMax requested unstick/%s" % (sorted(caps), a.get("how")),
                                    "fix": "deploy the build that contains src/Act.cs (act.v1: retreat/avoid/goto/clear_ignores/forgive, probe.v1, view.v1)"}, ids, dedupe=True)
            return "UNSUPPORTED: deployed plugin has no act.v1 (queued as engineer task)"
        cmd = {"act": a["how"]}
        for k in ("x", "z", "r", "ttl_s"):
            if k in a:
                cmd[k] = a[k]
        ack = self.send_act(cmd, tag="incident-%s" % ((ids or ["x"])[0]), timeout=self.act_timeout)
        if ack is None:
            return "sent, NOT confirmed by the plugin within 8 s (no act-ack.json, nothing in the game log)"
        if ack.get("via") == "server":
            return "NOT sent: " + str(ack.get("detail", ""))[:140]
        return ("executed by the bot: " if ack.get("ok") else "plugin could not execute: ") + str(ack.get("detail", ""))[:140]

    def _log_size(self):
        try:
            return os.path.getsize(GAMELOG)
        except OSError:
            return -1

    def _find_in_log(self, marker, before, timeout):
        """The first game-log line (written after offset `before`) that contains `marker`, or None after `timeout` s."""
        p = GAMELOG
        end = time.time() + timeout
        while True:
            try:
                size = os.path.getsize(p)
                with open(p, "rb") as f:
                    f.seek(before if 0 <= before <= size else 0)
                    for line in f.read().decode("utf-8", "replace").splitlines():
                        if marker in line:
                            return line
            except OSError:
                pass
            if time.time() >= end:
                return None
            time.sleep(0.3)

    def enqueue_code_task(self, a, ids, dedupe=False):
        path = os.path.join(self.agent, "engineer-queue.jsonl")
        existing = []
        try:
            existing = [json.loads(l) for l in open(path, encoding="utf-8").read().splitlines() if l.strip()]
        except OSError:
            pass
        if any(e.get("title", "").lower() == a["title"].lower() and e.get("status") in ("queued", "working", "patched") for e in existing) or \
           (dedupe and any(e.get("title", "").lower() == a["title"].lower() for e in existing)):
            return "already queued"
        rec = {"id": "E%04d" % (len(existing) + 1), "t": round(self.clock(), 1), "status": "queued", "priority": "urgent", "incidents": ids, "title": a["title"], "file": a.get("file"),
               "function": a.get("function"), "evidence": a.get("evidence"), "fix": a.get("fix")}
        with open(path, "a", encoding="utf-8") as f:
            f.write(json.dumps(rec) + "\n")
        try:                                                    # also surface it where the engineer already looks (proposals.jsonl)
            self.ctx.record_proposal({"bug": "[URGENT %s] %s" % (rec["id"], a["title"]), "evidence": a.get("evidence", ""), "fix": "%s %s: %s" % (a.get("file", ""), a.get("function", ""), a.get("fix", ""))}, self.ctx.live_state())
        except Exception:
            pass
        return "queued as %s (engineer queue)" % rec["id"]

    # ------------------------------------------------------------------ logs
    def _append_action_log(self, rec):
        try:
            p = os.path.join(self.agent, "mm-actions.jsonl")
            if os.path.exists(p) and os.path.getsize(p) > 4_000_000:
                os.replace(p, p + ".old")
            with open(p, "a", encoding="utf-8") as f:
                f.write(json.dumps(rec, default=str) + "\n")
        except OSError:
            pass

    def read_actions(self, n=30):
        p = os.path.join(self.agent, "mm-actions.jsonl")
        out = []
        try:
            for l in self.ctx.tail_lines(type(self.agent)(p), n, cap=300000):
                out.append(json.loads(l))
        except Exception:
            pass
        return out

    # ------------------------------------------------------------------ scheduled jobs
    def _job_pulse(self):
        now = self.clock()
        with self.lock:
            pulse = self.engine.pulse()
        pulse.update(self.pulse_extra())
        self._atomic(os.path.join(self.agent, "botpulse.json"), pulse)
        # a pulse wakes MiniMax when the bot is unhealthy and nothing else did recently
        r = self.engine.ratings
        mode = self.ctx.mm_cfg().get("mode", "auto")
        if mode != "off" and r.get("health", 100) < 55 and now - self.last_wake["t"] > 120 and self.engine.open and self._budget_ok(now) and not self.inflight:
            ids = [i["id"] for i in self.engine.open_list()]
            threading.Thread(target=self.wake, args=("pulse: health %s (%s)" % (r.get("health"), r.get("grade")), ids), daemon=True).start()
            return "health %s - woke MiniMax" % r.get("health")
        return "health %s grade %s, %d open" % (r.get("health"), r.get("grade"), len(self.engine.open))

    def _job_review(self):
        mode = self.ctx.mm_cfg().get("mode", "auto")
        if mode == "off":
            return "skipped (MiniMax off)"
        st = self.ctx.live_state()
        if not st.get("live"):
            return "skipped (bot not live)"
        if self.inflight or not self._budget_ok(self.clock()):
            return "skipped (busy/budget)"
        self.stats["reviews"] += 1
        rec = self.wake("review", [], prompt=self.build_review_prompt(), system=REVIEW_SYS)
        return "review: %s" % (rec.get("diagnosis") or rec.get("error") or "no diagnosis")[:100]

    def livecap_port(self):
        return int(os.environ.get("LIVECAP_PORT") or self.cfg.get("livecap", {}).get("port", 8097))

    def _job_livecap(self):
        """Is the live video process up? If not, start it detached (it must outlive this server). Returns a one-line note for the scheduler table."""
        lc = self.cfg.get("livecap", {})
        if not lc.get("enabled", True) or os.environ.get("CC_LIVECAP") == "0":
            return "disabled"
        port = self.livecap_port()
        try:
            with urllib.request.urlopen("http://127.0.0.1:%d/stats" % port, timeout=1.5) as r:
                d = json.loads(r.read())
            cap = d.get("capture", {})
            self.livecap = {"ok": True, "state": d.get("state"), "source": d.get("source"), "fps": cap.get("fps"), "clients": len(d.get("clients", [])), "out": d.get("cfg", {}).get("out"),
                            "frame_age_s": d.get("frame_age_s"), "restarts": cap.get("restarts"), "version": d.get("version"), "detail": d.get("detail"), "game": (d.get("game") or {}).get("connected")}
            return "up: %s %s fps, %d viewer(s)" % (d.get("state"), cap.get("fps"), len(d.get("clients", [])))
        except Exception:
            self.livecap = {"ok": False}
        if self.clock() - self._livecap_spawn_t < 20:
            return "starting"
        self._livecap_spawn_t = self.clock()
        cmd = [sys.executable, os.path.join(HERE, "livecap.py"), "--port", str(port), "--agent", str(self.agent)] + (os.environ.get("LIVECAP_ARGS", "").split() if os.environ.get("LIVECAP_ARGS") else [])
        flags = (0x00000008 | 0x00000200 | 0x08000000) if sys.platform == "win32" else 0         # DETACHED_PROCESS | CREATE_NEW_PROCESS_GROUP | CREATE_NO_WINDOW
        try:
            out = open(os.path.join(self.agent, "livecap.out"), "ab")
            subprocess.Popen(cmd, stdin=subprocess.DEVNULL, stdout=out, stderr=out, creationflags=flags, close_fds=True, cwd=os.path.dirname(HERE))
        except OSError as ex:
            return "could not start livecap: %s" % ex
        self.ctx.append_log("mm", "[%s live-video] livecap was not running - started it (port %d)" % (time.strftime("%H:%M"), port))
        return "started livecap (port %d)" % port

    def _job_selfcheck(self):
        out = []
        for name, fn in (("watchdog", self._watch_loop),):
            t = self.threads.get(name)
            if t is not None and not t.is_alive():
                nt = threading.Thread(target=fn, name="cc-" + name, daemon=True)
                self.threads[name] = nt
                nt.start()
                out.append("restarted " + name)
        self._atomic(os.path.join(self.agent, "cc-heartbeat.json"), {"t": self.clock(), "pid": os.getpid(), "engine_hb": self.engine_hb, "started": self.started, "stats": self.stats,
                                                                     "threads": {k: v.is_alive() for k, v in self.threads.items()}, "last_error": self.last_error})
        return "; ".join(out) or "threads ok"

    def _job_report(self):
        with self.lock:
            c = dict(self.engine.counters)
            lost = sum(x["dur"] for x in self.engine.streaks)
        self.ctx.append_log("mm", "[%s hourly] incidents opened %d, resolved %d, alerts %d, MiniMax wakes %d (errors %d), actions %d, ~%.0fs pinned in the last window"
                            % (time.strftime("%H:%M"), c["opened"], c["resolved"], c["alerts"], self.stats["wakes"], self.stats["wake_errors"], self.stats["actions"], lost))
        return "posted"

    # ------------------------------------------------------------------ API payloads
    def pulse_extra(self):
        now = self.clock()
        a = self._audit()
        mmcfg = self.ctx.mm_cfg()
        hb = {}
        try:
            hb = json.loads((self.agent / "mm-heartbeat.json").read_text())
        except Exception:
            pass
        sup = {}
        try:
            sup = json.loads((self.agent / "supervisor.json").read_text())
        except Exception:
            pass
        while self.calls and now - self.calls[0] > 600:
            self.calls.popleft()
        nxt = [jb["next"] for jb in self.jobs.values() if jb["enabled"] and jb["id"] in ("pulse", "review")]
        return {"bot": {"audit_age_s": round(now - os.path.getmtime(self.agent / "audit.json"), 1) if (self.agent / "audit.json").exists() else None,
                        "scene": a.get("scene"), "mode": a.get("mode"), "caps": a.get("caps") or [], "run": self.engine.run},
                "minimax": {"mode": mmcfg.get("mode"), "interval_s": mmcfg.get("interval_s"), "watch_hb_age_s": round(now - hb.get("t", 0), 1) if hb else None,
                            "last_wake": self.last_wake, "inflight": self.inflight, "calls_10min": len(self.calls), "budget_10min": self.cfg["wake"]["max_per_10min"],
                            "pending_alerts": len(self.pending), "stats": self.stats},
                "watchdog": {"alive": self.threads.get("watchdog").is_alive() if self.threads.get("watchdog") else False, "age_s": round(now - self.engine_hb, 1) if self.engine_hb else None,
                             "uptime_s": round(now - self.started)},
                "scheduler": self.api_scheduler()["jobs"], "next_wake_in_s": round(min(nxt) - now) if nxt else None, "supervisor": sup,
                "pending": self.ctx.pending_list(), "plugin": self.plugin_info(), "livecap": self.livecap}

    def api_scheduler(self):
        return {"t": self.clock(), "jobs": [{k: v for k, v in jb.items() if k != "fn"} for jb in self.jobs.values()]}

    def api_probe(self, data):
        """UI click-to-probe: {sx,sy} (game-screen pixels) or {wx,wz,wr} (world) -> what is there."""
        if "probe.v1" not in self._caps():
            return {"ok": False, "why": "the running plugin build has no probe.v1 - deploy the new build (src/Act.cs)"}
        pid = "ui-%d" % int(self.clock() * 1000)
        cmd = {"act": "probe", "id": pid}
        try:
            if "sx" in data and "sy" in data:
                cmd.update(sx=float(data["sx"]), sy=float(data["sy"]))
            else:
                cmd.update(wx=float(data["wx"]), wz=float(data["wz"]), wr=float(data.get("wr", 3)))
        except Exception:
            return {"ok": False, "why": "need sx,sy or wx,wz"}
        ack = self.send_act(cmd, tag="ui-probe", timeout=6.0)
        if not ack:
            return {"ok": False, "why": "no answer from the plugin within 6 s"}
        if not ack.get("ok"):
            return {"ok": False, "why": ack.get("detail", "probe failed")}
        res = self._read_probe(pid)
        return {"ok": bool(res), "probe": res, "why": "" if res else "probe.json did not match"}

    def api_incidents(self, n=60):
        with self.lock:
            snap = {"t": round(self.clock(), 1), "run": self.engine.run, "open": self.engine.open_list(), "counters": self.engine.counters, "ratings": self.engine.ratings,
                    "recent": [self.engine._brief(i) for i in self.engine.closed[-15:]][::-1]}
        snap["log"] = self.engine.recent(n)
        return snap

    # ------------------------------------------------------------------ HTTP (hooked from coach-server.py)
    def http_get(self, h, path):
        base, _, q = path.partition("?")
        args = dict(p.split("=", 1) for p in q.split("&") if "=" in p)
        if base == "/incidents":
            h._send(200, _jdump(self.api_incidents(int(args.get("n", 60)))), "application/json")
        elif base == "/botpulse":
            h._send(200, _jdump(dict(self.engine.pulse(), **self.pulse_extra())), "application/json")
        elif base == "/mmactions":
            h._send(200, _jdump(self.read_actions(int(args.get("n", 30)))), "application/json")
        elif base == "/scheduler":
            h._send(200, _jdump(self.api_scheduler()), "application/json")
        elif base == "/engineer-queue":
            rows = []
            try:
                # merged view: queue rows + per-task status sidecar
                eng = self._engineer()
                if eng:
                    rows = eng.queue()[-40:]
                else:
                    rows = [json.loads(l) for l in open(os.path.join(self.agent, "engineer-queue.jsonl"), encoding="utf-8").read().splitlines() if l.strip()][-40:]
            except Exception:
                pass
            h._send(200, _jdump(rows[::-1]), "application/json")
        elif base == "/engineer/diff":
            try:
                eng = self._engineer()
                d = eng.diff_text(str(args.get("id", ""))) if eng else None
            except Exception as ex:
                d = "diff error: %s" % ex
            h._send(200, _jdump({"diff": d}), "application/json")
        elif base == "/view.json":                      # camera matrix + zones published by the plugin (UI overlay); {} until then
            try:
                h._send(200, open(os.path.join(self.agent, "view.json"), "rb").read(), "application/json")
            except OSError:
                h._send(200, "{}", "application/json")
        elif base == "/alive":
            h._send(200, _jdump({"ok": True, "t": self.clock(), "uptime_s": round(self.clock() - self.started), "watchdog": bool(self.threads.get("watchdog") and self.threads["watchdog"].is_alive())}), "application/json")
        elif base == "/incident/frame":
            p = os.path.join(self.agent, "incidents", re.sub(r"[^A-Za-z0-9_-]", "", args.get("id", "")) + ".jpg")
            if os.path.exists(p):
                h._send(200, open(p, "rb").read(), "image/jpeg")
            else:
                h._send(404, "no frame")
        elif base in ("/cc.js", "/cc.css", "/live.js"):
            p = os.path.join(HERE, base[1:])
            if os.path.exists(p):
                h._send(200, open(p, "rb").read(), "text/javascript; charset=utf-8" if base.endswith(".js") else "text/css; charset=utf-8")
            else:
                h._send(404, "missing " + base)
        else:
            return False
        return True

    def api_act(self, data):
        """UI -> bot: the same movement actions MiniMax can send (retreat / avoid / goto / forgive / clear_ignores / probe), validated and clamped by
        the same whitelist, executed through the act.v1 channel with the plugin's acknowledgement."""
        how = str(data.get("act") or data.get("how") or "")
        if how == "probe":
            return self.api_probe(data)
        a = self.validate_action({"type": "unstick", "how": how, **{k: data[k] for k in ("x", "z", "r", "ttl_s") if k in data}})
        if a is None:
            return {"ok": False, "why": "invalid action (retreat | avoid x,z | goto x,z | forgive | clear_ignores | probe)"}
        if "act.v1" not in self._caps():
            return {"ok": False, "why": "the running plugin build has no act.v1 - deploy the build that contains src/Act.cs"}
        res = self.send_unstick(a, ["ui"])
        ok = res.startswith("executed")
        self.stats["actions"] += 1
        self.ctx.append_log("c", "[%s ui-act] %s %s -> %s" % (time.strftime("%H:%M"), how, {k: a[k] for k in ("x", "z", "r", "ttl_s") if k in a}, res[:140]))
        return {"ok": ok, "result": res, "act": a}

    def _engineer(self):
        """Lazy mm_engineer handle — the import pulls in the whole safety
        model, so it only happens when the queue endpoint is touched."""
        if getattr(self, "_eng", None) is None:
            try:
                sys.path.insert(0, HERE) if HERE not in sys.path else None
                import mm_engineer
                repo = os.path.dirname(HERE)
                self._eng = mm_engineer.Engineer(
                    repo, self.agent, mm_engineer.make_minimax_chat(),
                    log=lambda m: self.ctx.append_log("eng", str(m)[:200]))
            except Exception as ex:
                self.ctx.append_log("err", "engineer init: %s" % ex)
                self._eng = False
        return self._eng or None

    def http_post(self, h, path, n):
        if path not in ("/incident/ack", "/incident/wake", "/scheduler", "/probe", "/act", "/engineer"):
            return False
        try:
            data = json.loads(h.rfile.read(n) or b"{}")
        except Exception:
            h._send(400, "bad json")
            return True
        if path == "/engineer":
            eng = self._engineer()
            if not eng:
                h._send(200, _jdump({"ok": False, "why": "engineer module unavailable"}), "application/json")
                return True
            tid = str(data.get("id", ""))
            act = str(data.get("action", ""))
            confirm = data.get("confirm") is True
            def _do():
                try:
                    if act == "run":    res = eng.run_task(tid)
                    elif act == "apply":  res = eng.apply_patch(tid)
                    elif act == "deploy": res = eng.deploy(tid, confirm=confirm)
                    elif act == "reject": res = eng.reject(tid, str(data.get("reason", "ui")))
                    elif act == "requeue": res = eng.requeue(tid)
                    elif act == "revert": res = eng.revert(tid)
                    else: res = {"ok": False, "why": "bad action"}
                    self.ctx.append_log("eng", "[engineer %s %s] %s" % (act, tid, res.get("ok", False)))
                except Exception as ex:
                    self.ctx.append_log("err", "engineer %s %s failed: %s" % (act, tid, ex))
            threading.Thread(target=_do, daemon=True).start()
            h._send(200, _jdump({"ok": True, "started": act, "id": tid}), "application/json")
            return True
        if path == "/incident/ack":
            ok = self.engine.ack(str(data.get("id", "")), "user", str(data.get("note", "")))
            h._send(200, _jdump({"ok": ok}), "application/json")
        elif path == "/incident/wake":
            ids = [str(data["id"])] if data.get("id") else [i["id"] for i in self.engine.open_list()]
            threading.Thread(target=self.wake, args=("manual wake from the Live View", ids, True), daemon=True).start()
            h._send(200, _jdump({"ok": True, "ids": ids}), "application/json")
        elif path == "/probe":
            h._send(200, _jdump(self.api_probe(data)), "application/json")
        elif path == "/act":
            h._send(200, _jdump(self.api_act(data)), "application/json")
        elif path == "/scheduler":
            jid = str(data.get("job", ""))
            ok = self.set_job(jid, data.get("enabled"), data.get("every_s"))
            if ok and data.get("run"):
                threading.Thread(target=self.run_job, args=(jid,), daemon=True).start()
            h._send(200, _jdump({"ok": ok, "jobs": self.api_scheduler()["jobs"]}), "application/json")
        return True


def start(ctx_globals):
    """Called from coach-server.py's __main__ with its module globals."""
    import types
    names = ("AGENT", "mm_chat", "mm_cfg", "validate_patch", "guard_patch", "write_cmd", "append_log", "record_proposal", "apply_side_effects", "live_state", "latest_run",
             "tail_lines", "pending_list", "pending_write", "recent_proposals")
    ctx = types.SimpleNamespace(**{n: ctx_globals[n] for n in names})
    cc = CommandCenter(ctx, autostart_threads=True)
    return cc
