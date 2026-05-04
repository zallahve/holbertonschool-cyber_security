#!/bin/bash
grep -h "Accepted" * 2>/dev/null | awk '
{
    for (i = 1; i <= NF; i++) {
        if ($i == "from") {
            print $(i + 1)
        }
    }
}
' | sort -u | wc -l | tr -d ' '
