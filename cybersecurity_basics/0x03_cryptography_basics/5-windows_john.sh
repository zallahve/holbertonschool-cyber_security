#!/bin/bash
echo "$(john --format=nt --wordlist=/usr/local/share/wordlists/rockyou.txt "$1" >/dev/null 2>&1)$(john --show --format=nt "$1" 2>/dev/null | cut -d: -f2 | grep -v '^$')" > 5-password.txt
