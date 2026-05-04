#!/bin/bash
grep -i "firewall" auth.log 2>/dev/null | grep -Ei "add|added|adding|rule" | wc -l | awk '{print $1}'
