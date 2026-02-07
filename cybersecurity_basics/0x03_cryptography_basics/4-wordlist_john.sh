#!/bin/bash
echo "$(john --format=raw-md5 --wordlist=/usr/local/share/wordlists/rockyou.txt "$1" >/dev/null 2>&1)$(john --show --format=raw-md5 "$1" 2>/dev/null | cut -d: -f2 | grep -v '^$')" > 4-password.txt
