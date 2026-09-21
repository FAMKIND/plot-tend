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
- **PT-06 decided 2026-09-20: plot never commits, tend always does; the
  contract table is checked by a scripted git hook, not CI.** Corrected
  evidence first: the relay-failure count in the original decision surface
  was wrong — 3 degraded transmissions this session, not 5, and none was a
  brief (one session report, two command outputs). That weakened the case for
  moving brief transmission off chat, and the decision went the other way
  from my lean: **A1**, keep chat relay, paired with a division of labor —
  plot strategises, tend commits — which also resolves the standing
  contradiction between `plot/SKILL.md` L14 (plot never commits) and L127
  (plot's own Gather step said "if you can commit that one file, do exactly
  that"). L14 wins. **Landed in PT-07.** **B**: not B2 (CI
  — no build surface exists yet) or B3 (hand-verified — no automatic trigger)
  but a scripted middle ground: the contract table is the only markdown
  table in either file, so `grep '^|'` equality between the two files is a
  sufficient check, guarded by a row-count assertion so a second table added
  later fails loudly instead of passing silently. Shipped as a git
  pre-commit hook installed by `install.sh`, since git hooks are not cloned
  and `install.sh` is the only thing every session already runs. Drafted as
  PT-08, revised pre-execution to PT-08b after a tend-side survey found a
  `set -e`/`grep -c` defect. **Landed in PT-08b.** The relay failure mode A1
  leaves in place was accepted, not fixed: 3 degraded transmissions this
  session plus 2 duplicate deliveries after the decision was made. A2 would
  not have covered the two largest categories anyway — session reports and
  command output, neither of which is a brief; only a brief-shaped payload
  would have moved to a committed file under A2.
- **`plot` emits three artifact types** — brief, decision surface, critique.
  Narrowing is cheap now and expensive once projects depend on it. Evidence so
  far favours keeping all three: the 2026-09-20 session used each, and the
  boundaries held.

## Open threads

- **Session rituals are duplicated.** `start` and `end` appear in both skills,
  each scoped to what that role can do. Defaulted, never decided. Watch for
  the two copies drifting. Same shape of problem as the contract table PT-08
  addresses; not folded in — a separate decision, not yet made.
- **`tend/SKILL.md` L107: does `AGENTS.md` get written to, or only read?**
  Smaller and unrelated to PT-06, still open. `GROUND.md` is referenced at
  five sites; PT-03 made `AGENTS.md` canonical but only settled the four read
  sites. L107 is a *write* destination. Options on the table: repoint it
  outright (agents write to `AGENTS.md`); repoint it but have tend propose
  the addition rather than write it directly; or drop the destination
  entirely. Evidence against dropping: this session's own environment
  lessons (network access asymmetry, mtimes, the anonymous-404 case) had
  nowhere to land without it.

## Drafted-but-unsent briefs, verbatim

Empty — PT-07 and PT-08b, this session's only two, have both landed. See
the PT-06 entry under Settled for what each did.

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
- **Predict presence, not counts.** Three briefs in one session asserted an
  exact number the planner had not computed — a line count, a commit SHA, a
  grep total — and all three were wrong. Verification should check that
  something is present, or give a floor, unless the number was actually
  counted. A wrong expected value costs a stop-and-check every time.
  Recurred a fourth time: a decision surface (PT-06) cited "five degraded
  transmissions" from memory of the conversation rather than a count; the
  real number was three, and the correction changed which option was worth
  leaning toward. Uncounted numbers in a decision surface aren't cosmetic —
  they can flip the recommendation.
- **`set -e` and `grep -c` combine into a silent failure.** `grep -c`
  returns 0 as its count but still exits 1 when nothing matches; under bare
  `set -e`, `n=$(grep -c ... "$f")` kills the script on that line, before a
  guard written as `if [ "$n" -ne 1 ]; then echo ...; fi` ever runs — the
  zero-match case, usually the one most worth catching loudly, instead fails
  silently. Caught by tend's pre-execution survey of PT-08, not by running
  the script. Fix is `grep -c ... || true`, not switching off `set -e`.
- **The `end` ritual has no step that retires a landed brief.** Sow captures
  unsent briefs; nothing tells plot to remove one from "Drafted-but-unsent"
  once it lands. PT-07 and PT-08b both sat there past landing in this
  session, each needing a separate human prompt to notice and move them.
  Twice in one session is a real cost, not a hypothetical one — worth a
  `plot/SKILL.md` fix (a Gather sub-step: retire any brief that landed since
  the last update), not yet made.

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
