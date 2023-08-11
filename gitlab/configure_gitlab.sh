#!/bin/bash

IP_ADDRESS=$1
GITLAB_URL=$2
INFO='\e[0;34mINFO:\e[0m'

echo -e "${INFO} install gitlab"
sudo apt update && sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
sudo EXTERNAL_URL="https://${GITLAB_URL}" apt-get install gitlab-ee -y

echo -e "${INFO} gitlab root password: $(sudo cat /etc/gitlab/initial_root_password)"

echo -e "${INFO} install gitlab-runner"
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
sudo dpkg -i gitlab-runner_amd64.deb

echo -e "${INFO} delete wrong certs"
sudo rm -rf /etc/gitlab/ssl/*

echo -e "${INFO} generate new tls certs"
sudo openssl req -nodes -x509 -newkey rsa:4096 -keyout "/etc/gitlab/ssl/$GITLAB_URL.key" -out "/etc/gitlab/ssl/${GITLAB_URL}.crt" -sha256 -days 365 -addext "subjectAltName = DNS:${GITLAB_URL}" -subj "/C=RU/ST=Saratov/L=Saratov/O=Company test/OU=Org_test"

echo -e "${INFO} reconfigure gitlab"
sudo gitlab-ctl reconfigure

echo -e "${INFO} add certificate to trusted"
sudo cp "/etc/gitlab/ssl/${GITLAB_URL}.crt" /usr/local/share/ca-certificates/
sudo update-ca-certificates

echo -e "${INFO} fix no DNS issue"
echo "$IP_ADDRESS $GITLAB_URL" | sudo tee -a /etc/hosts

echo -e "${INFO} gitlab-runner status:"
sudo gitlab-runner status

# To register gitlab runner take registration token
# sudo gitlab-runner register --url https://gitlab.local.com --registration-token 4zTBiQ9aRuyaiGXQbJGs --tls-ca-file /etc/gitlab/ssl/gitlab.local.com.crt

