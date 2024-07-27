variable "subnet1id1" {
  description = "id of first subnet"
  type = string
}

variable "name" {
  description = "Name of the project"
  type = string
}

variable "Pathtoshfile" {
  description = "Path to sh file"
  type = string
  default = "sh.sh"
}

variable "machinetype1" {
  description = "type of machine"
  type = string
  default = "e2-medium"
}


variable "image" {
  description = "image"
  type = string
  default = "ubuntu-2204-jammy-v20240501"  
}


variable "fierwall_tags" {
  description = "tags for fierwall"
  type = map(string)
}

variable "ssh_user" {
  default = "stas_kuleckiu"
}

variable "ssh_public_key" {
  type = string
}

variable "inventorynamefile" {
  type = string
  default = "ansible/inventories/inventory"
}

variable "ssh_private_key" {
  type = string
}