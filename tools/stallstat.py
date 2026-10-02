"""Small pure helpers for the game's stall log (agent/perf-stalls.jsonl), shared by livecap.py (HUD), perf-watch.py (CLI) and the tests. No I/O, no dependencies."""
import bisect
import math


def real_events(rows):
    """Collapse the stall log into REAL stalls, one per stall. FramePerf pairs Unity's `Time.unscaledDeltaTime` with the wrong frame (it arrives one frame late), so one
    stall of frame N is logged twice: the real line (`wall_ms` long = the plugin's own clock, `plugin_ms` = what our sections spent, `frame_ms` still the old ~17 ms) and an
    echo one frame later (`frame_ms` long, `wall_ms` a normal frame, `plugin_ms` ~0, so its cause reads "engine"). Counting both double-counts the time and labels our own
    stalls as the engine's. An echo = a line whose wall clock is short while Unity's delta is long, right after (< 0.6 s) a line whose wall clock was long (>= 80 ms; two
    stalls in consecutive frames work out the same way). A long-delta line with NO such predecessor is kept (Unity's delta is its length): the real frame was under the
    100 ms logging threshold, so its cause is unknown. Rows without `wall_ms` (older logs) are taken as they are. Returns [{t, ms, cause, top, top_ms, lone_delta}], oldest first."""
    out, prev = [], None
    for r in sorted(rows, key=lambda r: r.get("t", 0.0)):
        t = float(r.get("t", 0.0))
        frame = float(r.get("frame_ms", 0.0))
        wall = float(r["wall_ms"]) if r.get("wall_ms") is not None else frame
        echo = bool(prev and wall < 0.5 * frame and t - prev[0] < 0.6 and prev[1] >= 80.0)
        prev = (t, wall)
        if echo:
            continue
        lone = wall < 0.5 * frame
        out.append({"t": t, "ms": frame if lone else wall, "cause": r.get("cause") if not lone else "engine", "top": r.get("top"), "top_ms": float(r.get("top_ms", 0.0)), "lone_delta": lone})
    return out


def shares(events):
    """Shares of the stalled time: by cause (plugin / mixed / engine) and, for the stalls our measured sections caused, by section. {n, stalled_ms, plugin, mixed, engine, sections}."""
    tot = sum(e["ms"] for e in events)
    by = {"plugin": 0.0, "mixed": 0.0, "engine": 0.0}
    sec = {}
    for e in events:
        c = e["cause"] if e["cause"] in by else "mixed"
        by[c] += e["ms"]
        if c in ("plugin", "mixed") and e.get("top"):
            sec[e["top"]] = sec.get(e["top"], 0.0) + e["ms"]
    res = {"n": len(events), "stalled_ms": round(tot)}
    if tot:
        res.update({k: round(v / tot, 3) for k, v in by.items()})
        res["sections"] = {k: round(v / tot, 3) for k, v in sorted(sec.items(), key=lambda kv: -kv[1])}
    return res


def find_period(times, lo=0.9, hi=130.0, min_hits=4, min_share=0.25, tol=0.35):
    """Do the events recur at one fixed interval, however many unrelated events are mixed in? A candidate period v is scored by its SUPPORT: the number of events that have
    another event v (+-0.35 s) after them. That survives a phase reset (a timer re-armed by a reconnect), a missed cycle, and dense noise - unrelated events almost never repeat
    at exactly v, so they add to the total but not to the support. Candidates are the most common differences between ANY two events (0.25 s bins, >= `lo`: shorter ones are
    bursts of one stall); among the candidates whose support is within 20% of the best, the shortest period wins (a 30 s timer also repeats at 60 s). The support must be at
    least `min_hits` events and `min_share` of all events. Returns (period_s, support, events-that-could-repeat) or None."""
    ts = sorted(times)[-600:]                                           # the most recent 600 events are plenty (and bound the work)
    n = len(ts)
    if n < min_hits + 1:
        return None
    diffs = {}
    for i in range(n):
        for j in range(i + 1, n):
            d = ts[j] - ts[i]
            if d > hi:
                break
            if d >= lo:
                diffs.setdefault(round(d * 4), []).append(d)
    cands = sorted(diffs.items(), key=lambda kv: -len(kv[1]))[:16]
    best = []
    for _, ds in cands:
        v = sum(ds) / len(ds)
        sup, spacing = 0, []
        for t in ts:
            k = bisect.bisect_left(ts, t + v - tol)                     # the first event at or after t + v - tol: is it within the window?
            if k < n and ts[k] <= t + v + tol:
                sup += 1
                spacing.append(ts[k] - t)
        if spacing:
            spacing.sort()
            best.append((sup, spacing[len(spacing) // 2]))              # the period is what the repeats really measure (their median), not the bin's centre
    # chance: with event density `lam` per second a random event has another one inside the +-tol window with probability p0, so a candidate needs a support well above
    # p0 * (n - 1) (5 standard deviations) - with an event every second half of all events "repeat" by luck at any period
    lam = n / max(1.0, ts[-1] - ts[0])
    p0 = 1.0 - math.exp(-2.0 * tol * lam)
    chance = p0 * (n - 1) + 5.0 * math.sqrt(max(0.0, (n - 1) * p0 * (1.0 - p0)))
    ok = [(s, v) for s, v in best if s >= min_hits and s >= min_share * (n - 1) and s > chance]
    if not ok:
        return None
    top = max(s for s, _ in ok)
    sup, v = min(((s, v) for s, v in ok if s >= 0.8 * top), key=lambda sv: sv[1])
    return round(v, 1), sup, n - 1
