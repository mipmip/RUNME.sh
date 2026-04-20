# Design: build system cleanup

## The minifier (`src/minify.sh`)

A small bash script that reads stdin and produces minified bash on stdout. Only needs to handle the subset used by `RUNME.inc.sh`:

1. Strip comment lines (`#...`)
2. Strip empty lines
3. Strip leading/trailing whitespace per line
4. Join lines with `;` — but not after keywords that require a newline equivalent (`then`, `do`, `{`)

No here-docs, no pipes, no traps, no arrays-of-arrays. The framework code is simple enough that a purpose-built minifier of ~15 lines is more reliable than a general-purpose tool.

Usage: `cat src/RUNME.inc.sh | bash src/minify.sh`

## build.sh

Replaces `make-minified-runme.sh`. Produces one file: `RUNME.sh`.

```bash
#!/usr/bin/env bash
# Build RUNME.sh from source

outfile="./RUNME.sh"

echo "#!/usr/bin/env bash" > "$outfile"
echo "#(C)2019-2026 Pim Snel - https://github.com/mipmip/RUNME.sh" >> "$outfile"

# Minify the framework and append
cat ./src/RUNME.inc.sh | bash ./src/minify.sh >> "$outfile"

# Append the template
cat ./src/RUNME.tpl.sh >> "$outfile"

chmod +x "$outfile"
echo "Built $outfile"
```

## test.sh

Three checks:

### 1. Syntax check
```bash
bash -n RUNME.sh
```

### 2. Functional test
Build a temp RUNME.sh with a known command, verify:
- No-args prints usage containing the command name
- Calling the command produces expected output

### 3. Equivalence test
Build both minified and unminified (temp) variants from the same source. Run both with the same commands. Assert identical stdout.

```
┌────────────────────┐      ┌────────────────────┐
│  build (minified)  │      │  build (unminified) │
│  RUNME.sh          │      │  /tmp/unminified.sh │
└────────┬───────────┘      └────────┬────────────┘
         │                           │
         ▼                           ▼
    run commands                run commands
         │                           │
         └─────── diff ──────────────┘
                   │
              must be empty
```

## Files deleted

- `src/RUNME.inc.minified.sh` — no longer needed, minification happens at build time
- `RUNME.unminified.sh` — redundant; readable source is `src/RUNME.inc.sh`
- `make-minified-runme.sh` — replaced by `build.sh`
