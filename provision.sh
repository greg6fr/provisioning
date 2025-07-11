#!/bin/bash

set -e

IP_PUBLIC=$1
SSH_USER=$2
PRIVATE_KEY_PATH=$3

echo "🕒 Attente de la disponibilité SSH sur $IP_PUBLIC..."

# Boucle jusqu'à ce que le port 22 soit ouvert
while ! nc -z -w3 "$IP_PUBLIC" 22; do
  sleep 15
done

echo "✅ SSH disponible"

# Mise à jour dynamique de l'inventaire Ansible
echo "📝 Mise à jour de ansible/inventory.ini avec l'adresse IP $IP_PUBLIC"

cat > ansible/inventory.ini <<EOF
[servers]
admin ansible_host=${IP_PUBLIC} ansible_user=${SSH_USER} ansible_ssh_private_key_file=~/provisioning/${PRIVATE_KEY_PATH} ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF

echo "🚀 Lancement du playbook Ansible..."

cd ansible
ansible-playbook -i inventory.ini playbook.yml -K
