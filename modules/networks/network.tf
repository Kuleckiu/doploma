resource "google_compute_network" "mynetwork" {
  name = "${var.name}-vpsnetworkter"
  auto_create_subnetworks = false
}