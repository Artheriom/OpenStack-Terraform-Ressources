# Première instance
resource "openstack_compute_instance_v2" "hello_world" {
  name            = "bonjour${var.env}"
  image_name      = "Centos 7"
  flavor_name     = "b2-7"
}