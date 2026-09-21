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
  `set -e`/`grep -c` defect; PT-08b is unsent as of this entry.
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

**PT-08b → tend.** Add a scripted, hook-enforced check that the handoff
contract table stays identical between `plot/SKILL.md` and `tend/SKILL.md`.
Revision of PT-08, before execution, after a tend-side survey found a
`set -e`/`grep -c` defect and three related robustness gaps. PT-08's text
is superseded by this entry, not kept alongside it — git history over
PLOT.md carries this commit if it's ever needed again.

> **Goal.** A git pre-commit hook fails the commit if the six-part contract
> table differs between the two `SKILL.md` files, or if either file no
> longer contains exactly one markdown table (the assumption the check
> relies on). The hook judges what is actually about to be committed (the
> index), not whatever happens to sit in the working tree.
>
> **Scope boundary.** Add one new file, `check-contract.sh`, at the repo
> root (sibling to `install.sh`, same `#!/bin/sh` convention). Extend
> `install.sh` additively to install a pre-commit hook that runs it — do not
> alter `install.sh`'s existing skill-symlinking loop. No edits to either
> `SKILL.md`'s content.
>
> **The change.**
> New file `check-contract.sh`, executable:
> ```sh
> #!/bin/sh
> set -eu
>
> for f in plot/SKILL.md tend/SKILL.md; do
>   n=$(git show ":$f" | grep -c '^|---' || true)
>   if [ "$n" -ne 1 ]; then
>     echo "check-contract: expected exactly one markdown table in $f, found $n — update this script" >&2
>     exit 1
>   fi
> done
>
> if [ "$(git show :plot/SKILL.md | grep '^|')" != "$(git show :tend/SKILL.md | grep '^|')" ]; then
>   echo "check-contract: handoff contract table differs between plot/SKILL.md and tend/SKILL.md" >&2
>   exit 1
> fi
> ```
> Reading via `git show ":$f"` (the index) rather than `cat "$f"` (the
> working tree) is the fix for the working-tree/index mismatch the survey
> found: a partially staged file must be judged on what will actually land
> in the commit. `|| true` on the `grep -c` pipeline is the fix for the
> `set -e` defect: `grep -c` exits 1 on zero matches, which under bare
> `set -e` would kill the script on that line, before the guard's own
> "found 0" message ever prints — the zero-table case would fail silently,
> exactly what the guard exists to prevent. `set -eu` (not `set -e`) matches
> `install.sh`'s existing convention.
>
> In `install.sh`, after the existing `for target in ...; done` loop and
> before the final blank line, add — guarded so this whole block only runs
> inside an actual git checkout:
> ```sh
> if [ -d "$REPO/.git" ]; then
>   HOOK="$REPO/.git/hooks/pre-commit"
>   if [ -L "$HOOK" ]; then
>     rm "$HOOK"
>   elif [ -e "$HOOK" ]; then
>     backup="$REPO/.git/hooks/pre-commit-backup-$(date +%Y%m%d%H%M%S)"
>     mv "$HOOK" "$backup"
>     echo "moved existing $HOOK to $backup"
>   fi
>   ln -s "$REPO/check-contract.sh" "$HOOK"
>   echo "linked $HOOK -> $REPO/check-contract.sh"
> fi
> ```
> This mirrors the existing symlink-or-backup pattern at L10-18 exactly,
> applied to one hook instead of a loop of two targets. Known, accepted
> limitation from the survey: `[ -d "$REPO/.git" ]` is false when `.git` is
> a file rather than a directory (worktrees, submodules) — fine for
> plot-tend, which is a plain checkout; this silently skips hook install on
> a repo like `dew` if it ever becomes a worktree. Not fixed here — out of
> this brief's scope, and worktree-aware hook placement is genuinely more
> involved than a single-repo build surface needs today.
>
> **Verification.**
> - `sh -n check-contract.sh` and `sh -n install.sh` — expect clean exit,
>   no output.
> - `chmod +x check-contract.sh && git add check-contract.sh && git ls-files
>   -s check-contract.sh` — expect the mode field to read `100755`; a `644`
>   would give a fresh clone a hook it cannot execute.
> - `./check-contract.sh; echo $?` from repo root on the current tree with
>   `check-contract.sh` staged — expect `0` (tables match today).
> - `sh install.sh` then `ls -la .git/hooks/pre-commit` — expect a symlink
>   to `check-contract.sh` in the repo.
> - Read (do not execute destructively against real files) the two failure
>   branches and confirm by inspection that a table-content mismatch and a
>   table-count-not-equal-to-1 mismatch each exit non-zero with a message on
>   stderr, including the zero-table case.
>
> **Gate.** Yes — this is the repo's first build surface and an enforcement
> mechanism; a human should read the script before it counts as done.
>
> **Record step.** `STATE.md`: close gap 3 (contract enforcement), note
> `install.sh` now also installs a pre-commit hook alongside symlinking
> skills, and note the worktree/submodule limitation above, dated, no SHA.
>
> Commit trailer: `Brief: PT-08b`.

One change, one brief, one commit.

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
