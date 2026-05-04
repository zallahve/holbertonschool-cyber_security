#!/bin/bash
grep "new user" auth.log 2>/dev/null | sed -n 's/.*name=\([^,]*\).*/\1/p' | sort -u | paste -sd, -
