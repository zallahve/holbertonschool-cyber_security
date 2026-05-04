#!/bin/bash
awk '{print $6}' *.log 2>/dev/null | sort | uniq -c | sort -nr
