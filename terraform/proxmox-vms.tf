resource "proxmox_virtual_environment_vm" "fedora_vm" {
    name = "prueba-fedora-cloud"
    description = "Creado y administrado por Terraform"
    tags = ["terraform", "fedora"]

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
      type = var.cpu_type
    }
    memory {
      dedicated = 2048
      floating = 2048
    }

    bios = "ovmf"
    machine = "q35"
    efi_disk {
      datastore_id = var.storage_vms
      type = "4m"
    }

    initialization {
      user_account {
        #NO ES PARA USO EN PROD
        username = var.usuario_vm
        password = var.password_vm
      }
      ip_config {
        ipv4 {
          address = "dhcp"
        }
      }
    }

    disk {
      datastore_id = var.storage_vms
      import_from = proxmox_download_file.fedora_cloud_image.id
      interface = "virtio0"
      iothread = true
      discard = "on"
      size = 20
  }

  network_device {
    bridge = "vmbr0"
  }
  operating_system {
    type = var.os_type_linux
  }

}

resource "proxmox_download_file" "fedora_cloud_image" {
  content_type = "import"
  datastore_id = var.storage_vms
  #  overwrite = false
  node_name = var.node01_name
  url = "https://download.fedoraproject.org/pub/fedora/linux/releases/44/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-44-1.7.x86_64.qcow2"
  #url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img"
  file_name = "fedora-44-cloudimg-amd64.qcow2"
}
