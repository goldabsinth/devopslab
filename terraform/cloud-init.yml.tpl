#cloud-config
hostname: ${hostname}
manage_etc_hosts: true
users:
  - name: ubuntu
    ssh_authorized_keys:
      - ${ssh_public_key}
    groups: [adm, sudo]
    lock_passwd: false
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash
package_update: false
package_upgrade: false
