locals {
    node_pools        = var.node_pools
    project_id        = var.project_id
    cluster_name      = var.cluster_name
    zones             = var.zones
    vpc               = var.vpc_name
    subnetwork        = var.subnetwork
    ip_range_pods     = var.ip_range_pods
    ip_range_services = var.ip_range_services
    subnets           = var.subnets
    secondary_ranges  = var.secondary_ranges
    vpc_name          = var.vpc_name
    nat_region        = var.nat_region
}
