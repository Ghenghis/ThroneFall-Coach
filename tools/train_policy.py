#!/usr/bin/env python3
"""Offline policy-gradient trainer over the recorded episode dataset.

The Mario A3C/PPO repos can't help here — they train against a LIVE gym
env (pixels in, reward out). Our data is logged episodes: the honest
offline version is a discounted-return-weighted policy gradient
(REINFORCE with a learned baseline ~= the policy-gradient heart of PPO,
minus importance-sampling tricks that need online rollouts).

  state vector (12 floats) -> MLP 64x64 -> 11 mode logits
  loss = -(A * log pi(a|s)).mean() + 0.5 * MSE(V(s), G)

A = G - V(s) advantage, G = discounted return to match end.
Positive-advantage actions (the ones before victories/survived nights)
get upweighted; defeat trajectories get downweighted.

Exports agent/netpolicy.json — the network weights — loaded at runtime
by src/NetPolicy.cs (no-tensor dependency MLP inference).

Usage: python tools/train_policy.py [--epochs 200] [--out agent/netpolicy.json]
"""
import json, pathlib, sys, os, glob, math
import numpy as np
import torch
import torch.nn as nn

AGENT = pathlib.Path(os.environ.get(
    "THRONEFALL_AGENT",
    r"K:\Downloads-IDM\Thronefall\BepInEx\plugins\agent"))
DS = AGENT / "dataset"
OUT = AGENT / "netpolicy.json"
GAMMA = 0.99
N_MODES = 11        # keep in sync with MODES in episodes.py / BotBrain modes


class Net(nn.Module):
    def __init__(self, n_in, n_out):
        super().__init__()
        self.body = nn.Sequential(
            nn.Linear(n_in, 64), nn.Tanh(),
            nn.Linear(64, 64), nn.Tanh())
        self.pi = nn.Linear(64, n_out)
        self.v = nn.Linear(64, 1)

    def forward(self, x):
        h = self.body(x)
        return self.pi(h), self.v(h).squeeze(-1)


def load_dataset():
    S, A, R, D = [], [], [], []
    for f in sorted(glob.glob(str(DS / "*.jsonl"))):
        rows = [json.loads(l) for l in open(f, errors="replace") if l.strip()]
        # discounted returns within the episode
        G, gs = 0.0, [0.0] * len(rows)
        for i in range(len(rows) - 1, -1, -1):
            G = rows[i].get("r", 0.0) + (0 if rows[i].get("done") else GAMMA * G)
            gs[i] = G
        for i, r in enumerate(rows):
            S.append(r["s"]); A.append(r["a"])
            R.append(gs[i]); D.append(r.get("done", False))
    return (torch.tensor(S, dtype=torch.float32),
            torch.tensor(A, dtype=torch.long),
            torch.tensor(R, dtype=torch.float32))


def main():
    epochs = int(sys.argv[sys.argv.index("--epochs") + 1]) \
        if "--epochs" in sys.argv else 200
    out = pathlib.Path(sys.argv[sys.argv.index("--out") + 1]) \
        if "--out" in sys.argv else OUT

    S, A, G = load_dataset()
    n_in = S.shape[1]
    print(f"[train] {S.shape[0]} rows, {n_in} feats, "
          f"mean G {G.mean():.2f}, win-share {float((G > 0).float().mean()):.2f}")

    net = Net(n_in, N_MODES)
    opt = torch.optim.Adam(net.parameters(), lr=3e-4)
    for ep in range(epochs):
        opt.zero_grad()
        logits, V = net(S)
        logp = torch.log_softmax(logits, -1)
        adv = (G - V.detach())
        adv = (adv - adv.mean()) / (adv.std() + 1e-6)
        pg = -(adv * logp[torch.arange(len(A)), A]).mean()
        vl = 0.5 * ((V - G) ** 2).mean()
        loss = pg + vl
        loss.backward()
        torch.nn.utils.clip_grad_norm_(net.parameters(), 1.0)
        opt.step()
        if ep % 40 == 0 or ep == epochs - 1:
            acc = float((logits.argmax(-1) == A).float().mean())
            print(f"[train] ep{ep:4d} loss={loss.item():.3f} "
                  f"pg={pg.item():.3f} vl={vl.item():.3f} acc={acc:.2f}")

    # export weights — flat arrays, C# reads them without torch
    sd = net.state_dict()
    w = {
        "n_in": n_in, "n_out": N_MODES,
        "w1": sd["body.0.weight"].tolist(), "b1": sd["body.0.bias"].tolist(),
        "w2": sd["body.2.weight"].tolist(), "b2": sd["body.2.bias"].tolist(),
        "wp": sd["pi.weight"].tolist(),     "bp": sd["pi.bias"].tolist(),
        "wv": sd["v.weight"].tolist(),      "bv": sd["v.bias"].tolist(),
    }
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(w))
    print(f"[train] weights -> {out}")


if __name__ == "__main__":
    main()
