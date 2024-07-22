output "netid" {
  description = "id of net"
  value = google_compute_network.mynetwork.id
}

output "netname" {
  description = "name of net"
  value = google_compute_network.mynetwork.name
}

output "subnet1id1" {
  description = "id of first subnet"
  value = google_compute_subnetwork.privatesub1.id
}

output "subnet1name" {
  description = "name of first subnet"
  value = google_compute_subnetwork.privatesub1.name
}


output "subregion" {
  description = "region of sub"
  value = google_compute_subnetwork.privatesub1.region
}


