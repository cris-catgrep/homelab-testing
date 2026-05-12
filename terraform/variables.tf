variable "proxmox-user" {
    type = string
    description = "Usuario de Proxmox"
    default = ""
    sensitive = true
}

variable "proxmox-password" {
    type = string
    description = "Password para el usuario de Proxmox"
    default = ""
    sensitive = true
}
