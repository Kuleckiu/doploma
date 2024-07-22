resource "google_compute_firewall" "fierwall-http-https" {
  name = "${var.name}-fierwall-http-https"
  network = google_compute_network.mynetwork.name
  allow {
    protocol = "tcp"
    ports = [443,80]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = [ var.fierwall_tags["fierwall-http-https"] ]
}

resource "google_compute_firewall" "fierwall-ssh" {
  name = "${var.name}-fierwall-ssh"
  network = google_compute_network.mynetwork.name
  allow {
    protocol = "tcp"
    ports = [22]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = [ var.fierwall_tags["fierwall-ssh"] ]
}

resource "google_compute_firewall" "fierwall-kuber" {
  name = "${var.name}-fierwall-wordpress"
  network = google_compute_network.mynetwork.name
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = [ var.fierwall_tags["fierwall-wordpress"] ]
}