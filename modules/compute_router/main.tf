resource "google_compute_router" "example_router" {
  name    = var.name
  network = var.network
}