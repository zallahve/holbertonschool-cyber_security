#!/bin/bash
awk '/Accepted/ && / for root / {
    for (i = 1; i <= NF; i++) {
        if ($i == "from") {
            print $(i + 1)
        }
    }
}' auth.log 2>/dev/null | sort -u | wc -l | awk '{print $1}'
