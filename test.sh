#!/usr/bin/env bash
#(C)2019-2026 Pim Snel - https://github.com/mipmip/RUNME.sh

set -euo pipefail
cd "$(dirname "$0")"

PASS=0
FAIL=0

pass() { echo "  PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL: $1"; FAIL=$((FAIL + 1)); }

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

# Build a test RUNME.sh with a known command
build_test_script() {
  local outfile="$1"
  local minify="$2"

  echo '#!/usr/bin/env bash' > "$outfile"
  if $minify; then
    cat ./src/RUNME.inc.sh | bash ./src/minify.sh >> "$outfile"
  else
    cat ./src/RUNME.inc.sh >> "$outfile"
  fi
  cat >> "$outfile" <<'COMMANDS'
make_command "hello" "Say hello"
hello(){ echo "hello world"; }
make_command "add" "Add numbers"
add(){ echo "result: 42"; }
runme
COMMANDS
  chmod +x "$outfile"
}

echo "=== Syntax check ==="
bash -n RUNME.sh && pass "RUNME.sh syntax valid" || fail "RUNME.sh syntax invalid"

echo "=== Functional tests (minified) ==="
build_test_script "$tmpdir/minified.sh" true

# Usage prints command list
usage_out=$("$tmpdir/minified.sh" 2>&1 || true)
echo "$usage_out" | grep -q "hello" && pass "usage lists 'hello' command" || fail "usage missing 'hello' command"
echo "$usage_out" | grep -q "add" && pass "usage lists 'add' command" || fail "usage missing 'add' command"

# Command dispatch works
hello_out=$("$tmpdir/minified.sh" hello 2>&1)
[[ "$hello_out" == "hello world" ]] && pass "dispatch 'hello' works" || fail "dispatch 'hello' failed: $hello_out"

add_out=$("$tmpdir/minified.sh" add 2>&1)
[[ "$add_out" == "result: 42" ]] && pass "dispatch 'add' works" || fail "dispatch 'add' failed: $add_out"

echo "=== Equivalence test ==="
build_test_script "$tmpdir/unminified.sh" false

# Compare usage output (normalize script path in Usage: line)
diff <("$tmpdir/minified.sh" 2>&1 | sed 's|Usage: [^ ]*|Usage: RUNME|' || true) \
     <("$tmpdir/unminified.sh" 2>&1 | sed 's|Usage: [^ ]*|Usage: RUNME|' || true) > /dev/null \
  && pass "usage output identical" || fail "usage output differs"

# Compare command output
diff <("$tmpdir/minified.sh" hello 2>&1) <("$tmpdir/unminified.sh" hello 2>&1) > /dev/null \
  && pass "command output identical" || fail "command output differs"

echo "=== RUNME.d/ tests ==="

# Test: no RUNME.d/ directory (backwards compatible)
build_test_script "$tmpdir/no-d.sh" true
no_d_out=$("$tmpdir/no-d.sh" hello 2>&1)
[[ "$no_d_out" == "hello world" ]] && pass "no RUNME.d/ — works normally" || fail "no RUNME.d/ — broken: $no_d_out"

# Test: empty RUNME.d/ directory (no errors)
mkdir -p "$tmpdir/RUNME.d"
build_test_script "$tmpdir/empty-d.sh" true
empty_d_out=$("$tmpdir/empty-d.sh" hello 2>&1)
[[ "$empty_d_out" == "hello world" ]] && pass "empty RUNME.d/ — no errors" || fail "empty RUNME.d/ — broken: $empty_d_out"
rm -rf "$tmpdir/RUNME.d"

# Test: RUNME.d/ with command fragments
mkdir -p "$tmpdir/RUNME.d"
cat > "$tmpdir/RUNME.d/greet.sh" <<'FRAG'
make_command "greet" "Greet someone"
greet(){ echo "hi there"; }
FRAG
build_test_script "$tmpdir/frag.sh" true
frag_usage=$("$tmpdir/frag.sh" 2>&1 || true)
echo "$frag_usage" | grep -q "greet" && pass "RUNME.d/ command in usage" || fail "RUNME.d/ command missing from usage"
frag_out=$("$tmpdir/frag.sh" greet 2>&1)
[[ "$frag_out" == "hi there" ]] && pass "RUNME.d/ command dispatches" || fail "RUNME.d/ dispatch failed: $frag_out"

# Test: coexistence of inline + RUNME.d/ commands
frag_hello=$("$tmpdir/frag.sh" hello 2>&1)
[[ "$frag_hello" == "hello world" ]] && pass "inline + RUNME.d/ coexist" || fail "inline command broken with RUNME.d/: $frag_hello"
echo "$frag_usage" | grep -q "hello" && pass "inline command in usage with RUNME.d/" || fail "inline command missing from usage with RUNME.d/"
rm -rf "$tmpdir/RUNME.d"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
[[ $FAIL -eq 0 ]] && exit 0 || exit 1
