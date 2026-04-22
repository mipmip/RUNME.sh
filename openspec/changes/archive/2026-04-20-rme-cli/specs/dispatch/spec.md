# Spec: Command Dispatch

## Behavior

- With no arguments: `exec ./RUNME.sh` (shows usage)
- With arguments: `exec ./RUNME.sh <args...>` (passes all args through)
- Uses `syscall.Exec` to replace the rme process (no child process)
- Exit code comes directly from RUNME.sh

## Own flags

Arguments starting with `--` are intercepted by rme:
- `--help` — rme's own help text
- `--version` — rme version
- `--completions` — hidden; outputs bare command names for shell completion scripts

The `completion` subcommand is also intercepted:
- `completion install` — auto-install shell completions
- `completion fish|bash|zsh` — print completion script to stdout

Everything else passes through to RUNME.sh.

## Acceptance criteria

- [ ] `rme` with no args execs `./RUNME.sh` with no args
- [ ] `rme foo bar` execs `./RUNME.sh foo bar`
- [ ] `rme --help` shows rme's own help, does not call RUNME.sh
- [ ] `rme --version` shows rme version, does not call RUNME.sh
- [ ] Exit code from RUNME.sh propagates correctly
