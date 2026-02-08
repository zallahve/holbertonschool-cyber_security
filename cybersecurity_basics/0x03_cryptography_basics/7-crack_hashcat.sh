#!/bin/bash
echo "$(hashcat -m 0 -a 0 "$1" "$(ls /usr/share/wordlists/rockyou.txt /usr/local/share/wordlists/rockyou.txt 2>/dev/null | head -n 1)" --quiet >/dev/null 2>&1)$(hashcat -m 0 --show "$1" --quiet 2>/dev/null | cut -d: -f2 | grep -v '^$' | head -n 1)" > 7-password.txt
