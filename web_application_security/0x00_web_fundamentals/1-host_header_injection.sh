#!/usr/bin/env bash
# 1-host_header_injection.sh
# Simple Host Header Injection checks against web0x00.hbtn.
# Usage: ./1-host_header_injection.sh [base_url]
# Example: ./1-host_header_injection.sh http://web0x00.hbtn

base_url="${1:-http://web0x00.hbtn}"
endpoint="/login"

echo "[*] Host header injection test (Host: attacker.com)"
curl -sS -i --max-time 5 -H "Host: attacker.com" "${base_url}${endpoint}" \
  | sed -n '1,25p' || echo "[-] curl failed (check VPN + /etc/hosts entry)"

echo
echo "[*] X-Forwarded-Host test (X-Forwarded-Host: attacker.com)"
curl -sS -i --max-time 5 -H "Host: web0x00.hbtn" -H "X-Forwarded-Host: attacker.com" \
  "${base_url}${endpoint}" | sed -n '1,25p' || echo "[-] curl failed (check VPN + /etc/hosts entry)"
