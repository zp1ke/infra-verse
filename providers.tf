terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.78.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = true
  ssh {
    agent = true
    node {
      address = var.proxmox_node_address
      name = var.proxmox_node_name
    }
  }
}
