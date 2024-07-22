resource "google_compute_subnetwork" "privatesub1" {
  name = "${var.name}-subnet1"
  ip_cidr_range = var.ip_cidr_range1
  network = google_compute_network.mynetwork.id
  region = var.regiongcp

}