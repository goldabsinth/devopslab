proxmox_url      = "https://192.168.0.135:8006/api2/json"
proxmox_username = "root@pam!packer"
# Leave token empty here, provide it in secrets.pkrvars.hcl
vm_id        = "9001"
iso_file     = "local:iso/ubuntu-24.04.3-live-server-amd64.iso"
ssh_username = "ubuntu"
proxmox_node = "pve"
