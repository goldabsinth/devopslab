terraform {
  required_version = ">= 1.16.5"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.118.1"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://192.168.0.134:8006/api2/json"
  api_token = var.proxmox_api_token 
  insecure  = true

  ssh {
    agent       = false # Не используем ssh-agent, читаем ключ напрямую
    username    = "root"
    private_key = file("~/.ssh/id_ed25519") 
  }
}
