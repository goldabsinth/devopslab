output "vm_ip" {
  value       = proxmox_virtual_environment_vm.web.ipv4_addresses[0][0]
  description = "Primary IPv4 of web-01"
}

output "ssh_key_path" {
  value       = "~/.ssh/id_ed25519"  # путь к приватному ключу
  description = "Path to SSH private key"
}
