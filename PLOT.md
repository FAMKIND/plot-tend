# PLOT.md

Strategy state for `plot-tend`, written by the planning role. See `plot/SKILL.md`.

## Status

Live at github.com/FAMKIND/plot-tend — public, MIT, `main` at 83b0ef0 (2026-09-20).

Both skills are installed by `install.sh` as symlinks from `~/.claude/skills/`
and `~/.agents/skills/` into this repo, so edits here take effect live.

## Settled — do not re-litigate

- **One repo, not two.** plot and tend ship together so the shared six-part
  handoff contract stays in a single history. It drifts if versioned apart.
- **`~/Sites/plot-tend` is the home.** The earlier empty `~/Sites/plot` and
  `~/Sites/tend` directories are gone.
- **MIT, public.** Matches FAMKIND org precedent.
- **Provenance.** Both skills were split from the retired `wheel-kiln` bundle.
  wheel-kiln is reference material only — not methodology, not to be
  reinstalled. It stays on disk because other local projects reference it.

## Open threads

- **The handoff contract has no enforcement.** The six-part table appears
  identically in both SKILL.md files, each saying "change it here, change it
  there too." Nothing checks this. Now that a repo exists, CI is the obvious
  candidate — a diff of the table block between the two files.
- **Session rituals are duplicated.** `start` and `end` appear in both skills,
  each scoped to what that role can do. Defaulted, never decided. Watch for
  the two copies drifting.
- **`plot` emits three artifact types** — brief, decision surface, critique.
  Narrowing is cheap now and expensive once projects depend on it. Evidence so
  far favours keeping all three: the 2026-09-20 session used each, and the
  boundaries held.

## Facts worth not re-deriving

- `plot/SKILL.md` is 139 lines, `tend/SKILL.md` is 123. Verify copies with
  `cmp` or a hash, never line counts — a brief asserted 124 and was wrong.
- `gh` is not installed here, and neither `GH_TOKEN` nor `GITHUB_TOKEN` is set.
  Creating GitHub repositories is a manual browser step.
- FAMKIND remotes use HTTPS, not SSH.

## Patterns learned

- **A non-forced push is its own verification.** Confirming locally that your
  commit sits on the last-recorded `origin/main` proves self-consistency only;
  it cannot see a remote that moved. The push is the real guard, because a
  non-fast-forward is rejected loudly.
- **mtimes are not authorship.** File dates say when bytes landed on a disk,
  nothing more. Establish direction from git history, or from content that
  could not have existed yet.
- **An anonymous 404 is not absence.** It cannot distinguish deleted from
  private from never-existed. Report it as unreachable and say so.
- **The planning role can pre-answer its own briefs.** Where the planner has
  network access and the executor does not, resolving the network questions
  before relaying shrinks the brief and saves a round trip.
- **Review your own artifact before it runs.** `install.sh` shipped with a
  flaw: backups landed inside the directory Claude Code scans for skills,
  where a `plot.backup-…` folder would have collided with the real `plot`.
  Caught by re-reading a committed file, not by testing it.
- **Match the pace to the person.** When the human said the answers were too
  much, dropping to one brief at a time with every copyable thing in a fenced
  block restored momentum immediately.

## Next action

Decide whether to add the CI check for handoff-contract drift. It is the only
open thread with a concrete, cheap implementation.
