#!/bin/bash
l="$1 ALL=(ALL) NOPASSWD: ALL"; grep -Fqx "$l" /etc/sudoers || echo "$l" >> /etc/sudoers
