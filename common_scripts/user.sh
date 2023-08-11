#!/bin/bash

INFO='\e[0;34mINFO:\e[0m'
KEYS_PATH="../temp/sshkey"
echo -e "${INFO} create user for automation"
sudo groupadd automation
sudo useradd -s /bin/bash -g automation -m automation

echo -e "${INFO} allocate ssh files for automation user"
mkdir /home/automation/.ssh && chmod 700 /home/automation/.ssh
sudo cp /home/vagrant/sshkey /home/automation/.ssh/id_rsa && sudo chmod 600 /home/automation/.ssh/id_rsa
sudo cp /home/vagrant/sshkey.pub /home/automation/.ssh/id_rsa.pub && sudo chmod 644 /home/automation/.ssh/id_rsa.pub
sudo cat /home/automation/.ssh/id_rsa.pub >> /home/automation/.ssh/authorized_keys && sudo chmod 600 /home/automation/.ssh/authorized_keys
sudo chown -R automation:automation /home/automation/.ssh

echo -e "${INFO} sudo without password for automation user"
echo '%automation ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
