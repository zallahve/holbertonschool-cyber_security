#!/bin/bash
iptables -P INPUT DROP
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT && iptables -A INPUT -i lo -j ACCEPT && iptables -A INPUT -p tcp --dport ssh -j ACCEPT
