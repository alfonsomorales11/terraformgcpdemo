resource "google_compute_router_nat" "example_nat" {
  name               = var.name
  region             = var.region
  router             = var.router
  nat_ip_allocate_option = var.nat_ip_allocate_option
}