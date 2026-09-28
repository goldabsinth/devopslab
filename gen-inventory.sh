#!/bin/bash
cd terraform
IP=$(terraform output -raw vm_ip)
KEY=$(terraform output -raw ssh_key_path)

cd ../ansible
cat > inventory.yml <<EOF
all:
  hosts:
    web-01:
      ansible_host: ${IP}
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ${KEY}
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
EOF
echo "✅ inventory.yml generated for ${IP}"
