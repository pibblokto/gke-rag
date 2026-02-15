module "cluster" {
  source            = "../../modules/gke"
  project_id        = local.project_id
  node_pools        = local.node_pools
  cluster_name      = local.cluster_name
  zones             = local.zones
  vpc_name          = local.vpc_name
  subnetwork        = local.subnets[0]["subnet_name"]
  ip_range_pods     = lookup(local.secondary_ranges["primary-subnet"][0], "range_name", "")
  ip_range_services = lookup(local.secondary_ranges["primary-subnet"][1], "range_name", "")
  subnets           = local.subnets
  secondary_ranges  = local.secondary_ranges
  nat_region        = local.nat_region
}
