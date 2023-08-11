#!/bin/bash

PROJECT_PATH=$1

echo "Export required variables"
export  REMOTE_USER=automation


echo "Run kubespray ansible playbook"
cd ${PROJECT_PATH}/kubespray
ansible-playbook -i inventory/mycluster/inventory.ini  --become --become-user=root --user ${REMOTE_USER} --private-key ../../temp/sshkey cluster.yml