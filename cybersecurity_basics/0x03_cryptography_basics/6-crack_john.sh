#!/bin/bash
echo "$(john --format=raw-sha256 --wordlist=/usr/local/share/wordlists/rockyou.txt "$1" >/dev/null 2>&1)$(john --show --format=raw-sha256 "$1" 2>/dev/null | cut -d: -f2 | grep -v '^$' | head -n 1)" > 6-password.txt
