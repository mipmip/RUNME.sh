# Tasks: RUNME.d/ support

## Framework
- [x] Add RUNME.d/ sourcing logic to `src/RUNME.inc.sh`
- [x] Rebuild `RUNME.sh` via `build.sh`
- [x] Verify minification produces valid output

## Tests
- [x] Add test: no RUNME.d/ directory (backwards compatible, no errors)
- [x] Add test: empty RUNME.d/ directory (no errors)
- [x] Add test: RUNME.d/ with command fragments (register and dispatch)
- [x] Add test: coexistence of inline + RUNME.d/ commands
