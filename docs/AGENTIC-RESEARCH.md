# Agentic Thronefall bot — research brief (bibliography)

> Kept as the reading list and pattern reference. **The design of record is `AGENTIC-DESIGN.md` (v3).** Where this brief and the design disagree (MiniMax as the brain, brain on the choice path, week-3 harness, free-text lessons, VPS), the design wins; `AUDIT-LOG.md` records why.

---


Educational / single-player only. This sits on top of the existing BepInEx + Harmony bot.
It does **not** replace `Bot.cs`. It does **not** train weights on the 3090 as the first step.

---

## 0. Straight answers

**Can this project be extremely agentic?**  
Yes — *strategically*. Not at 60 FPS motor control.

**How agentic can it get in 2026 without exploding complexity?**  
The working SOTA pattern for a game that already exposes object state is:

```
fast body  = your current FSM + A* + TagManager snapshot   (4 Hz, local, free)
slow brain = MiniMax M3 (vision+tools+1M ctx)              (every 5–30 s or on events)
memory     = markdown files + jsonl + playbook store       (no fine-tune)
learning   = Reflexion + Voyager skill library             (code/text, not weights)
optional camera = screenshot only when the snapshot is incomplete
                  (blocking UI, unknown frame, debug)
```

That is the same split used by Unity “AI Commander” writeups, Claude-Plays-Pokemon (screenshot **plus** memory readout), Voyager (API skills, not pixels), and Cradle’s six modules — minus Cradle’s “pixels-only” constraint, which you do not need.

**Should you train a SIMA-like VLA on the 3090?**  
No. SIMA 2 is a Gemini-finetuned vision-language-action model trained on many commercial 3D games. You cannot reproduce that. A 3090 Ti is excellent for a local coder (Cat Coder) and a small captioner. MiniMax M3 is ~428B MoE; that stays on the API.

**Do you need Hugging Face weights?**  
Not to start. Weights matter later if you want a *tiny local* policy (PPO on a vector of snapshot floats) or a local VLM captioner. The intelligence jump for *this* game is in the harness, not in swapping Cat Coder for Qwen.

---

## 1. What “aware” actually means here

Your bot is already more “aware” than a raw camera agent:

| Sense | You have today | Camera-only agent has |
|---|---|---|
| Hero HP, gold, cores, pos | exact floats | guessed from pixels |
| Every enemy + castle threat | `TagManager` lists | bounding boxes, often late |
| Build slots + costs | `BuildingInteractor` | OCR + guess |
| Wave index, day/night | singletons | HUD reading |
| Navmesh | A* Pathfinding Project | walk-into-wall |
| Blocking UI | `UIFrame` / `ChoiceManager` | “what is this popup?” |

Papers and Pokemon harnesses keep rediscovering the same fact: **privileged state + a screenshot beats screenshot alone**. Paradigm 3’s 2026 Pokemon eval still feeds map name, coordinates, and walkable tiles from emulator memory alongside the frame.

So “add a camera” is a **verifier and a UI reader**, not a replacement for `BotPerception.Snapshot`.

---

## 2. Research map (the patterns that matter)

### 2.1 Surveys (read first)

- Hu et al., *A Survey on Large Language Model-Based Game Agents* (arXiv:2404.02039, updated 2026). Unified split: **memory / reasoning / perception–action**. Paper list: https://github.com/git-disl/awesome-LLM-game-agent-papers
- https://github.com/gameworld-project/awesome-game-agent-papers — multimodal + embodied track including SIMA 2 (2025-12)

Takeaway they both repeat: games differ. Action games need a fast controller. Strategy / kingdom defense needs a slow planner. Thronefall is the second.

### 2.2 Code-as-skill, lifelong learning (closest to “evolving bot”)

- **Voyager** (Wang et al., 2023) https://github.com/MineDojo/Voyager · arXiv:2305.16291  
  Curriculum agent + action agent (writes code) + critic + **skill library in a vector DB**. No weight updates. Skills are programs against Mineflayer.
- **VoyagerVision** (2025) arXiv:2507.00079 — same loop, vision added as extra observation, API still does the acting.
- **AgentPitch** (2026) https://github.com/gangtao/AgentPitch  
  LLM writes `decide(state)` code → sandbox → match → post-match evolution from the log. This is the cleanest modern clone of Voyager for a sports sim.
- **LLM-Game-Playing-Agents** (ICML 2025 PRAL / 2026 follow-up) https://github.com/ameliakuang/LLM-Game-Playing-Agents  
  LLM *optimizes Python policies* on **object-centric** Atari (OC_Atari), not pixels. Same philosophy as your Snapshot.

Map onto Thronefall: MiniMax / Cat Coder writes or patches **scoring functions and playbook snippets**. The FSM remains the runtime. Failed nights become critic notes. Successful nights become skills (`nordfels-walls-before-wave-2`).

### 2.3 Pixels-in, keys-out (do not start here)

- **Cradle** (Tan et al., ICML 2025) https://github.com/BAAI-Agents/Cradle · arXiv:2403.03186  
  Six modules: Information Gathering, Self-Reflection, Task Inference, Skill Curation, Action Planning, Memory. Screenshot → keyboard/mouse. Played RDR2, Stardew, Cities: Skylines. Heavy, slow, no game API.
- **SIMA / SIMA 2** (DeepMind 2024 / 2025) — generalist VLA, Gemini backbone in v2. Not reproducible on a 3090. Interface is pixels + language → keyboard.
- **GamingAgent / LMGame** https://github.com/lmgame-org/GamingAgent — computer-use agents for 2048, Mario, Ace Attorney. Vision + short/long memory workers.
- **llmplaysadventuregames** https://github.com/luishg/llmplaysadventuregames — screenshot, grid clicks, context refresh every 10 steps.

Use these as *module names* and as a fallback when a UI frame has no Harmony handle. Do not drive night combat this way.

### 2.4 Hybrid harness (the 2025–2026 winner for real-time games)

- **Claude Plays Pokemon** starter https://github.com/davidhershey/ClaudePlaysPokemonStarter  
  Loop: screenshot + **memory readout** → LLM tools → buttons. Later harness notes (Opus 4.x): one memory file the model edits; crop/recall image tools; they *removed* “you are stuck” nags so the model has to notice itself.
- Paradigm 3 Pokemon Brown eval (Sep 2026) https://paradigm3.org/research/pokemon/ — same hybrid; vision-only is not what the leaderboard uses.
- Hugging Face, *Building a Game AI Commander* (2025) — Unity FSM “muscles”, DeepSeek snapshot every few seconds as “brain”. Latency and cost are why they refused per-frame LLM.
- StarSkirmish Bench (Sep 2026) — LLMs write StarCraft bots in C++, then read transcripts. Learning is **code iteration**, not mid-game tokens.

Your project is already the Commander pattern. The missing piece is the brain sidecar + a skill/memory store.

### 2.5 Memory (do not fine-tune first)

- **MemGPT / Letta** https://github.com/letta-ai/letta · arXiv:2310.08560  
  Core memory (always in context) + archival (search) + tools that *edit* memory. 2026 Letta also has MemFS: git-backed markdown.
- Claude Plays Pokemon memory file (single always-on markdown, model uses `string_replace`).
- **Reflexion** (Shinn et al., NeurIPS 2023) https://github.com/noahshinn/reflexion · arXiv:2303.11366  
  After a failure, write a verbal lesson. Inject it next episode. No gradients.
- Generative Agents (Park et al., 2023) — observation → reflection → retrieval. Overkill as a full sim, useful as “write a paragraph at dusk.”

For Thronefall, four files beat a vector DB on day one:

```
memory/
  core.md           always in the MiniMax prompt (persona + rules + current goal)
  playbooks.md      per-scene lessons (Nordfels walls, horn missing, …)
  reflections.jsonl one lesson per match end
  skills/           generated scoring snippets + tests
```

Purge automatically: keep last 8 ticks of raw snapshot in the prompt; collapse the rest to the existing `note` stream + D2 per-run summary. That *is* snapshot purging.

### 2.6 Object-centric perception (you already built this)

- OC_Atari https://github.com/k4ntz/OC_Atari — RAM objects instead of pixels.
- OCALM — LLM writes reward functions from those objects.

`BotPerception.Snapshot` is OC_Atari for Thronefall. Guard it. Vision is the backup RAM.

---

## 3. Hardware / model placement

| Job | Where | Why |
|---|---|---|
| 4 Hz Decide + A* + Harmony | Windows 11 + game + BepInEx | must be in-process |
| MiniMax M3 strategy / vision / reflexion | MiniMax API (Ultra tokens) | multimodal, 1M ctx, computer-use, thinking toggle |
| Generate / lint scoring code | local Cat Coder 2.5 Dev Apex on 3090 Ti | fast, already wins your coding bench |
| Tiny VLM caption of a crop (optional) | 3090 Ti | only if API vision is too slow |
| Dashboard + jsonl + playbook git | Hostinger Ubuntu VPS | always on, no GPU needed |
| DeepSeek | spare critic only | quota is tiny |
| Train SIMA / PPO-from-pixels | nowhere in v1 | weeks of env engineering, worse than Snapshot |

MiniMax M3 (May 2026): native image+video, tool use, 1M context, thinking modes. That is the correct brain. Do not self-host 428B.

---

## 4. Target architecture (least complexity)

```
                    ┌─────────────────────────────────┐
                    │  MiniMax M3  (event / 15 s)     │
                    │  tools: propose_weights,        │
                    │         pick_choice,            │
                    │         write_reflection,       │
                    │         request_screenshot      │
                    └──────────────┬──────────────────┘
                                   │ JSON plan
                                   ▼
 Windows game ── Snapshot ── Bot.Decide (FSM) ── DesiredDir
      │                         ▲
      │ screenshot on demand    │ playbook weights
      ▼                         │
  png crop (UI / debug)         memory/*.md
      │
      ▼
  optional local captioner
```

Rules that keep it simple:

1. The FSM always has a legal action even if the API is down (`Decide()` as today).
2. The LLM never writes `inputVector`. It writes **weights, mode hints, and choice IDs**.
3. Screenshots are requested, not streamed. Night combat does not wait on tokens.
4. Learning happens at **match end** (Reflexion + skill commit), not every tick.
5. Cat Coder may patch `skills/*.cs` offline; a human or lint gate merges them. Do not hot-swap unreviewed C# into the live process on day one.

Heartbeat = existing 4 Hz jsonl + a `alive` field on the sidecar. If the sidecar dies, the body keeps playing.

---

## 5. How “camera vision” should work

Three levels, cheapest first:

**L0 — structured snapshot (already done).** This is the real awareness.

**L1 — event screenshot.** When `ResolveUI` sees an unknown `UIFrame`, or `ChoiceManager` has options the scorer cannot name, grab the game window (Win32 PrintWindow / Unity `ScreenCapture.CaptureScreenshot`), downscale to ~768 px on the long side, send to MiniMax M3 with the snapshot JSON. Ask for `{action, choice_index, reason}`. One image per event, then purge the pixels.

**L2 — periodic glance.** Every 20–30 s of day, one frame for “does the keep look walled on the spawn line?” Use it to *audit* scoring, not to steer.

**L3 — video clip (rarely).** 2–3 s around a wipe, sent once at match end for the reflection. M3 accepts video; do not stream it live.

Automatic purge: pixels live in `%TEMP%\tf-agent\` and die after the tool result is written. Only the text description and the decision go into `reflections.jsonl`.

---

## 6. How the bot “learns” without weights

After each match, one MiniMax call with:

- per-run summary (waves, gold curve, stalls, snaps, result)
- last 30 `note`s
- current `playbooks.md` section for that scene

Ask it to append **at most three** lessons, each of the form:

```
IF scene=Nordfels AND wave>=2 AND walls<2 THEN boost wall score +80
```

Store them. Next run, `Decide()` / spend-scorer reads the playbook numbers. That is Voyager’s skill library reduced to a config table — the thing AUTOPILOT already wanted as “wave-aware scoring.”

Cat Coder’s job is the offline loop: “here is BotPerception + a lesson, write a unit-testable scorer patch.” Human or `bot-lint` merges.

This is SOTA-for-a-single-game in 2026. Fine-tuning LoRAs on jsonl is a science project, not a better Nordfels clear.

---

## 7. What *not* to copy

| Tempting | Why it fails here |
|---|---|
| Pixel-only Cradle/SIMA loop | You already have better state; nights are real-time |
| Per-tick MiniMax | 250 ms decide + 2–8 s API = frozen hero |
| Fine-tune Cat Coder on bot-log | Log is not a state-action dataset; you would clone stalls |
| Unity ML-Agents PPO from scratch | Needs a training env you do not have; Snapshot features would still win |
| “Remember everything” raw jsonl in context | 10 MB/hr. Summaries + playbooks scale; raw ticks do not |
| Multi-agent crew of 12 online LLMs | One brain, one critic is enough. Token burn without new senses |
| Letting the LLM call `SetState` / meta unlocks | Breaks legit mode and the lint contract |

---

## 8. Action plan (4 weeks of evenings, not a lab)

### Week 0 — freeze the body
- Keep legit FSM as source of truth.
- Ship D1/D2 from the earlier idea list: suppress `invalid`, write one `match-end` summary object.
- Add a tiny HTTP or named-pipe sidecar stub on Windows that *echoes* the summary. No LLM yet.

### Week 1 — memory files + MiniMax brain (text only)
- `memory/core.md`, `memory/playbooks.md`, `memory/reflections.jsonl`.
- On `match-end` and on `choice-pick` pending, POST snapshot-summary to MiniMax M3 (thinking off for choices, on for reflections).
- Tools the model may call: `set_playbook_weight`, `pick_choice(index)`, `append_reflection`.
- Hard timeout 8 s on choice; fall back to first `CanBePicked`.

### Week 2 — camera as a tool
- One capture helper (game window → png → temp → API → delete).
- Wire `request_screenshot` only from `ResolveUI` unknown-frame and from match-end wipe.
- Prompt: “snapshot is ground truth; image is for unnamed UI and geometry the numbers miss.”

### Week 3 — skill library
- Reflections that fire ≥2 times on the same scene become a playbook rule.
- Cat Coder generates a scoring patch + a small test against a recorded Snapshot JSON.
- `bot-lint` + you merge. No live codegen into the DLL until that gate exists.

### Week 4 — heartbeat + dashboard on the VPS
- Tail jsonl → simple HTML (mode, hp, foes, last lesson).
- Sidecar health. If MiniMax 429s, body continues.

Stop there. That is an agentic, aware, learning Thronefall bot. Everything past that (local VLM, PPO on snapshot vectors, Eternal Trials) is optional polish.

---

## 9. Repos to clone and *read*, not vendor in

Priority order:

1. https://github.com/davidhershey/ClaudePlaysPokemonStarter — harness shape
2. https://github.com/MineDojo/Voyager — skill library + critic (ideas, not Minecraft code)
3. https://github.com/gangtao/AgentPitch — post-match code evolution
4. https://github.com/ameliakuang/LLM-Game-Playing-Agents — LLM-optimizes policies on objects
5. https://github.com/k4ntz/OC_Atari — why objects beat pixels
6. https://github.com/BAAI-Agents/Cradle — module names + screenshot pipeline only
7. https://github.com/letta-ai/letta — memory blocks / MemFS
8. https://github.com/noahshinn/reflexion — match-end lessons
9. https://github.com/lmgame-org/GamingAgent — computer-use workers
10. https://github.com/git-disl/awesome-LLM-game-agent-papers — weekly paper feed
11. https://github.com/LeePresswood/Claude-Plays-Pokemon — vision-first variant (contrast)
12. Unity AI Commander blog — https://huggingface.co/blog/AlexDuo/llm-unity-ai-commander

---

## 10. Honesty about “extreme intelligence”

Thronefall is a small, deterministic kingdom-defense game. An agent that:

- sees exact unit lists,
- plans day economy with a frontier LLM,
- remembers Nordfels walls,
- glances at unknown UI,
- and still *executes* through your A* + `TryToAttack`

…is already more agentic than most published game agents, because most of them cannot shoot and path at 4 Hz while thinking.

It will not “remember everything.” It will remember **compressed lessons**. That is what MemGPT, Reflexion, and Voyager all do.

It will not need 12 online agents. One body, one brain, one critic (Cat Coder offline) is the 2026 design that ships.
