module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                    = "43.0.0"
  project_id                 = local.project_id
  name                       = local.cluster_name
  regional                   = false
  zones                      = local.zones
  network                    = module.vpc.network_name 
  subnetwork                 = module.vpc.subnets_names[0]
  ip_range_pods              = lookup(module.vpc.subnets_secondary_ranges[0][0], "range_name", "")
  ip_range_services          = lookup(module.vpc.subnets_secondary_ranges[0][1], "range_name", "")
  http_load_balancing        = true
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  enable_private_endpoint    = false
  enable_private_nodes       = true
  deletion_protection        = false
  gateway_api_channel        = "CHANNEL_STANDARD"

  node_pools = local.node_pools

  node_pools_oauth_scopes = {
    all = [
        "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
  node_pools_labels = {
    all = {}
  }
  node_pools_metadata = {
    all = {}
  }
  node_pools_taints = {
    all = []
  }
  node_pools_tags = {
    all = []
  }
}
resource "google_project_iam_member" "artifact_registry_reader" {
  project = local.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${module.gke.service_account}"
}
