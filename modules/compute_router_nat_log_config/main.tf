resource "google_compute_router_nat_log_config" "example_nat_log_config" {
  router_nat_id  = var.router_nat_id
  filter         = var.filter