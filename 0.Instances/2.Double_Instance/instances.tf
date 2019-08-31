# Joli groupe
resource "openstack_compute_instance_v2" "hello_world" {
  name            = "hello${count.index + 1}"
  image_name      = "Centos 7"
  flavor_name     = "b2-7"

  count = "2"
}