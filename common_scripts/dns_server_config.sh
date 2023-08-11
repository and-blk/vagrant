#!/bin/bash

IP_ADDRESS=$1
VM_NAME=$2

echo "$VM_NAME.local.com. IN A $IP_ADDRESS" >> /etc/bind/db.local.com
systemctl restart bind9