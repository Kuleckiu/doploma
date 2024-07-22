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
  name = "${var.name}-fierwall-kuber"
  network = google_compute_network.mynetwork.name
  allow {
    protocol = "tcp"
    ports    = ["53", "68", "323", "6443", "44111", "2379-2381", "10248-10260", "10250", "30000-32767", "2376", "8472", "9099",  "2379-2380", "9100", "9090", "3000" ]
    # ports = [53, 68, 323, 6443, 44111, 2379-2381, 10248-10260, 10250, 30000-32767, 2376, 8472, 9099, 2379-2380, 9100, 9090, 3000]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = [ var.fierwall_tags["fierwall-kuber"] ]
}