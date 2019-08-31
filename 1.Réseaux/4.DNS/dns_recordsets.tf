resource "openstack_dns_recordset_v2" "hello_dns" {
  zone_id     = "${openstack_dns_zone_v2.base.id}"
  name        = "${openstack_compute_instance_v2.hello_world.name}.${openstack_dns_zone_v2.base.name}"
  description = "Machine 1"
  ttl         = 30
  type        = "A"
  records     = ["${openstack_compute_instance_v2.hello_world.network.0.fixed_ip_v4}"]
}
resource "openstack_dns_recordset_v2" "hello_dns_fip" {
  zone_id     = "${openstack_dns_zone_v2.base.id}"
  name        = "${openstack_compute_instance_v2.hello_world.name}.${openstack_dns_zone_v2.base.name}"
  description = "Machine 1"
  ttl         = 30
  type        = "A"
  records     = ["${openstack_networking_floatingip_v2.publication.address}"]
}