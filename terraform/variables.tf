# terraform/proxmox/variables.tf
variable "proxmox_token" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key for cloud-init"
  type        = string
}
