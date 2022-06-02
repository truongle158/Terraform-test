terraform {
   required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.14"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///session"
}



resource "libvirt_volume" "distro-qcow2" {
  name   = "distro-qcow2"
  pool   = "truongln"
  source = "${path.module}/Ubuntu2004-cloud.img"
  format = "qcow2"
}


data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}
data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}




resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = "truongln"
}




# Create the machine
resource "libvirt_domain" "domain-ubuntu" {
  name   = "ubuntu-terraform"
  memory = "4096"
  vcpu   = 4

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  disk{
    volume_id = libvirt_volume.distro-qcow2.id
}


  network_interface {
    network_name = "truongln-nat"
  }

#First port must alway be serial . This is a known bug for using cloud images

  console{
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }





  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }
}
