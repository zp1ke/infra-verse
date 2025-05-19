
// Resource to generate random
resource "random_password" "vm_password" {
  length           = 8
  override_special = "%@"
  special          = true
}

// Resource to download the Alpine Linux cloud image
resource "proxmox_virtual_environment_download_file" "vm_iso" {
  content_type = "iso"
  datastore_id = var.vm_iso_datastore_id
  node_name    = var.vm_iso_node_name
  url          = var.vm_iso_url
  file_name    = var.vm_iso_file_name
}

// Resource to generate RSA private keys for the VMs
resource "tls_private_key" "vm_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.vm_name
  description = var.vm_description
  tags = [
    "zp1ke"
  ]

  node_name = var.vm_node_name
  vm_id     = var.vm_id

  memory {
    dedicated = var.vm_memory_dedicated
  }

  cpu {
    cores   = var.vm_cpu_cores
    sockets = var.vm_cpu_sockets
  }

  agent {
    // read 'Qemu guest agent' section, change to true only when ready
    enabled = false
  }

  // if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true

  startup {
    order      = 1
    up_delay   = "60"
    down_delay = "60"
  }

  disk {
    datastore_id = var.vm_disk_datastore_id
    file_id      = proxmox_virtual_environment_download_file.vm_iso.id
    interface    = var.vm_disk_interface
    size         = var.vm_disk_size
  }

  network_device {
    bridge  = var.vm_network_bridge
    vlan_id = var.vm_network_vlan_id
  }

  operating_system {
    type = "l26"
  }

  tpm_state {
    version = "v2.0"
  }

  serial_device {}

  initialization {
    ip_config {
      ipv4 {
        address = var.vm_network_ipv4_address
        gateway = var.vm_network_ipv4_gateway
      }
    }

    dns {
      servers = ["8.8.8.8"]
    }

    user_account {
      keys     = [trimspace(tls_private_key.vm_key.public_key_openssh)]
      password = random_password.vm_password.result
      username = var.vm_username
    }
  }
}

output "sensitive" {
  sensitive = true
  value = {
    vm_password    = random_password.vm_password.result
    vm_key_private = tls_private_key.vm_key.private_key_openssh
    vm_key_public  = tls_private_key.vm_key.public_key_openssh
  }
}
