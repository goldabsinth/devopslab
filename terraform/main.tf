terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "= 0.102.0"  # точная версия, которую вы установили
    }
  }
}

# ✅ Провайдер: новый синтаксис
provider "proxmox" {
  endpoint  = "https://192.168.0.135:8006"  
  api_token = var.proxmox_api_token          
  insecure  = true                           
}

# ✅ Ресурс: новый тип и синтаксис
resource "proxmox_virtual_environment_vm" "web" {
  name      = "web-01"
  node_name = "pve"   
  vm_id     = 102

  # Клонирование из шаблона (блок, а не строка!)
  clone {
    vm_id = 9001
  }

  # CPU
  cpu {
    cores = 2
    type  = "host"
  }

  # Память
  memory {
    dedicated = 2048
  }

  # Сеть
  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  # Диск
  disk {
    datastore_id = "local-lvm"
    size         = 15
    interface    = "scsi0" 
  }

  # ✅ Cloud-init: отдельный блок (вместо ipconfig0/sshkeys/ciuser)
  initialization {
    user_account {
      username = "ubuntu"
      password = "ubuntu"
      keys     = [var.ssh_public_key]
    }
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  # Игнорируем изменения, которые Proxmox может делать сам
  lifecycle {
    ignore_changes = [
      network_device,
      disk,
    ]
  }
}

# ✅ Output для удобства
output "web_vm_ip" {
  value       = proxmox_virtual_environment_vm.web.ipv4_addresses[0][0]
  description = "Primary IPv4 address of web-01"
}

output "web_vm_ssh" {
  value       = "ssh ubuntu@${proxmox_virtual_environment_vm.web.ipv4_addresses[0][0]}"
  description = "SSH command to connect to web-01"
}
