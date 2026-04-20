# Tasks: rme

## Setup
- [x] Initialize Go module (`src/rme/go.mod`)
- [x] Create `main.go` with entry point and flag routing

## Core
- [x] Implement `detect.go` — find RUNME.sh in cwd, check if executable
- [x] Implement `main.go` dispatch — exec RUNME.sh with args passthrough
- [x] Implement `parse.go` — parse commands from RUNME.sh usage output (primary) and source file regex (fallback)

## Completions
- [x] Implement `--completions` hidden flag (bare command names to stdout)
- [x] Implement `completion.go` — generate fish/bash/zsh completion scripts
- [x] Implement `completion_install.go` — auto-detect shell and write completion file

## Own interface
- [x] Implement `--help` with usage text
- [x] Implement `--version`

## Build & test
- [x] Add basic tests for parse logic
- [x] Verify build produces single static binary
