#!/bin/bash
echo "$(hashcat -m 0 -a 0 --potfile-path=./7.pot <(tr -d '\r' < "$1") "$(ls /usr/share/wordlists/rockyou.txt /usr/local/share/wordlists/rockyou.txt 2>/dev/null | head -n 1)" -O -w 1 --quiet >/dev/null 2>&1)$(hashcat -m 0 --show --potfile-path=./7.pot <(tr -d '\r' < "$1") --quiet 2>/dev/null | head -n 1 | cut -d: -f2)" > 7-password.txt
