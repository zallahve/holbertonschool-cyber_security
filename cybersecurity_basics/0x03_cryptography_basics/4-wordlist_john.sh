#!/bin/bash
echo "$(john --wordlist=/usr/local/share/wordlists/rockyou.txt "$1" >/dev/null 2>&1)$(john --show "$1" 2>/dev/null | grep ':' | cut -d: -f2)" > 4-password.txt
