# Première instance
resource "openstack_compute_instance_v2" "hello_world" {
  name            = "bonjour"
  image_name      = "Centos 7"
  flavor_name     = "b2-7"
  user_data = "${file("conf/data.yml")}"
}

resource "openstack_compute_volume_attach_v2" "hello_world" {
  instance_id = "${openstack_compute_instance_v2.hello_world.id}"
  volume_id = "a7dfaaaa-aaaaaa-aaaaaaaa" #MODIFIEZ-MOI !
  device = "/dev/sdb"
}