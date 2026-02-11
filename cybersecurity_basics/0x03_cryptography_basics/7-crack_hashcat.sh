#!/bin/bash
echo "$(hashcat -m 0 -a 0 -D 1 "$(pwd)/$1" "$(ls /usr/share/wordlists/rockyou.txt /usr/local/share/wordlists/rockyou.txt 2>/dev/null | head -n 1)" --potfile-path="$(pwd)/7.pot" --quiet >/dev/null 2>&1)$(hashcat -m 0 --show -D 1 "$(pwd)/$1" --potfile-path="$(pwd)/7.pot" --quiet 2>/dev/null | cut -d: -f2 | head -n 1)" > 7-password.txt
