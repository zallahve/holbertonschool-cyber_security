#!/bin/bash
awk '/COMMAND=/ && /iptables/ && / -A / {
    sub(/^.*COMMAND=/, "")
    print
}' auth.log 2>/dev/null | sort -u | wc -l | awk '{print $1}'
