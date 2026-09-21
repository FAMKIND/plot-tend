# STATE.md

Build status and open gaps for `plot-tend`, written by the executing
role. See `tend/SKILL.md`. Strategy and decisions live in `PLOT.md`;
usage lives in `README.md`. These three must not duplicate each other.

## Status

Two skills, `plot` and `tend`, plus `install.sh` and docs. Public, MIT.

`install.sh` symlinks `plot/` and `tend/` into both `~/.claude/skills/`
and `~/.agents/skills/`, so editing a `SKILL.md` takes effect in every
session started afterwards — before commit, before push. Any pre-existing
directory is moved to a `skills-backup` sibling, never inside the
directory being scanned for skills. It also installs `check-contract.sh`
as a git pre-commit hook.

Both skills load and run. `tend` was exercised end to end from Zed in the
2026-09-20 session, `plot` from Claude Code.

`plot/SKILL.md`'s Gather step no longer permits plot to commit
`PLOT.md` itself; plot always hands the commit to tend. Resolved
2026-09-20, closing a contradiction with L14 of the same file.

## Verified 2026-09-20

Checked directly against the working tree, read-only:

- **The six-part handoff contract is identical in both skills.** Every
  row matches. The only differences are intended: each blockquote names
  the other skill, and the closing line reads "You write all six" in
  `plot` against "You require all six" in `tend`.
- **Symlinks are live and correct** in `~/.claude/skills/`, pointing at
  this working tree.
- **`install.sh` touches nothing outside** `~/.claude/skills`,
  `~/.agents/skills`, and their `-backup` siblings. No chmod, no PATH
  changes, no binaries.
- **`GROUND.md` is referenced at five sites**: `plot/SKILL.md` L26 and
  L120, `tend/SKILL.md` L56, L103 and L107.

Verify file copies with `cmp` or a hash, never line counts. Two separate
sessions have now asserted a wrong line count for a `SKILL.md`.

## Gaps

1. **`GROUND.md` is referenced at five sites, but PT-03 made `AGENTS.md`
   canonical.** Four are read instructions and substitute cleanly. The
   fifth, `tend/SKILL.md` L107, is a *write* destination — repointing it
   decides that `AGENTS.md` is a file agents write to, not only read.
   That decision has not been made. Both skills carry an escape hatch
   permitting other filenames, so this misdirects rather than breaks; it
   cost two sessions a wasted lookup on 2026-09-20.
2. **`plot-tend` has no `AGENTS.md`.** The repo defining the convention
   does not yet follow it. Structure matters here, because whatever
   lands becomes the template other FAMKIND repos copy.
3. **Contract enforcement — closed 2026-09-20.** `check-contract.sh`
   compares the contract table between the two `SKILL.md` files and
   refuses the commit if they differ, or if either file stops having
   exactly one markdown table. `install.sh` installs it as a git
   pre-commit hook. Hooks are not cloned, so this protects only
   machines that have run `install.sh`; the installer tests for a
   `.git` directory, so it silently skips worktrees and submodules
   where `.git` is a file.
4. **Session rituals are duplicated.** `start` and `end` appear in both
   skills. PT-05 had to edit both files to make one change — the
   duplication cost arriving in practice rather than hypothetically.
5. **PT-05's session-word gate has not passed in Zed.** In Claude Code,
   bare `rtb` loaded the skill unprompted. In Zed it did not: the first
   bare `rtb` went unrecognised and the skill loaded only when the word
   was repeated. Pass-on-retry is worse than a clean failure, because
   casual testing records it as a pass. Both tests ran in threads with
   the skill already listed; neither tested a genuinely cold thread.

## Recorded elsewhere

Commit history is the record of which brief caused which change — landed
briefs carry a `Brief: PT-NN` trailer. This file deliberately records no
SHAs and no commit counts; a state file naming its own repository's HEAD
is stale the moment it is committed.

Strategy, settled decisions and cross-project conventions live in
`PLOT.md`.

## Next action

Decide the sequencing left open on 2026-09-20: fix the five `GROUND.md`
references here first, or correct `seed`'s `CLAUDE.md` first. The
`GROUND.md` fix needs the L107 write-destination question answered before
it can be executed.
