#!/bin/bash
echo "$(john --wordlist=/usr/share/wordlists/rockyou.txt "$1" >/dev/null 2>&1)$(john --show "$1" | grep ':' | cut -d: -f2)" > 4-password.txt
