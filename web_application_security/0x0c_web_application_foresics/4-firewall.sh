#!/bin/bash
grep -Ei 'iptables.*[[:space:]]-A[[:space:]]|iptables.*--append|ufw.*(allow|deny|reject)|firewall-cmd.*--add' auth.log 2>/dev/null | wc -l | awk '{print $1}'
