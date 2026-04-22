# Spec: Shell Completions

## Command parsing

### Primary: usage output parsing

1. Run `./RUNME.sh` with no arguments, capture stdout
2. Find the `Commands:` section
3. Parse each line matching `^\s+(\S+)\s+(.+)$` as command name + description
4. Return list of command names

### Fallback: source file regex

If RUNME.sh is not executable (shouldn't happen after detection, but used by `--completions` defensively):

1. Read `RUNME.sh` file contents
2. Match `make_command\s+"([^"]+)"` patterns
3. Return list of captured command names

## `--completions` flag

- Outputs one command name per line to stdout
- No decoration, no headers — bare names only
- Used by shell completion scripts
- Not shown in `--help`

## `completion <shell>` subcommand

Prints the completion script for the given shell to stdout:
- `rme completion fish` — fish completion script
- `rme completion bash` — bash completion script
- `rme completion zsh` — zsh completion script

## `completion install` subcommand

1. Detect current shell (from `$SHELL` or parent process)
2. Write completion file to appropriate location:
   - Fish: `~/.config/fish/completions/rme.fish`
   - Bash: `~/.local/share/bash-completion/completions/rme`
   - Zsh: find first writable `$fpath` directory
3. Print confirmation message with path written

## Acceptance criteria

- [ ] `rme --completions` in a dir with RUNME.sh outputs command names, one per line
- [ ] `rme --completions` in a dir without RUNME.sh outputs nothing (no error)
- [ ] `rme completion fish` outputs valid fish completion script
- [ ] `rme completion bash` outputs valid bash completion script
- [ ] `rme completion zsh` outputs valid zsh completion script
- [ ] `rme completion install` detects shell and writes file
- [ ] Completion scripts call `rme --completions` to get dynamic command list
