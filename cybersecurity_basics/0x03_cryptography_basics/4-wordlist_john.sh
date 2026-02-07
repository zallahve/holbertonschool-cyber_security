#!/bin/bash
echo "$(john --wordlist=<(gzip -dcf /usr/share/wordlists/rockyou.txt.gz /usr/share/wordlists/rockyou.txt 2>/dev/null) "$1" >/dev/null 2>&1)$(john --show "$1" 2>/dev/null | grep ':' | cut -d: -f2)" > 4-password.txt
