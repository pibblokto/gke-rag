variable project_id {
  type        = string
  description = "Id of GCP project for cluster to be deployed in"
}
variable node_pools {
  type        = list(map(string))
  description = "List of node pool for gke cluster"
}
variable cluster_name {
  type = string
  description = "Name of GKE cluster that will be deployed"
}
variable zones {
  type        = list(string)
  description = "Zones of GKE cluster. It's assumed that cluster in this module is zonal"
}
variable subnetwork {
  type        = string
  description = "Subnetwork to host cluster in"
}
variable ip_range_pods {
  type        = string
  description = "Name of secondary cird range for pods to get ip from"
}
variable ip_range_services {
  type        = string
  description = "Name of secondary cird range for services to get ip from"
}
variable "subnets" {
  type        = list(map(string))
  description = "List of subnets that will be created in vpc"
}
variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
}
variable "vpc_name" {
  type        = string
  description = "Name of VPC that will be created"
}
variable "nat_region" {
  type        = string
  description = "Region, where Cloud NAT will be located"
}
