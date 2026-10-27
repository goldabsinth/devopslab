variable "proxmox_api_token" {
  description = "Proxmox API Token (format: user@pam!token=secret)"
  type        = string
  sensitive   = true
}

variable "dns_servers" {
  description = "DNS servers for VMs"
  type        = list(string)
  default     = ["192.168.0.1"]
}

variable "ssh_public_key" {
  description = "SSH public key to inject into VMs via cloud-init"
  type        = string
}

variable "vm_template_name" {
  description = "Name of the Packer template in Proxmox"
  type        = string
  default     = "ubuntu-2404-template"
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "gateway_ip" {
  description = "Default gateway for the VMs (my router)"
  type        = string
  default     = "192.168.0.1"
}

variable "datastore_id" {
  description = "Proxmox storage ID for VM disks"
  type        = string
  default     = "local-lvm"
}

variable "vms" {
  description = "Configuration for all VMs"
  type = map(object({
    ip_address = string
    cpu_cores  = number
    memory_mb  = number
    disk_size  = number
  }))
  default = {
    "vm-bastion" = {
      ip_address = "192.168.0.150"
      cpu_cores  = 1
      memory_mb  = 1024
      disk_size  = 20
    },
    "vm-cp" = {
      ip_address = "192.168.0.151"
      cpu_cores  = 2
      memory_mb  = 2048
      disk_size  = 24
    },
    "vm-w1" = {
      ip_address = "192.168.0.152"
      cpu_cores  = 2
      memory_mb  = 1536
      disk_size  = 24
    },
    "vm-w2" = {
      ip_address = "192.168.0.153"
      cpu_cores  = 2
      memory_mb  = 1536
      disk_size  = 24
    }
  }
}
