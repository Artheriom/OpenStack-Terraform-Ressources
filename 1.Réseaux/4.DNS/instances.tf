resource "openstack_compute_instance_v2" "hello_world" {
  name            = "hello"
  image_name      = "Centos 7"
  flavor_name     = "b2-7"
  security_groups = ["${openstack_networking_secgroup_v2.www.name}", "default"]

  user_data = "${file("conf/data.yml")}"

  network {
    uuid = "${data.openstack_networking_network_v2.global.id}"
  }

}

# Floating IP 
resource "openstack_networking_floatingip_v2" "publication" {
  pool = "public"
}

# Association Floating IP
resource "openstack_compute_floatingip_associate_v2" "publication" {
  floating_ip = "${openstack_networking_floatingip_v2.publication.address}"
  instance_id = "${openstack_compute_instance_v2.hello_world.id}"
}