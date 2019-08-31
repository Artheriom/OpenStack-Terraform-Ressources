# LoadBalancer
resource "openstack_lb_loadbalancer_v2" "cluster_test" {
  name          = "lb_test"
  vip_subnet_id = "${openstack_networking_subnet_v2.first_network.id}"
  depends_on    = ["openstack_compute_instance_v2.hello_world"]
}

# Pool
resource "openstack_lb_pool_v2" "cluster_test" {
  name            = "pool_test"
  protocol        = "TCP"
  lb_method       = "ROUND_ROBIN"
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.cluster_test.id}"
}

# Monitor
resource "openstack_lb_monitor_v2" "cluster_test" {
  name        = "monitor_test"
  pool_id     = "${openstack_lb_pool_v2.cluster_test.id}"
  type        = "TCP"
  delay       = 20
  timeout     = 10
  max_retries = 5
}

# Listener
resource "openstack_lb_listener_v2" "cluster_test" {
  name            = "listener_test"
  protocol        = "TCP"
  protocol_port   = "80"
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.cluster_test.id}"
  default_pool_id = "${openstack_lb_pool_v2.cluster_test.id}"
}

#  Member
resource "openstack_lb_member_v2" "cluster_test" {
  name          = "members_test"
  address       = "${openstack_compute_instance_v2.hello_world.*.network.0.fixed_ip_v4[count.index]}"
  protocol_port = "8080"
  pool_id       = "${openstack_lb_pool_v2.cluster_test.id}"
  count         = "2"
}

#  FIP
resource "openstack_networking_floatingip_v2" "cluster_test" {
  pool = "public"
}

#  FIP association
resource "openstack_networking_floatingip_associate_v2" "cluster_test" {
  floating_ip = "${openstack_networking_floatingip_v2.cluster_test.address}"
  port_id     = "${openstack_lb_loadbalancer_v2.cluster_test.vip_port_id}"
}