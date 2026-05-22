resource "proxmox_virtual_environment_vm" "rocky_vm" {
  name        = "prueba-rocky-cloud"
  description = "Creado y administrado por Terraform"
  tags        = ["terraform", "rocky"]

  node_name = var.node01_name
  #vm_id = 

  # Solo se desactiva al tener Qemu instalado en la VM
  stop_on_destroy = true
  agent {
    # Solo se activa al tener Qemu instalado en la VM
    enabled = false
  }

  cpu {
    cores = 2
    type  = var.cpu_type
  }
  memory {
    dedicated = 2048
    floating  = 2048
  }

  bios    = "ovmf"
  machine = "q35"
  efi_disk {
    datastore_id = var.storage_vms
    type         = "4m"
  }

  initialization {
    user_account {
      username = var.usuario_vm
      keys     = [trimspace(data.local_file.ssh_key_rocky_pub.content)]
      password = var.password_vm
    }
    ip_config {
      ipv4 {
        address = "192.168.8.90/24"
        gateway = "192.168.8.1"
      }
    }
  }

  disk {
    datastore_id = var.storage_vms
    import_from  = proxmox_download_file.rocky_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
  operating_system {
    type = var.os_type_linux
  }
  keyboard_layout = "es"

}

resource "proxmox_download_file" "rocky_cloud_image" {
  content_type = "import"
  datastore_id = var.storage_vms
  #  overwrite = false
  node_name = var.node01_name
  url       = "https://dl.rockylinux.org/pub/rocky/10/images/x86_64/Rocky-10-GenericCloud-Base.latest.x86_64.qcow2"
  #url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img"
  file_name = "rockyx10-cloudimg-amd64.qcow2"
}
