# Variables para conectarse a proxmox
variable "endpoint_url" {
  type        = string
  description = "URL del datacenter o endpoint"
  sensitive   = true
}

variable "proxmox_api" {
  type        = string
  description = "API para el usuario de Proxmox"
  sensitive   = true
}

#Varibales ssh
variable "pub_key_path" {
  type        = string
  default     = "/home/kaworu/.ssh/id_rsa.pub"
  description = "Llave publica ssh"
}

variable "priv_key_path" {
  type        = string
  default     = "/home/kaworu/.ssh/id_rsa.pem"
  description = "Llave privada ssh"
}

variable "key_name" {
  type    = string
  default = "server-key"
}

# Variables de Proxmox
variable "storage_vms" {
  type        = string
  description = "Nombre del id de almacenamiento para VMs, contenedores, ..."
  default     = "vmdata"
}

variable "node01_name" {
  type        = string
  description = "Nombre del nodo 01"
  default     = "nerv"
}

# Variables para VMs
variable "usuario_vm" {
  type        = string
  description = "Usuario default para vms"
  default     = "rei"
}
variable "password_vm" {
  type        = string
  description = "Password default para vms"
  sensitive   = true
}

variable "os_type_linux" {
  type        = string
  description = "Tipo de OS Linux"
  default     = "l26"
}

variable "cpu_type" {
  type        = string
  description = "Tipo de CPU para la VM"
  default     = "host"
  #  default     = "x86-64-v2-AES"
}

