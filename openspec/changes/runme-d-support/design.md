# Design: RUNME.d/ support

## Framework change

Add to `src/RUNME.inc.sh`, after the existing function definitions and before the user's commands section:

```bash
RUNME_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -d "$RUNME_DIR/RUNME.d" ]; then
  for _f in "$RUNME_DIR/RUNME.d"/*.sh; do [ -f "$_f" ] && source "$_f"; done
fi
```

This:
1. Resolves the script's own directory (handles `cd elsewhere && ./path/to/RUNME.sh`)
2. Checks if `RUNME.d/` exists
3. Sources each `.sh` file in alphabetical order
4. The `[ -f "$_f" ]` guard handles empty directories (glob returns literal `*.sh`)

## Fragment file format

Each file is a plain bash fragment using the existing `make_command` API:

```bash
# RUNME.d/deploy.sh
make_command "deploy" "Deploy to production"
deploy() {
  rsync -av ./dist/ server:/app/
}
```

No shebang needed — these are sourced, not executed.

## Minified form

The 3 lines minify to something like:

```
RUNME_DIR="$(cd "$(dirname "$0")" && pwd)";if [ -d "$RUNME_DIR/RUNME.d" ];then for _f in "$RUNME_DIR/RUNME.d"/*.sh;do [ -f "$_f" ] && source "$_f";done;fi
```

## Testing

- Test with no `RUNME.d/` directory (backwards compatible)
- Test with `RUNME.d/` containing fragments (commands register and dispatch)
- Test with empty `RUNME.d/` directory (no errors)
- Test coexistence of inline + fragment commands
