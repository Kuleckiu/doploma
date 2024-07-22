output "master_external_ip" {
  value = google_compute_instance.kubmaster.network_interface.0.access_config.0.nat_ip
}

output "worker_external_ip" {
  value = google_compute_instance.kubworker.network_interface.0.access_config.0.nat_ip
}