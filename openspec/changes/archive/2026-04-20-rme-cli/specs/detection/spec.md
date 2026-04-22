# Spec: RUNME.sh Detection

## Behavior

- rme looks for a file named `RUNME.sh` in the current working directory
- Only the current directory is checked — never walks up parent directories
- The file must exist and be executable

## Acceptance criteria

- [ ] `rme` in a directory with executable `RUNME.sh` → proceeds
- [ ] `rme` in a directory without `RUNME.sh` → error: `rme: no RUNME.sh found in current directory`
- [ ] `rme` in a directory with non-executable `RUNME.sh` → error: `rme: RUNME.sh is not executable (chmod +x RUNME.sh)`
