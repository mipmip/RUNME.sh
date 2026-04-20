# Design: rme

## Architecture

```
┌─────────────────────────────────────────────┐
│                   rme                        │
│              (single Go binary)              │
├──────────┬──────────┬───────────┬───────────┤
│  main.go │detect.go │ parse.go  │complete.go│
│  entry   │find      │ extract   │ shell     │
│  point & │RUNME.sh  │ commands  │ completion│
│  routing │in cwd    │ from      │ scripts   │
│          │          │ usage     │           │
└──────────┴──────────┴───────────┴───────────┘
         │
         │ exec
         ▼
   ┌─────────────┐
   │  ./RUNME.sh  │
   │  (untouched) │
   └─────────────┘
```

## Project structure

```
src/rme/
├── main.go          # Entry point, flag routing, exec dispatch
├── detect.go        # Find RUNME.sh in cwd, check executable
├── parse.go         # Parse commands from usage output + fallback regex
├── completion.go    # Generate completion scripts for fish/bash/zsh
├── completion_install.go  # Auto-detect shell and write completion file
├── go.mod
```

## Key decisions

### 1. Exec, don't fork

`rme` uses `syscall.Exec` to replace itself with `./RUNME.sh`. No child process, no signal forwarding, no exit code plumbing. The user's shell talks directly to RUNME.sh.

### 2. Completion parsing: usage output first

**Primary**: Run `./RUNME.sh` (no args), capture stdout, parse lines under `Commands:` heading. Regex: `^\s+(\S+)\s+(.+)$`

**Fallback**: If RUNME.sh is not executable, grep the file for `make_command "name" "desc"` patterns.

The usage output approach is preferred because:
- It's the source of truth (what the user sees = what completions show)
- Fast even for large files (only the usage path executes)
- No side effects (no-args path just prints and exits)

### 3. Own flags use `--` prefix

rme's own interface:
- `--help`, `--version` — standard flags
- `completion install` — subcommand (no `--` needed, "completion" is not a valid RUNME.sh command name in practice)
- Everything else → pass through to RUNME.sh

### 4. Strictly cwd

Never walk up directories. If there's no `RUNME.sh` in the current directory, print an error. This is a deliberate safety feature — you always know which RUNME.sh you're running.

### 5. No dependencies beyond Go stdlib

Packages used: `os`, `os/exec`, `syscall`, `regexp`, `fmt`, `strings`, `path/filepath`, `runtime`. No cobra, no external libraries. The entire binary should be readable in 5 minutes.

## Completion scripts

### Fish
```fish
complete -c rme -f -a '(rme --completions)'
```

### Bash
```bash
_rme() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(compgen -W "$(rme --completions)" -- "$cur"))
}
complete -F _rme rme
```

### Zsh
```zsh
_rme() {
    compadd $(rme --completions)
}
compdef _rme rme
```

### Hidden flag: `--completions`

Outputs bare command names (one per line) for consumption by shell completion scripts. Not shown in `--help`.

## Error handling

| Condition | Behavior |
|-----------|----------|
| No RUNME.sh in cwd | stderr: `rme: no RUNME.sh found in current directory`, exit 1 |
| RUNME.sh not executable | stderr: `rme: RUNME.sh is not executable (chmod +x RUNME.sh)`, exit 1 |
| exec fails | stderr: `rme: failed to execute RUNME.sh: <error>`, exit 1 |
| Unknown `--` flag | stderr: `rme: unknown flag: <flag>`, exit 1 |
