resource "libvirt_domain" "domain" {
  name      = "servername"
  vcpu      = "4"
  memory    = "4"
  running   = false
  autostart = false

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_id = libvirt_network.network.id
  }

  disk {
    volume_id = libvirt_volume.qcow2.id
    scsi      = true
  }
}
