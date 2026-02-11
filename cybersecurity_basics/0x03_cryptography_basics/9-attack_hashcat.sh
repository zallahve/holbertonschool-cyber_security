#!/bin/bash
echo "$(hashcat -m 0 -a 1 -D 1 --potfile-path="$(pwd)/9.pot" "$(pwd)/$1" "$(pwd)/wordlist1.txt" "$(pwd)/wordlist2.txt" --quiet >/dev/null 2>&1)$(hashcat -m 0 --show -D 1 --potfile-path="$(pwd)/9.pot" "$(pwd)/$1" --quiet 2>/dev/null | head -n 1 | cut -d: -f2)" > 9-password.txt
