# 1. Создаем cloud-init конфиги для каждой ВМ
resource "proxmox_virtual_environment_file" "cloud_config" {
  for_each = var.vms

  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/cloud-init.yml.tpl", {
      hostname       = each.key
      ssh_public_key = var.ssh_public_key
    })
    file_name = "cloud-init-${each.key}.yml"
  }
}

resource "proxmox_virtual_environment_file" "network_config" {
  for_each = var.vms

  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/network-config.yml.tpl", {
      ip_address  = each.value.ip_address
      gateway_ip  = var.gateway_ip
      dns_servers = var.dns_servers
    })
    file_name = "network-config-${each.key}.yml"
  }
}

# 2. Создаем ВМ
resource "proxmox_virtual_environment_vm" "pam_vms" {
  for_each = var.vms

  name      = each.key
  node_name = var.node_name
  tags      = ["pam-lab", each.key]

  clone {
    vm_id = 9001
  }

  cpu {
    cores = each.value.cpu_cores
    type  = "host"
  }

  memory {
    dedicated = each.value.memory_mb
  }

  disk {
    datastore_id = var.datastore_id
    interface    = "scsi0"
    size         = each.value.disk_size
  }

  initialization {
        
    user_data_file_id    = proxmox_virtual_environment_file.cloud_config[each.key].id
    network_data_file_id = proxmox_virtual_environment_file.network_config[each.key].id
  }  

  network_device {
    bridge = "vmbr0"
  }

  agent {
    enabled = true
  }

  on_boot = true
}
