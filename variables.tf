# Variables for Proxmox
variable "proxmox_endpoint" {
  description = "Proxmox VE endpoint"
  type        = string
}
variable "proxmox_username" {
  description = "Proxmox VE username"
  type        = string
}
variable "proxmox_password" {
  description = "Proxmox VE password"
  type        = string
}

# Variables for VM ISO
variable "vm_iso_datastore_id" {
  description = "Datastore ID for the VM ISO"
  type        = string
}
variable "vm_iso_node_name" {
  description = "Node name for the VM ISO"
  type        = string
}
variable "vm_iso_url" {
  description = "URL for the VM ISO"
  type        = string
}
variable "vm_iso_file_name" {
  description = "File name for the VM ISO"
  type        = string
}

# Variables for VM
variable "vm_name" {
  description = "Name of the VM"
  type        = string
}
variable "vm_description" {
  description = "Description of the VM"
  type        = string
}
variable "vm_node_name" {
  description = "Node name for the VM"
  type        = string
}
variable "vm_id" {
  description = "ID for the VM"
  type        = number
}
variable "vm_memory_dedicated" {
  description = "Dedicated memory for the VM"
  type        = number
}
variable "vm_cpu_cores" {
  description = "Number of CPU cores for the VM"
  type        = number
}
variable "vm_cpu_sockets" {
  description = "Number of CPU sockets for the VM"
  type        = number
}
variable "vm_disk_datastore_id" {
  description = "Datastore ID for the VM disk"
  type        = string
}
variable "vm_disk_interface" {
  description = "Disk interface for the VM"
  type        = string
}
variable "vm_disk_size" {
  description = "Size of the VM disk in GB"
  type        = string
}
variable "vm_network_bridge" {
  description = "Network bridge for the VM"
  type        = string
}
variable "vm_network_vlan_id" {
  description = "VLAN ID for the VM network"
  type        = number
}
variable "vm_network_ipv4_address" {
  description = "IPv4 address for the VM network"
  type        = string
}
variable "vm_network_ipv4_gateway" {
  description = "IPv4 gateway for the VM network"
  type        = string
}
variable "vm_username" {
  description = "Username for the VM"
  type        = string
}
