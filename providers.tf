terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.74.1"
    }
  }
}

provider "proxmox" {
    endpoint = "https://10.150.0.10:8006/"
    insecure = true
    ssh {
      agent = true
    }
}
