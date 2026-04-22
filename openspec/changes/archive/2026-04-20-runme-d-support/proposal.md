# RUNME.d/ support — one file per command

## Problem

As RUNME.sh usage grows in a project, the single file gets long. All commands live in one file, making it harder to navigate and maintain.

## Solution

If a `RUNME.d/` directory exists next to `RUNME.sh`, all `.sh` files in it are sourced automatically before `runme` is called. Each file can define its own commands using the existing `make_command` pattern.

```
my-project/
├── RUNME.sh
└── RUNME.d/
    ├── deploy.sh
    ├── test.sh
    └── clean.sh
```

## Key decisions

- **Explicit over magic**: Each fragment calls `make_command` itself — no filename conventions
- **Path resolution**: `RUNME.d/` is resolved relative to the script's location (`dirname "$0"`), not cwd
- **Ordering**: Alphabetical glob order (use `01-deploy.sh` prefixes if ordering matters)
- **Coexistence**: Inline commands in RUNME.sh and RUNME.d/ fragments work together
- **Naming**: `RUNME.d/` (uppercase, matching `RUNME.sh`)
- **No impact on rme**: Completions parse usage output, which includes all commands regardless of where they're defined

## What changes

Only `src/RUNME.inc.sh` — approximately 3 lines added to source `RUNME.d/*.sh` if the directory exists. Then rebuild `RUNME.sh` via `build.sh`.

## Non-goals

- No convention-based command registration (filename-as-command)
- No recursive directory scanning
- No special ordering mechanism beyond alphabetical glob
