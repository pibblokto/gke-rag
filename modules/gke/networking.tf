module "vpc" {
    source       = "terraform-google-modules/network/google"
    version      = "15.2.0"
    project_id   = local.project_id
    network_name = local.vpc_name
    routing_mode = "GLOBAL"

    subnets          = local.subnets
    secondary_ranges = local.secondary_ranges
}

resource "random_string" "router_suffix" {
  length  = 5
  special = false
  upper   = false
  numeric = true
}

resource "google_compute_router" "router" {
  name    = "cloud-router-${random_string.router_suffix.result}"
  network = module.vpc.network_name
  region  = local.nat_region
  project = local.project_id
}

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  project_id = local.project_id
  region     = local.nat_region
  router     = google_compute_router.router.name
}
