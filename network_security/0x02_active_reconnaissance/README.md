# 0x02. Active reconnaissance

## Description
This project covers basic active reconnaissance techniques (direct interaction with a target) to discover exposed services and entry points.

## Tools
- nmap

## Tasks
0. **Are there any opened Ports ?**
   - File: `0-ports.txt`
   - Command used:
     - `nmap --top-ports 1000 -Pn 10.42.6.109`
   - Open ports found: 53, 80
