#!/bin/bash
whois $1 | awk -F': ' '/^(Registrant|Admin|Tech)/{gsub(/([a-z])([A-Z])/, "\\1 \\2", $1); if($1~/Street$/) printf "%s, %s \n",$1,$2; else if($1~/ Ext:$/ && NF==1) print $1","; else print $1", "$2}' > $1.csv
