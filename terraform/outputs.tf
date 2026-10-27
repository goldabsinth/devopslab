output "vm_ips" {
  description = "IP addresses of the created VMs"
  value = {
    for k, v in proxmox_virtual_environment_vm.pam_vms : k => v.ipv4_addresses[0][0]
  }
}

output "domain_controller_ip" {
  description = "IP of the Active Directory Domain Controller (placeholder)"
  value       = "192.168.0.216" # Заглушка, пока AD не поднят
}
