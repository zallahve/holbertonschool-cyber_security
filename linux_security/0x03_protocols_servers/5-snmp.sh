#!/bin/bash
grep -E '^(com2sec|rocommunity).*\bpublic\b' /etc/snmp/snmpd.conf
