# Tasks: build system cleanup

## Build
- [x] Create `src/minify.sh` — bash minifier that reads stdin, writes minified bash to stdout
- [x] Create `build.sh` — builds RUNME.sh by minifying `src/RUNME.inc.sh` and appending `src/RUNME.tpl.sh`
- [x] Verify `build.sh` produces identical output to current `RUNME.sh`

## Test
- [x] Create `test.sh` with syntax check (`bash -n`)
- [x] Add functional test — usage prints, command dispatches
- [x] Add equivalence test — minified and unminified produce same output

## Cleanup
- [x] Delete `src/RUNME.inc.minified.sh`
- [x] Delete `RUNME.unminified.sh`
- [x] Delete `make-minified-runme.sh`
- [x] Update copyright years to 2019-2026
