# PLOT.md

Strategy state for `plot-tend`, written by the planning role. See `plot/SKILL.md`.

## Status

Live at github.com/FAMKIND/plot-tend — public, MIT. Established 2026-09-20.

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
- **Artifacts carry an ID and a destination.** Every emitted brief or message
  is headed `PROJECT-NN → destination` with one line on what it does, and any
  brief that commits records `Brief: PROJECT-NN` as a commit trailer. IDs are
  per project, sequential, never reused; a revision made before execution
  becomes `01b`. Landed in PT-01.

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
- **A state file should not record its own repository's HEAD.** It is stale
  the moment it is committed — writing PLOT.md necessarily moves the SHA it
  just claimed. Record dates and decisions; let git record commits.
- **Installed skills go live on save, not on commit.** `install.sh` symlinks
  `~/.claude/skills/` and `~/.agents/skills/` at this working tree, so editing
  a SKILL.md changes every session started afterwards — before it is
  committed, before it is pushed. Commit and push are for durability and for
  other machines, not for activation. A session already running keeps the text
  it loaded.

## Cross-project conventions

Decided 2026-09-20; these apply to every FAMKIND repository.

- **`AGENTS.md` is the canonical ground file**, not `GROUND.md`. Zed reads it
  natively and the name is vendor-neutral, which matters for public repos.
  `CLAUDE.md` shrinks to a one-line pointer at it. `STATE.md` keeps its name.
  `plot/SKILL.md` permits this explicitly — the ownership discipline matters,
  the filenames do not.
- **Public repositories must not reference private or internal work by name.**
- **`STATE.md` holds build status and gaps; READMEs stay usage-facing.** The
  two must never duplicate each other, or they drift.

Repo status at time of writing: `seed` and `dew` are established and healthy
but carry no ground files yet, and seed's `CLAUDE.md` currently describes a
Next.js/TypeScript/Storybook stack that does not exist — correcting it is the
prerequisite for everything else there. `lime` is a two-commit scaffold with
no code, awaiting scoping decisions. Each repo's own `STATE.md` is the place
for its detail; this section records only what crosses repos.

## Next action

Correct seed's `CLAUDE.md`, then add `AGENTS.md` and `STATE.md` to seed. It
is the prerequisite for planning work in any FAM repo, because an agent
grounding on today's file plans against a stack that is not there.
