"""Incident engine for the Thronefall command center.

Watches the bot's live telemetry (agent/runs/<run>/ticks.jsonl + events.jsonl, audit.json, the game log) and turns
"the hero is stuck / idle / wedged / the feed is dead / code is throwing" into INCIDENTS with a lifecycle, severity,
location, obstacle classification, a persistent log and an alert queue for MiniMax.

    from incidents import IncidentEngine, FsSource
    eng = IncidentEngine(FsSource(AGENT_DIR))
    changes = eng.poll()          # call ~1 Hz; returns {"opened":[...], "escalated":[...], "resolved":[...], "alerts":[...]}
    eng.open_list(); eng.recent(50); eng.pulse(); eng.ack(id, by, note); eng.record_action(id, actor, action, result)

Files written (all in the agent dir, atomic):
    incidents.jsonl        append-only lifecycle log: {t, id, ev: open|update|escalate|action|ack|resolve, ...}
    incidents-open.json    snapshot of the open incidents + counters (what the UI polls)
    incidents-seq.json     id counter (survives restarts)
    incidents/<id>.jpg     frame captured when an incident reached warn (cap 80)

Detectors (thresholds in CFG): STUCK streaks of the bot's own pin events (>=5 s warn, >=12 s crit), HOTSPOT = the same spot pinned
again and again (>=3 streaks / >=8 pins within 8 m in 3 min), IDLE (gold waiting, no progress), LOOP (the same build target abandoned
again and again), WEDGE (UI frame / non-match state stuck), FEED (telemetry stopped), CODE (exceptions in the game log).
The pure detection logic works on plain dicts so it can be unit-tested with synthetic data (tests/test_incidents.py).
"""
import json
import math
import os
import re
import time

CFG = {
    "stuck_warn_s": 5.0,         # a pin streak this long opens a STUCK incident (warn)
    "stuck_crit_s": 12.0,        # ... and this long escalates it to crit
    "first_strike_s": 2.0,       # the bot's first strike fires after ~2 s of not moving: a lone strike counts as this long
    "streak_gap_s": 8.0,         # pin events closer together than this belong to one streak
    "resolve_quiet_s": 20.0,     # no pin for this long -> the incident resolves
    "hotspot_radius_m": 8.0,
    "hotspot_window_s": 180.0,
    "hotspot_min_streaks": 3,
    "hotspot_min_pins": 8,
    "hotspot_quiet_s": 120.0,
    "idle_gold_min": 400,
    "idle_warn_s": 60.0,
    "idle_crit_s": 180.0,
    "loop_window_s": 150.0,
    "loop_min": 3,
    "wedge_s": 20.0,
    "feed_dead_s": 10.0,
    "code_window_s": 60.0,
    "code_min": 3,
    "new_spot_m": 12.0,          # a pin streak farther than this from the open STUCK incident is a new incident
    "min_realert_s": 60.0,       # an unresolved incident re-alerts at most this often
    "snap_cap": 80,
}

STRIKE_RE = re.compile(r"^(stuck:\d+|pin-park|unstick:\d+)$")
LOOP_NOTES = ("approach-timeout", "pin-park", "slot-abandon", "door-park", "build-stall")
IMMOVABLE = ("boundar", "terrain", "ground", "rock", "cliff", "tree", "stone", "mountain", "water", "edge")


def classify_obstacle(what):
    """'pen:Wall' -> {'class':'player wall', ...}; 'obj:Boundaries 3 (2)' -> immovable map boundary; ... The `what` strings are
    produced by Bot.PinProbe (nearest collider ahead of the hero when a pin strike fires)."""
    w = (what or "").strip()
    if not w:
        return {"class": "unknown", "name": "", "immovable": None, "raw": w}
    kind, _, name = w.partition(":")
    kind, name = kind.strip().lower(), name.strip()
    low = name.lower()
    if kind == "pen":
        cls = "player wall" if "wall" in low or "palisade" in low else ("gate" if "gate" in low else "player building")
        return {"class": cls, "name": name, "immovable": False, "raw": w}
    if "gate" in low or kind == "gate":
        return {"class": "gate", "name": name, "immovable": False, "raw": w}
    if kind in ("unit", "enemy", "ally") or "enemy" in low:
        return {"class": "unit", "name": name, "immovable": False, "raw": w}
    if any(s in low for s in IMMOVABLE):
        cls = "map boundary" if "boundar" in low else "terrain"
        return {"class": cls, "name": name, "immovable": True, "raw": w}
    return {"class": "object", "name": name or kind, "immovable": None, "raw": w}


def _dist(a, b):
    return math.hypot(a[0] - b[0], a[1] - b[1])


class Incident(dict):
    """A plain dict with the lifecycle fields the UI reads."""


class IncidentEngine:
    def __init__(self, source, cfg=None, clock=time.time):
        self.src = source
        self.cfg = dict(CFG, **(cfg or {}))
        self.clock = clock
        self.open = {}                     # id -> incident
        self.closed = []                   # recent resolved incidents (newest last, capped)
        self.alert_q = []                  # incidents that need a MiniMax wake: [{id, reason}]
        self.counters = {"opened": 0, "resolved": 0, "alerts": 0}
        self.streak = None                 # current pin streak: {first_t, last_t, pins:[(t,kind,pos,what)], pos:[...]}
        self.streaks = []                  # recent finished/ongoing streaks for hotspot clustering: {t_end, centre, dur, pins, what}
        self.loop_hist = []                # (t_run, note, target)
        self.run = None
        self.last_ev_t = 0.0
        self.last_poll = 0.0
        self.ratings = {}
        self.seq = self.src.load_seq()

    # ------------------------------------------------------------------ helpers
    def _new_id(self, kind):
        self.seq += 1
        self.src.save_seq(self.seq)
        return "%s%04d" % ({"stuck": "S", "hotspot": "H", "idle": "I", "loop": "L", "wedge": "W", "feed": "F", "code": "C"}.get(kind, "X"), self.seq)

    def _emit(self, ev, inc, **extra):
        rec = {"t": round(self.clock(), 1), "id": inc["id"], "ev": ev, "kind": inc["kind"], "sev": inc["sev"]}
        rec.update(extra)
        self.src.log(rec)

    def _open(self, kind, sev, now, **fields):
        inc = Incident(id=self._new_id(kind), kind=kind, sev=sev, status="open", t_open=round(now, 1), t_last=round(now, 1),
                       run=self.run, actions=[], alerts=0, acked=None, **fields)
        self.open[inc["id"]] = inc
        self.counters["opened"] += 1
        self._emit("open", inc, **{k: v for k, v in fields.items() if k in ("pos", "scene", "mode", "obstacle", "dur_s", "detail", "target", "count")})
        if sev in ("warn", "crit"):
            self._queue_alert(inc, "opened")
        return inc

    def _queue_alert(self, inc, reason):
        inc["alerts"] += 1
        inc["t_alert"] = round(self.clock(), 1)
        self.alert_q.append({"id": inc["id"], "reason": reason})
        self.counters["alerts"] += 1
        self.src.snapshot_frame(inc["id"], self.cfg["snap_cap"])

    def _escalate(self, inc, sev, reason):
        if inc["sev"] == sev:
            return False
        inc["sev"] = sev
        self._emit("escalate", inc, reason=reason, dur_s=inc.get("dur_s"))
        self._queue_alert(inc, reason)
        return True

    def _resolve(self, inc, how, now):
        inc["status"] = "resolved"
        inc["t_close"] = round(now, 1)
        inc["resolved_by"] = how
        self.open.pop(inc["id"], None)
        self.closed.append(inc)
        self.closed = self.closed[-200:]
        self.counters["resolved"] += 1
        self._emit("resolve", inc, by=how, dur_s=inc.get("dur_s"), actions=len(inc["actions"]))
        return inc

    def _find_open(self, kind, near=None, radius=None):
        for inc in self.open.values():
            if inc["kind"] != kind:
                continue
            if near is not None and inc.get("pos") and _dist(inc["pos"], near) > (radius or 1e9):
                continue
            return inc
        return None

    # ------------------------------------------------------------------ main entry
    def poll(self):
        """Read the sources, run every detector, return what changed."""
        now = self.clock()
        out = {"opened": [], "escalated": [], "resolved": [], "alerts": []}
        before_open = set(self.open)
        before_sev = {i: v["sev"] for i, v in self.open.items()}
        b = self.src.read()                                    # one consistent bundle of data (see FsSource.read)
        if b.get("run") != self.run:
            self._new_run(b.get("run"), now)
        ticks, events, audit = b.get("ticks", []), b.get("events", []), b.get("audit") or {}
        scene = (ticks[-1].get("scene") if ticks else None) or audit.get("scene")
        self._feed(b, now)
        if b.get("live"):
            self._ingest_events(events, ticks, now, scene)
            self._detect_stuck(ticks, now, scene)
            self._detect_hotspot(now, ticks[-1].get("t", 0) if ticks else 0, scene)
            self._detect_loop(events, ticks, now, scene)
            self._detect_idle(audit, ticks, now, scene)
            self._detect_wedge(audit, ticks, now, scene)
        self._detect_code(b, now)
        self._rate(ticks, audit, now)
        self._write_open(now)
        out["opened"] = [self.open[i] for i in self.open if i not in before_open]
        out["escalated"] = [self.open[i] for i in self.open if i in before_sev and before_sev[i] != self.open[i]["sev"]]
        out["resolved"] = [inc for inc in self.closed[-20:] if inc.get("t_close", 0) >= now - 0.5]
        out["alerts"], self.alert_q = self.alert_q, []
        self.last_poll = now
        return out

    def _new_run(self, run, now):
        for inc in list(self.open.values()):
            self._resolve(inc, "run-ended", now)
        self.run = run
        self.streak = None
        self.streaks = []
        self.loop_hist = []
        self.last_ev_t = 0.0

    # ------------------------------------------------------------------ feed / process health
    def _feed(self, b, now):
        age_t, age_a = b.get("ticks_age"), b.get("audit_age")
        dead = (age_t is None or age_t > self.cfg["feed_dead_s"]) and (age_a is None or age_a > self.cfg["feed_dead_s"])
        inc = self._find_open("feed")
        if dead:
            if inc is None:
                running = b.get("game_running")
                detail = ("game process is running but telemetry stopped (frozen game? plugin crashed?)" if running
                          else "game process is not running" if running is False else "telemetry stopped")
                inc = self._open("feed", "crit", now, detail=detail, scene=None, dur_s=0)
            inc["dur_s"] = round(max(age_t or 0, age_a or 0), 1)
            inc["t_last"] = round(now, 1)
        elif inc is not None:
            self._resolve(inc, "feed-back", now)

    # ------------------------------------------------------------------ events -> pins
    def _pos_at(self, ticks, t):
        if not ticks:
            return None
        best = min(ticks, key=lambda r: abs(r.get("t", 0) - t))
        p = best.get("pos")
        return [float(p[0]), float(p[1])] if p and len(p) >= 2 else None

    def _ingest_events(self, events, ticks, now, scene):
        pend_what = None
        for e in events:
            t = float(e.get("t", 0) or 0)
            if t <= self.last_ev_t - 0.0005:
                continue
            note = str(e.get("note", ""))
            if note == "pin-type":
                pend_what = e.get("what")
                continue
            if STRIKE_RE.match(note):
                pos = self._pos_at(ticks, t)
                what = pend_what
                pend_what = None
                self._add_pin(t, note, pos, what)
            if note.split(":")[0] in LOOP_NOTES:
                tgt = None
                if ticks:
                    near = min(ticks, key=lambda r: abs(r.get("t", 0) - t))
                    tgt = near.get("bn")
                self.loop_hist.append((t, note.split(":")[0], tgt))
            self.last_ev_t = max(self.last_ev_t, t)
        self.loop_hist = self.loop_hist[-120:]

    def _add_pin(self, t, note, pos, what):
        c = self.cfg
        s = self.streak
        if s is not None and t - s["last_t"] > c["streak_gap_s"]:
            self._close_streak(s)
            s = self.streak = None
        if s is None:
            s = self.streak = {"first_t": t, "last_t": t, "pins": [], "closed": False}
        s["last_t"] = max(s["last_t"], t)
        s["pins"].append((t, note, pos, what))

    def _close_streak(self, s):
        if s.get("closed") or not s["pins"]:
            return
        s["closed"] = True
        ps = [p[2] for p in s["pins"] if p[2]]
        centre = [sum(p[0] for p in ps) / len(ps), sum(p[1] for p in ps) / len(ps)] if ps else None
        whats = [p[3] for p in s["pins"] if p[3]]
        top = max(set(whats), key=whats.count) if whats else None
        dur = (s["last_t"] - s["first_t"]) + self.cfg["first_strike_s"]
        self.streaks.append({"t_end": s["last_t"], "centre": centre, "dur": dur, "pins": len(s["pins"]), "what": top})
        self.streaks = [x for x in self.streaks if s["last_t"] - x["t_end"] <= self.cfg["hotspot_window_s"] * 2][-60:]

    # ------------------------------------------------------------------ detectors
    def _stuck_view(self, s):
        ps = [p[2] for p in s["pins"] if p[2]]
        centre = [sum(p[0] for p in ps) / len(ps), sum(p[1] for p in ps) / len(ps)] if ps else None
        spread = max((_dist(p, centre) for p in ps), default=0.0) if centre else 0.0
        whats = [p[3] for p in s["pins"] if p[3]]
        top = max(set(whats), key=whats.count) if whats else None
        dur = (s["last_t"] - s["first_t"]) + self.cfg["first_strike_s"]
        return centre, spread, top, dur

    def _detect_stuck(self, ticks, now, scene):
        c = self.cfg
        t_now = ticks[-1].get("t", 0) if ticks else 0
        s = self.streak
        inc = self._find_open("stuck")
        if s is not None:
            quiet = t_now - s["last_t"]
            centre, spread, top, dur = self._stuck_view(s)
            if quiet > c["streak_gap_s"]:
                self._close_streak(s)
                self.streak = None
                if inc is not None and quiet >= c["resolve_quiet_s"]:
                    inc["dur_s"] = round(dur, 1)
                    self._resolve(inc, "moved-on", now)
                return
            if dur >= c["stuck_warn_s"]:
                obstacle = classify_obstacle(top)
                last_mode = ticks[-1].get("mode") if ticks else None
                if inc is not None and centre and inc.get("pos") and _dist(inc["pos"], centre) > c["new_spot_m"]:
                    self._resolve(inc, "moved-on", now)            # got free, walked off, got pinned somewhere else
                    inc = None
                if inc is None:
                    inc = self._open("stuck", "crit" if dur >= c["stuck_crit_s"] else "warn", now, pos=centre, scene=scene, mode=last_mode,
                                     obstacle=obstacle, dur_s=round(dur, 1), count=len(s["pins"]), spread_m=round(spread, 1),
                                     target=(ticks[-1].get("bn") if ticks else None),
                                     detail="pinned %.0fs on %s (%s) at (%.0f, %.0f)" % (dur, obstacle["class"], obstacle["name"], *(centre or (0, 0))))
                else:
                    inc.update(dur_s=round(dur, 1), count=len(s["pins"]), pos=centre, obstacle=obstacle, spread_m=round(spread, 1), t_last=round(now, 1), mode=last_mode)
                    if dur >= c["stuck_crit_s"] and inc["sev"] == "warn":
                        self._escalate(inc, "crit", "pinned %.0fs" % dur)
                    elif inc["sev"] == "crit" and now - inc.get("t_alert", 0) >= c["min_realert_s"] and not inc.get("acked"):
                        self._queue_alert(inc, "still stuck after %.0fs" % dur)
        elif inc is not None:
            # streak object gone (closed in a previous poll) but the incident is still open: resolve after the quiet time
            last = inc.get("t_last", now)
            if now - last >= c["resolve_quiet_s"]:
                self._resolve(inc, "moved-on", now)

    def _detect_hotspot(self, now, t_now, scene):
        """HOTSPOT = the same spot pinned on repeated VISITS (separate streaks), not one long streak (that is the STUCK incident)."""
        c = self.cfg
        allst = list(self.streaks)
        if self.streak is not None and self.streak["pins"]:
            centre, spread, top, dur = self._stuck_view(self.streak)
            allst.append({"t_end": self.streak["last_t"], "centre": centre, "dur": dur, "pins": len(self.streak["pins"]), "what": top})
        allst = [x for x in allst if x["centre"]]
        if allst:
            newest = max(allst, key=lambda x: x["t_end"])
            near = [x for x in allst if _dist(x["centre"], newest["centre"]) <= c["hotspot_radius_m"] and newest["t_end"] - x["t_end"] <= c["hotspot_window_s"]]
            visits = len(near)
            pins = sum(x["pins"] for x in near)
            wasted = sum(x["dur"] for x in near)
            whats = [x["what"] for x in near if x["what"]]
            top = max(set(whats), key=whats.count) if whats else None
            hit = visits >= c["hotspot_min_streaks"] or (visits >= 2 and pins >= c["hotspot_min_pins"])
            if hit and t_now - newest["t_end"] <= c["hotspot_quiet_s"]:        # only while the spot is still being pinned
                centre = [sum(x["centre"][0] for x in near) / visits, sum(x["centre"][1] for x in near) / visits]
                obstacle = classify_obstacle(top)
                inc = self._find_open("hotspot", centre, c["hotspot_radius_m"] * 1.5)
                if inc is None:
                    self._open("hotspot", "crit", now, pos=centre, scene=scene, obstacle=obstacle, count=visits, pins=pins, wasted_s=round(wasted, 1), dur_s=round(wasted, 1),
                               detail="pinned %d times (%d strikes, ~%.0fs lost) within %.0f m of (%.0f, %.0f) on %s %s" %
                                      (visits, pins, wasted, c["hotspot_radius_m"], centre[0], centre[1], obstacle["class"], obstacle["name"]))
                else:
                    inc.update(count=visits, pins=pins, wasted_s=round(wasted, 1), dur_s=round(wasted, 1), pos=centre, obstacle=obstacle, t_last=round(now, 1))
                    if now - inc.get("t_alert", 0) >= c["min_realert_s"] * 2 and not inc.get("acked"):
                        self._queue_alert(inc, "hotspot persists: %d visits, %d strikes, ~%.0fs lost" % (visits, pins, wasted))
        for h in list(self.open.values()):                     # an open hotspot closes when nothing near it has been pinned for a while
            if h["kind"] != "hotspot":
                continue
            last = max([x["t_end"] for x in allst if _dist(x["centre"], h["pos"]) <= c["hotspot_radius_m"] * 1.5] or [0])
            if t_now - last >= c["hotspot_quiet_s"]:
                self._resolve(h, "quiet", now)

    def _detect_loop(self, events, ticks, now, scene):
        c = self.cfg
        t_now = ticks[-1].get("t", 0) if ticks else 0
        recent = [h for h in self.loop_hist if t_now - h[0] <= c["loop_window_s"]]
        by_tgt = {}
        for t, note, tgt in recent:
            by_tgt.setdefault(tgt or "?", []).append((t, note))
        worst = max(by_tgt.items(), key=lambda kv: len(kv[1]), default=None)
        inc = self._find_open("loop")
        if worst and len(worst[1]) >= c["loop_min"]:
            tgt, hits = worst
            kinds = sorted({n for _, n in hits})
            detail = "%s abandoned/retried %d times in %.0fs (%s)" % (tgt, len(hits), c["loop_window_s"], ", ".join(kinds))
            if inc is None:
                self._open("loop", "warn", now, scene=scene, target=tgt, count=len(hits), detail=detail, dur_s=round(hits[-1][0] - hits[0][0], 1))
            else:
                inc.update(target=tgt, count=len(hits), detail=detail, t_last=round(now, 1))
        elif inc is not None and not recent:
            self._resolve(inc, "quiet", now)

    def _detect_idle(self, audit, ticks, now, scene):
        c = self.cfg
        since = audit.get("since_prog")
        gold = audit.get("gold") or 0
        mode = audit.get("mode")
        inc = self._find_open("idle")
        cond = (since is not None and since >= c["idle_warn_s"] and gold >= c["idle_gold_min"] and not audit.get("night")
                and mode in ("SpendGold", "Idle", "HoldCastle"))
        if cond:
            sev = "crit" if since >= c["idle_crit_s"] else "warn"
            detail = "no progress for %.0fs with %d gold waiting (mode %s, drain: %s, %s slots blocked)" % (since, gold, mode, audit.get("eff_drain"), audit.get("bld_blocked"))
            if inc is None:
                self._open("idle", sev, now, scene=scene, mode=mode, dur_s=round(since, 1), detail=detail, gold=gold, target=audit.get("cur_build"))
            else:
                inc.update(dur_s=round(since, 1), detail=detail, gold=gold, t_last=round(now, 1))
                if sev == "crit" and inc["sev"] == "warn":
                    self._escalate(inc, "crit", "idle %.0fs" % since)
                elif inc["sev"] == "crit" and now - inc.get("t_alert", 0) >= c["min_realert_s"] * 2 and not inc.get("acked"):
                    self._queue_alert(inc, "still idle after %.0fs" % since)
        elif inc is not None and (since is None or since < c["idle_warn_s"] * 0.5 or gold < c["idle_gold_min"]):
            self._resolve(inc, "progress", now)

    def _detect_wedge(self, audit, ticks, now, scene):
        c = self.cfg
        frame = audit.get("frame") or ""
        state = ticks[-1].get("state") if ticks else None
        bad = bool(frame) or (state not in (None, "InMatch"))
        key = ("frame:" + frame) if frame else ("state:" + str(state))
        if bad:
            if getattr(self, "_wedge_key", None) != key:
                self._wedge_key, self._wedge_since = key, now
            dur = now - self._wedge_since
            inc = self._find_open("wedge")
            if dur >= c["wedge_s"]:
                if inc is None:
                    self._open("wedge", "warn", now, scene=scene, dur_s=round(dur, 1), detail="%s for %.0fs" % (key, dur))
                else:
                    inc.update(dur_s=round(dur, 1), t_last=round(now, 1))
                    if dur >= c["wedge_s"] * 4 and inc["sev"] == "warn":
                        self._escalate(inc, "crit", "wedged %.0fs" % dur)
        else:
            self._wedge_key = None
            inc = self._find_open("wedge")
            if inc is not None:
                self._resolve(inc, "cleared", now)

    def _detect_code(self, b, now):
        c = self.cfg
        lines = b.get("gamelog_new") or []
        hits = [l for l in lines if "Exception" in l or "[Error" in l or "NullReference" in l]
        self._code_hist = [(t, l) for t, l in getattr(self, "_code_hist", []) if now - t <= c["code_window_s"]] + [(now, l) for l in hits]
        inc = self._find_open("code")
        if len(self._code_hist) >= c["code_min"]:
            msgs = [l[:160] for _, l in self._code_hist]
            top = max(set(msgs), key=msgs.count)
            detail = "%d exception lines in %.0fs; most frequent: %s" % (len(self._code_hist), c["code_window_s"], top)
            if inc is None:
                self._open("code", "warn", now, detail=detail, count=len(self._code_hist), excerpt=top)
            else:
                inc.update(detail=detail, count=len(self._code_hist), excerpt=top, t_last=round(now, 1))
        elif inc is not None and not self._code_hist:
            self._resolve(inc, "quiet", now)

    # ------------------------------------------------------------------ ratings (the idle / stuck scoreboard)
    def _rate(self, ticks, audit, now):
        r = {}
        if ticks:
            t_end = ticks[-1].get("t", 0)
            win = [x for x in ticks if t_end - x.get("t", 0) <= 60 and x.get("pos")]
            speeds, intent_still = [], 0
            for a, b2 in zip(win, win[1:]):
                dt = b2["t"] - a["t"]
                if dt <= 0:
                    continue
                d = _dist(a["pos"], b2["pos"])
                speeds.append(d / dt)
                ta = b2.get("ta")
                wants = bool(ta) and len(ta) >= 2 and _dist(b2["pos"], ta) > 3.0 and b2.get("mode") not in ("HoldCastle",) and not b2.get("busy")
                if wants and d / dt < 0.15:
                    intent_still += 1
            if speeds:
                r["speed_mps"] = round(sum(speeds[-10:]) / len(speeds[-10:]), 2)
                r["moving_pct_60s"] = round(100.0 * sum(1 for v in speeds if v >= 0.3) / len(speeds))
                r["still_with_goal_pct_60s"] = round(100.0 * intent_still / len(speeds))
        stuck_s = 0.0
        for inc in self.open.values():
            if inc["kind"] in ("stuck", "hotspot"):
                stuck_s = max(stuck_s, inc.get("dur_s") or 0)
        r["stuck_s_now"] = round(stuck_s, 1)
        r["since_prog_s"] = audit.get("since_prog")
        r["useful_pct"] = audit.get("useful_pct")
        r["waste_s"] = audit.get("waste_s")
        r["open"] = len(self.open)
        r["crit"] = sum(1 for i in self.open.values() if i["sev"] == "crit")
        recent_cut = now - 300
        lost = sum(x["dur"] for x in self.streaks)
        r["stuck_lost_s_recent"] = round(lost, 1)
        score = 100.0
        score -= min(40.0, r.get("still_with_goal_pct_60s", 0) * 0.6)
        score -= min(25.0, stuck_s * 1.2)
        score -= 15.0 * r["crit"]
        score -= 5.0 * (r["open"] - r["crit"])
        if r.get("useful_pct") is not None:
            score -= max(0.0, (60 - r["useful_pct"])) * 0.3
        r["health"] = int(max(0, min(100, round(score))))
        r["grade"] = "A" if r["health"] >= 90 else "B" if r["health"] >= 75 else "C" if r["health"] >= 55 else "D" if r["health"] >= 35 else "F"
        self.ratings = r

    # ------------------------------------------------------------------ outputs
    def _write_open(self, now):
        snap = {"t": round(now, 1), "run": self.run, "open": sorted(self.open.values(), key=lambda i: ({"crit": 0, "warn": 1, "info": 2}[i["sev"]], -i["t_open"])),
                "counters": self.counters, "ratings": self.ratings, "recent": [self._brief(i) for i in self.closed[-12:]][::-1]}
        self.src.write_open(snap)

    @staticmethod
    def _brief(i):
        return {k: i.get(k) for k in ("id", "kind", "sev", "t_open", "t_close", "dur_s", "pos", "obstacle", "resolved_by", "detail", "actions")}

    def open_list(self):
        return list(self.open.values())

    def recent(self, n=50):
        return self.src.read_log(n)

    def pulse(self):
        return {"t": round(self.clock(), 1), "ratings": self.ratings, "open": len(self.open), "counters": self.counters, "run": self.run}

    def get(self, inc_id):
        return self.open.get(inc_id) or next((i for i in self.closed if i["id"] == inc_id), None)

    def ack(self, inc_id, by, note=""):
        inc = self.get(inc_id)
        if inc is None:
            return False
        inc["acked"] = {"by": by, "note": note[:200], "t": round(self.clock(), 1)}
        self._emit("ack", inc, by=by, note=note[:200])
        return True

    def record_action(self, inc_id, actor, action, result):
        inc = self.get(inc_id)
        if inc is None:
            return False
        entry = {"t": round(self.clock(), 1), "by": actor, "action": action, "result": result}
        inc["actions"].append(entry)
        self._emit("action", inc, **entry)
        return True


# ---------------------------------------------------------------------------------------------------------------- sources
class FsSource:
    """Reads the real agent dir. Everything is tail-based and cheap enough for a 1 Hz poll."""

    def __init__(self, agent_dir, game_log=None, game_exe="thronefall.exe"):
        self.dir = agent_dir
        self.game_log = (game_log or os.environ.get("THRONEFALL_GAMELOG")
                         or os.path.join(os.path.dirname(os.path.dirname(agent_dir.rstrip("\\/"))), "LogOutput.log"))
        self.game_exe = game_exe
        self._ev_off = {}
        self._log_off = None
        self._proc_t, self._proc = 0.0, None
        os.makedirs(os.path.join(self.dir, "incidents"), exist_ok=True)

    def _p(self, name):
        return os.path.join(self.dir, name)

    @staticmethod
    def _tail(path, cap):
        try:
            sz = os.path.getsize(path)
            with open(path, "rb") as f:
                f.seek(max(0, sz - cap))
                return f.read().decode("utf-8", "replace")
        except OSError:
            return ""

    def latest_run(self):
        try:
            runs = [os.path.join(self.dir, "runs", d) for d in os.listdir(os.path.join(self.dir, "runs"))]
            return max(runs, key=os.path.getmtime) if runs else None
        except OSError:
            return None

    def game_running(self):
        if time.time() - self._proc_t < 8 and self._proc is not None:
            return self._proc
        self._proc_t = time.time()
        try:
            import subprocess
            out = subprocess.run(["tasklist", "/FI", "IMAGENAME eq " + self.game_exe, "/FO", "CSV", "/NH"], capture_output=True, text=True, timeout=5).stdout
            self._proc = self.game_exe.lower() in out.lower()
        except Exception:
            self._proc = None
        return self._proc

    def read(self):
        now = time.time()
        run = self.latest_run()
        b = {"run": os.path.basename(run) if run else None, "live": False, "ticks": [], "events": [], "audit": {}, "gamelog_new": []}
        ap = self._p("audit.json")
        try:
            b["audit_age"] = now - os.path.getmtime(ap)
            b["audit"] = json.load(open(ap, encoding="utf-8", errors="replace"))
        except Exception:
            b["audit_age"] = None
        if run:
            tp = os.path.join(run, "ticks.jsonl")
            try:
                b["ticks_age"] = now - os.path.getmtime(tp)
            except OSError:
                b["ticks_age"] = None
            b["live"] = b.get("ticks_age") is not None and b["ticks_age"] < 30
            for ln in self._tail(tp, 60000).splitlines()[-160:]:
                if ln.startswith("{"):
                    try:
                        b["ticks"].append(json.loads(ln))
                    except Exception:
                        pass
            b["events"] = self._new_events(os.path.join(run, "events.jsonl"))
        else:
            b["ticks_age"] = None
        b["game_running"] = self.game_running() if (b.get("ticks_age") is None or b["ticks_age"] > 8) else True
        b["gamelog_new"] = self._new_log_lines()
        return b

    def _new_events(self, path):
        try:
            size = os.path.getsize(path)
        except OSError:
            return []
        off = self._ev_off.get(path)
        if off is None or off > size:
            off = max(0, size - 60000)          # first sight of this file: look at the recent tail only
        out = []
        with open(path, "rb") as f:
            f.seek(off)
            data = f.read()
        nl = data.rfind(b"\n")
        if nl < 0:
            return []
        self._ev_off[path] = off + nl + 1
        for ln in data[:nl].decode("utf-8", "replace").splitlines():
            if ln.startswith("{"):
                try:
                    out.append(json.loads(ln))
                except Exception:
                    pass
        return out

    def _new_log_lines(self):
        try:
            size = os.path.getsize(self.game_log)
        except OSError:
            return []
        if self._log_off is None or self._log_off > size:
            self._log_off = size
            return []
        with open(self.game_log, "rb") as f:
            f.seek(self._log_off)
            data = f.read(400000)
        self._log_off += len(data)
        return data.decode("utf-8", "replace").splitlines()

    # ---- persistence
    def load_seq(self):
        try:
            return int(json.load(open(self._p("incidents-seq.json")))["seq"])
        except Exception:
            return 0

    def save_seq(self, n):
        self._atomic("incidents-seq.json", {"seq": n})

    def _atomic(self, name, obj):
        tmp = self._p(name) + ".tmp"
        try:
            with open(tmp, "w", encoding="utf-8") as f:
                json.dump(obj, f)
            os.replace(tmp, self._p(name))
        except OSError:
            pass

    def write_open(self, snap):
        self._atomic("incidents-open.json", snap)

    def log(self, rec):
        try:
            lp = self._p("incidents.jsonl")
            if os.path.exists(lp) and os.path.getsize(lp) > 6_000_000:
                os.replace(lp, lp + ".old")
            with open(lp, "a", encoding="utf-8") as f:
                f.write(json.dumps(rec) + "\n")
        except OSError:
            pass

    def read_log(self, n):
        out = []
        for ln in self._tail(self._p("incidents.jsonl"), 400000).splitlines()[-n:]:
            try:
                out.append(json.loads(ln))
            except Exception:
                pass
        return out

    def snapshot_frame(self, inc_id, cap):
        try:
            import shutil
            src = self._p("live.jpg")
            if os.path.exists(src):
                d = os.path.join(self.dir, "incidents")
                shutil.copyfile(src, os.path.join(d, inc_id + ".jpg"))
                files = sorted((os.path.join(d, f) for f in os.listdir(d) if f.endswith(".jpg")), key=os.path.getmtime)
                for old in files[:-cap]:
                    os.remove(old)
        except OSError:
            pass


class MemSource:
    """In-memory source for tests: feed it bundles with .push(bundle)."""

    def __init__(self):
        self.bundle = {"run": "r1", "live": True, "ticks": [], "events": [], "audit": {}, "ticks_age": 0.5, "audit_age": 0.5, "game_running": True, "gamelog_new": []}
        self.logs, self.opens, self.seq, self.frames = [], None, 0, []

    def read(self):
        b = dict(self.bundle)
        self.bundle = dict(self.bundle, events=[], gamelog_new=[])      # events/log lines are delivered once
        return b

    def load_seq(self):
        return self.seq

    def save_seq(self, n):
        self.seq = n

    def write_open(self, snap):
        self.opens = snap

    def log(self, rec):
        self.logs.append(rec)

    def read_log(self, n):
        return self.logs[-n:]

    def snapshot_frame(self, inc_id, cap):
        self.frames.append(inc_id)
