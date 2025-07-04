#!/bin/bash

IP=$1
USER=$2
KEY=$3

echo "[servers]" > ansible/inventory.ini
echo "$USER ansible_host=$IP ansible_user=$USER ansible_ssh_private_key_file=$KEY ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ansible/inventory.ini

cd ansible
ansible-playbook -i inventory.ini playbook.yml