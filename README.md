# plot-tend

Two paired agent skills for planning and carrying out software work.

**plot** lays out work before any of it is built — surveys the real state,
decides what goes where and why, and emits a self-contained artifact another
agent can act on. It never executes.

**tend** carries out a written brief — survey, edit, prove, gate, record,
commit — with strict scope discipline. It never plans.

They are built to run as two different agents in two different sessions,
with a human relaying between them. The split is the point: handing work
across a boundary inserts a moment where judgment is still cheap.

## Install

    ./install.sh

Symlinks `plot/` and `tend/` into `~/.claude/skills/` and `~/.agents/skills/`,
making both discoverable to Claude Code and Zed.

## The shared contract

Both skills carry an identical six-part handoff contract table. Change it in
one and you must change it in the other — they stop fitting together if the
two copies drift. Nothing currently enforces this.

## Licence

MIT. See LICENSE.
