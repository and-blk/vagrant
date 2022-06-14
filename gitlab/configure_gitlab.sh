#!/bin/bash

INFO='\e[0;34mINFO:\e[0m'

echo -e "${INFO} install gitlab"
#sudo apt update && sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
#curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
#sudo EXTERNAL_URL="https://gitlab.example.com" apt-get install gitlab-ee

#echo -e "${INFO} gitlab root password: $(sudo cat /etc/gitlab/initial_root_password)"

echo -e "${INFO} install gitlab-runner"
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
sudo dpkg -i gitlab-runner_amd64.deb

sudo gitlab-runner status


