provider "google" {
  credentials = file(var.google_credentials_file)
  project = var.projectgcpid
  region = var.regiongcp
  zone = var.zonegcp
}