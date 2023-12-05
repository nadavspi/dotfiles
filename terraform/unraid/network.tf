resource "libvirt_network" "network" {
  name      = "network"
  mode      = "bridge"
  bridge    = "br0"
  addresses = ["192.168.1.0/24"]
}
