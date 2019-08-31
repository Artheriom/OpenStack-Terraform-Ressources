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

# Public Network
data "openstack_networking_network_v2" "public" {
  name = "public"
}

# Router on Public Network
resource "openstack_networking_router_v2" "global" {
  name                = "global"
  admin_state_up      = true
  external_network_id = "${data.openstack_networking_network_v2.public.id}"
}

# Interface between Router and Subnet
resource "openstack_networking_router_interface_v2" "first_network" {
  router_id = "${openstack_networking_router_v2.global.id}"
  subnet_id = "${openstack_networking_subnet_v2.first_network.id}"
}