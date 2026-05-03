#!/bin/bash
logfile="${1:-logs.txt}"
attacker_ip=$(awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
awk -v ip="$attacker_ip" '$1 == ip { split($0, fields, "\""); print fields[6] }' "$logfile" | sort | uniq -c | sort -nr | head -n 1 | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//'
