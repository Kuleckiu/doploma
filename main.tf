module "instances" {
  source = "./modules/instances"
  fierwall_tags = var.fierwall_tags
  subnet1id1 = module.networks.subnet1id1
  name = var.name
  ssh_public_key = file(var.publicesshfile)
  ssh_private_key = file(var.privatesshfile)
  
}

module "networks" {
  source = "./modules/networks"
  fierwall_tags = var.fierwall_tags
  name = var.name
  regiongcp = var.regiongcp
}