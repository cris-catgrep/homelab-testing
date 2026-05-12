provider "proxmox" {
  endpoint = var.endpoint_url
  api_token = var.proxmox_api

  insecure = true
}
