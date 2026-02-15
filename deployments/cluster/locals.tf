locals {
  # VPC confing
  vpc_name   = "primary-vpc"
  nat_region = "us-central1"
  project_id = "piblokto"

  subnets = [
    {
      subnet_name   = "primary-subnet"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = local.nat_region
    }
  ]
  secondary_ranges = {
    primary-subnet = [
      {
        range_name    = "${local.subnets[0]["subnet_name"]}-pods-range"
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = "${local.subnets[0]["subnet_name"]}-services-range"
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }

  # GKE confing
  cluster_name = "primary-sandbox-cluster"
  zones        = ["${local.nat_region}-c"]
  node_pools   = [
    {
      name               = "primary-node-pool"
      machine_type       = "e2-standard-2"
      min_count          = 1
      max_count          = 3
      local_ssd_count    = 0
      disk_size_gb       = 40
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
    },
    {
      name               = "qdrant-node-pool"
      machine_type       = "e2-standard-4"
      min_count          = 1
      max_count          = 1
      local_ssd_count    = 0
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false 
    },
  ]
}
