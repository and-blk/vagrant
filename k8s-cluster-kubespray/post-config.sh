#!/bin/bash

PROJECT_PATH=$1

echo "Export required variables"
export  REMOTE_USER=automation


echo "Run kubespray ansible playbook"
docker run --rm -it --mount type=bind,source="$(pwd)/k8s-cluster-kubespray",dst=/app \
  --mount type=bind,source="$(pwd)"/temp,dst=/temp \
  quay.io/kubespray/kubespray:v2.23.1 bash -c '
    ls -la /app/
    ansible-playbook -i /app/kubespray/inventory/mycluster/inventory.ini  --become --become-user=root --user automation --private-key /temp/sshkey /app/kubespray/cluster.yml


  '
# cd ${PROJECT_PATH}/kubespray

# ansible-playbook -i inventory/mycluster/inventory.ini  --become --become-user=root --user ${REMOTE_USER} --private-key ../../temp/sshkey cluster.yml