#!/bin/bash

INFO='\e[0;34mINFO:\e[0m'

echo -e "${INFO} config DNS source"
sudo sed -i 's/addresses: .*/addresses: [192.168.0.200]/g' /etc/netplan/01-netcfg.yaml

echo -e "${INFO} netplan apply"
sudo netplan apply