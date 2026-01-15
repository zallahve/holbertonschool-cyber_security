#!/usr/bin/env bash
# Discover live hosts on a subnet using ARP (no port scan)

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <subnet/CIDR>" >&2
  exit 1
fi

nmap -sn -PR "$1"
