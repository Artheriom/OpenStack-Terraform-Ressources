# Internal Network
resource "openstack_networking_network_v2" "first_network" {
  name           = "first_network"
  admin_state_up = "true"
}

# Network Subnet
resource "openstack_networking_subnet_v2" "first_network" {
  name            = "first_network-subnet"
  network_id      = "${openstack_networking_network_v2.first_network.id}"
  cidr            = "192.168.10.0/24"
  ip_version      = 4
}