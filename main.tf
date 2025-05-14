
// Resource to generate random
resource "random_password" "vm_password" {
  length           = 16
  override_special = "%@"
  special          = true
}

// Resource to download the Alpine Linux cloud image
resource "proxmox_virtual_environment_download_file" "alpine_iso" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pve1"
  url          = "https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/cloud/nocloud_alpine-3.21.2-x86_64-bios-cloudinit-r0.qcow2"
  file_name    = "miche-alpine-cloudinit.img"
}

resource "proxmox_virtual_environment_vm" "vm" {
  name        = "test-miche"
  description = "test-miche"
  tags        = [
    "miche"
  ]

  node_name   = "pve1"
  vm_id       = 259

  memory {
    dedicated = 8192
  }

  cpu {
    cores = 2
    sockets = 1
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
    datastore_id = "local"
    file_id      = proxmox_virtual_environment_download_file.alpine_iso.id
    interface    = "scsi0"
    size         = 10
  }

  network_device {
    bridge   = "vmbr0"
    vlan_id  =  200
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
        address = "10.150.0.15/24"
        gateway = "10.150.0.1"
      }
    }

    dns {
      servers = [ "8.8.8.8" ]
    }

    user_account {
      #   keys     = [trimspace(tls_private_key.vm_key[each.key].public_key_openssh)]
      password = random_password.vm_password.result
      username = "alpine"
    }
  }
}

output "rnd_password" {
  value = random_password.vm_password.result
  sensitive = true
}
