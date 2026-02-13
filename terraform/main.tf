# terraform/proxmox/main.tf
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.135:8006/api2/json"
  pm_user         = "root@pam!terraform"
  pm_api_token_id = "terraform"
  pm_api_token_secret = var.proxmox_token
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "web" {
  name        = "web-01"
  target_node = "pve"
  clone       = "ubuntu-2404-template"  # ← ваш шаблон
  vmid        = 101

  cores   = 2
  memory  = 2048
  sockets = 1

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disk {
    slot    = 0
    size    = "15G"
    type    = "scsi"
    storage = "local-lvm"
  }

  # Cloud-init
  ipconfig0 = "ip=dhcp"
  sshkeys   = var.ssh_public_key
}
