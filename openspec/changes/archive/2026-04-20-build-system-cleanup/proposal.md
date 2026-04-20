# Clean up RUNME.sh build system

## Problem

The current build system has accumulated cruft:

- `src/RUNME.inc.minified.sh` is hand-maintained — it should be generated at build time
- `RUNME.unminified.sh` is redundant — people can read `src/RUNME.inc.sh` directly
- The minifier was an external curl dependency (now commented out)
- There are no tests to verify the build output works

## Solution

1. Write a small bash minifier as part of this project (`src/minify.sh`)
2. Rewrite the build script to generate the minified framework at build time
3. Remove `src/RUNME.inc.minified.sh` and `RUNME.unminified.sh`
4. Rename `make-minified-runme.sh` to `build.sh`
5. Add tests that verify the built RUNME.sh works correctly

## What changes

```
Deleted:
  src/RUNME.inc.minified.sh    (generated at build time now)
  RUNME.unminified.sh          (redundant with src/)
  make-minified-runme.sh       (renamed)

Added:
  src/minify.sh                bash minifier for the framework
  build.sh                     renamed and rewritten build script
  test.sh                      functional tests

Unchanged:
  src/RUNME.inc.sh             source of truth (readable framework)
  src/RUNME.tpl.sh             template with demo commands
  RUNME.sh                     output (now fully generated)
```

## Build flow

```
src/RUNME.inc.sh ──▶ src/minify.sh ──▶ (minified framework)
                                              │
src/RUNME.tpl.sh ─────────────────────────────┤
                                              ▼
                                          RUNME.sh
```

## Test strategy

1. **Syntax**: `bash -n RUNME.sh` passes
2. **Functional**: Built RUNME.sh registers commands, prints usage, dispatches correctly
3. **Equivalence**: Minified and unminified (built as temp) produce identical output for the same commands
