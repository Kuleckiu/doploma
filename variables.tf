variable "google_credentials_file" {
  description = "Path to Google Cloud credentials JSON file"
  type = string
  default = "/home/rootuser/tms-git/new-poject-425116-b1de9f7edb20.json"
}

variable "name" {
  description = "name"
  type = string
  default = "wordpress"
}

variable "projectgcpid" {
  description = "Project id"
  type = string
  default = "new-poject-425116"
}

variable "regiongcp" {
  description = "project region"
  type = string
  default = "us-central1"
}

variable "zonegcp" {
  description = "project zone"
  type = string
  default = "us-central1-a"
}


variable "fierwall_tags" {
  description = "tags firewall"
  type = map(string)
  default = {
    fierwall-http-https = "fierwall-http-https"
    fierwall-ssh = "fierwall-ssh"
    fierwall-wordpress = "fierwall-wordpress"
  }
}
