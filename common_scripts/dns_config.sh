#!/bin/bash

INFO='\e[0;34mINFO:\e[0m'

echo -e "${INFO} config DNS source"
grep Ubuntu /etc/*release*
if [[ $? == "0" ]]; then
    sudo sed -i 's/addresses: .*/addresses: [192.168.166.200]/g' /etc/netplan/01-netcfg.yaml
    echo -e "${INFO} netplan apply"
    sudo netplan apply
    sudo systemctl restart networking.service
else
    sudo sed -i 's/DNS1=.*/DNS1=192.168.166.200/g' /etc/sysconfig/network-scripts/ifcfg-eth0
    echo 'DNS1=192.168.166.200' | sudo tee -a /etc/sysconfig/network-scripts/ifcfg-eth1
    echo -e "${INFO} restart NetworkManager"
    sudo systemctl restart NetworkManager
fi

