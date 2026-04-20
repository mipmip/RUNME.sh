#!/usr/bin/env bash
# Minimal bash minifier for RUNME.sh framework code.
# Reads from stdin, writes minified bash to stdout.

result=""
while IFS= read -r line; do
  # Strip leading/trailing whitespace
  trimmed="${line#"${line%%[![:space:]]*}"}"
  trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"

  # Skip empty lines and comments
  [[ -z "$trimmed" || "$trimmed" == \#* ]] && continue

  # Remove spaces in simple variable assignments: VAR = val -> VAR=val
  if [[ "$trimmed" =~ ^[A-Z_]+\ +=\ + ]]; then
    trimmed="${trimmed/ = /=}"
    trimmed="${trimmed/ += /+=}"
  fi

  # Remove space between () and { in function defs
  trimmed="${trimmed/'() {'/'(){'}"

  # Remove || spacing
  trimmed="${trimmed/' || '/'||'}"

  # Remove spaces inside (( )) arithmetic
  if [[ "$trimmed" == *'(('* ]]; then
    trimmed="${trimmed//'( '/'('}"
    trimmed="${trimmed//' )'/')'}"
    trimmed="${trimmed//'; '/$';'}"
    # Collapse spaces inside (( ))
    trimmed="${trimmed//' -1'/'-1'}"
    trimmed="${trimmed//' -eq '/'-eq '}"
    # Remove spaces around <= inside arithmetic
    trimmed="${trimmed//' <='/'\<='}"
  fi

  # Join with ; unless previous ends with then/do/else/{
  if [[ -n "$result" ]]; then
    if [[ "$result" =~ (then|do|else|\{)$ ]]; then
      result="$result $trimmed"
    else
      result="$result;$trimmed"
    fi
  else
    result="$trimmed"
  fi
done

printf '%s\n' "$result"
