version: 2
ethernets:
  id0:
    match:
      name: "en*"
    dhcp4: false
    dhcp6: false
    addresses:
      - "${ip_address}/24"
    routes:
      - to: default
        via: "${gateway_ip}"
    nameservers:
      addresses: ${jsonencode(dns_servers)}
