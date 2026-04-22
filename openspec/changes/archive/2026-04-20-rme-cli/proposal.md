# rme — a central command launcher for RUNME.sh

> `rme` is to `RUNME.sh` what `make` is to `Makefile` — except `rme` and `RUNME.sh` are simple enough to understand in 5 minutes.

## Problem

RUNME.sh is a proven, zero-dependency task runner used across many projects. But it lacks discoverability — you have to know it's there and type `./RUNME.sh`. There are no shell completions because completions require a known command name registered with the shell.

## Solution

A single Go binary called `rme` that:

1. Detects `RUNME.sh` in the current working directory (strictly cwd, no parent walking — this is a safety feature)
2. Passes all commands through to `./RUNME.sh`
3. Provides shell completions by parsing RUNME.sh's usage output

RUNME.sh files require zero modification. `rme` is a pure convenience layer.

## How it works

```
┌──────────────┐     ┌─────────────┐
│     rme      │────▶│  ./RUNME.sh │
│  (central)   │     │  (per-dir)  │
└──────────────┘     └─────────────┘

$ cd my-project
$ rme <TAB>
deploy  test  clean  build
$ rme deploy
Deploying...
```

### Command routing

| Input | Behavior |
|-------|----------|
| `rme` (no args) | `exec ./RUNME.sh` (shows usage) |
| `rme deploy` | `exec ./RUNME.sh deploy` |
| `rme <TAB>` | List commands parsed from RUNME.sh |
| `rme --help` | rme's own help |
| `rme --version` | Version info |
| `rme completion install` | Auto-install shell completions |
| `rme completion <shell>` | Print completion script to stdout |
| No RUNME.sh in cwd | Error: "No RUNME.sh found in current directory" |

### Flag disambiguation

`--` prefixed arguments are rme's own flags. Everything else passes through to RUNME.sh. RUNME.sh commands never have `--` prefixes, so there is no ambiguity.

### Completion strategy

Primary: run `./RUNME.sh` (no args), capture stdout, parse the `Commands:` section. This is fast (usage path has no side effects), always accurate (it's the source of truth), and works well even for large RUNME.sh files.

Fallback: regex `make_command` calls from the file source (for cases where RUNME.sh isn't executable).

### Shell completion installation

Two paths:

- **Auto**: `rme completion install` — detects shell, writes completion file
- **Manual**: `rme completion fish|bash|zsh` — prints script to stdout for users who wire completions themselves (e.g. Nix users)

## Tech stack

- **Language**: Go — single static binary, no runtime dependencies, easy cross-compilation
- **Dependencies**: None (stdlib only: `os`, `os/exec`, `regexp`, `fmt`)
- **Spirit**: You can read the whole source in 5 minutes

## Non-goals

- Modifying or replacing RUNME.sh files
- Walking up parent directories to find RUNME.sh
- Dependency graphs, file watching, or build system features
- Plugin system or extensibility (for now)

## Future

Additional features will come later. The first version is strictly: detect, dispatch, complete.
