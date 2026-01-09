#!/bin/bash
whois $1 | awk -F': ' 'BEGIN{ORS="\n"} /^(Registrant|Admin|Tech)/{gsub(/([a-z])([A-Z])/, "\\1 \\2", $1); if($1~/Street$/) print $1", "$2" "; else if($1~/ Ext:$/ && NF==1) print $1","; else print $1", "$2}' > $1.csv
