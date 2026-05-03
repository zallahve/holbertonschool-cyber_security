#!/bin/bash
logfile="${1:-logs.txt}"
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$logfile" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $1}'
