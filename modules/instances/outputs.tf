output "master_external_ip" {
  value = google_compute_instance.elk.network_interface.0.access_config.0.nat_ip
}