#!/bin/bash
# 1-xor_decoder.sh - Decode IBM WebSphere {xor} encoded strings
# Usage: ./1-xor_decoder.sh "{xor}BASE64=="

encoded="$1"

encoded="${encoded#\{xor\}}"
encoded="${encoded#\{XOR\}}"

printf '%s' "$encoded" \
| base64 -d 2>/dev/null \
| od -An -tu1 -v \
| tr -s '[:space:]' '\n' \
| grep -E '^[0-9]+$' \
| while IFS= read -r b
do
  x=$((b ^ 95))
  printf "\\x$(printf '%02x' "$x")"
done

printf '\n'
