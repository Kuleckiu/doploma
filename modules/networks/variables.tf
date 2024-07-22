variable "name" {
  description = "Name of the project"
  type = string
}

variable "regiongcp" {
  description = "region name"
  type = string
}

variable "ip_cidr_range1" {
  description = "rangeip for subnets"
  type = string
  default = "10.2.3.0/24"
}


variable "fierwall_tags" {
  description = "fierwall tags"
  type = map(string)
}