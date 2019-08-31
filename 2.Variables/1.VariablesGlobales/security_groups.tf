resource "openstack_networking_secgroup_v2" "spring" {
  name        = "spring"
  description = "allow Spring port everywhere"
}

resource "openstack_networking_secgroup_rule_v2" "spring" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "${var.spring_port}"
  port_range_max    = "${var.spring_port}"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.spring.id}"
}