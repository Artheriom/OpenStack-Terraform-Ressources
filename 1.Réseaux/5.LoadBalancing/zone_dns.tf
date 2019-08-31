# DNS Zone 
resource "openstack_dns_zone_v2" "base" {
  name        = "tuto.openstack.local."
  email       = "localhost@local.fr"
  description = "DNS zone"
  ttl         = 300
  type        = "PRIMARY"
}