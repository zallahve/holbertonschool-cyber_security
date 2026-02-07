#!/bin/bash
printf "%s" "$1" | shasum -a 1 | awk '{print $1}' > 0_hash.txt
