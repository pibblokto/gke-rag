# modules/gke

Terraform module for provisioning the base Google Cloud infrastructure required by this platform:

- VPC and subnet(s) with secondary ranges for Kubernetes pods/services.
- Cloud Router + Cloud NAT for private node egress.
- Private GKE cluster with custom node pools.

## What This Module Is For

Use this module when you need a GKE foundation that includes both networking and cluster creation in one reusable unit.

## Important Behavior

- Uses upstream community modules:
  - `terraform-google-modules/network/google`
  - `terraform-google-modules/cloud-nat/google`
  - `terraform-google-modules/kubernetes-engine/google//modules/private-cluster`
- Removes default GKE node pool and creates user-defined pools from `var.node_pools`.
- Configures Gateway API channel (`CHANNEL_STANDARD`) at cluster creation.
- Adds Artifact Registry read permission to the cluster node service account.
- Applies dedicated taint/label logic for a `qdrant-node-pool`.
- Expects caller-provided subnet and secondary range names; cluster is configured as zonal.

## Usage

```hcl
module "cluster" {
  source            = "../../modules/gke"
  project_id        = "my-project"
  cluster_name      = "primary-sandbox-cluster"
  zones             = ["us-central1-c"]
  vpc_name          = "primary-vpc"
  nat_region        = "us-central1"
  node_pools        = []
  subnets           = []
  secondary_ranges  = {}
  subnetwork        = "primary-subnet"
  ip_range_pods     = "primary-subnet-pods-range"
  ip_range_services = "primary-subnet-services-range"
}
```

## Terraform Reference

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud-nat"></a> [cloud-nat](#module\_cloud-nat) | terraform-google-modules/cloud-nat/google | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | 43.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | 15.2.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_project_iam_member.artifact_registry_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [random_string.router_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of GKE cluster that will be deployed | `string` | n/a | yes |
| <a name="input_ip_range_pods"></a> [ip\_range\_pods](#input\_ip\_range\_pods) | Name of secondary cird range for pods to get ip from | `string` | n/a | yes |
| <a name="input_ip_range_services"></a> [ip\_range\_services](#input\_ip\_range\_services) | Name of secondary cird range for services to get ip from | `string` | n/a | yes |
| <a name="input_nat_region"></a> [nat\_region](#input\_nat\_region) | Region, where Cloud NAT will be located | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | List of node pool for gke cluster | <pre>list(object({<br/>    name               = string<br/>    machine_type       = string<br/>    min_count          = number<br/>    max_count          = number<br/>    local_ssd_count    = number<br/>    disk_size_gb       = number<br/>    disk_type          = string<br/>    image_type         = string<br/>    enable_gcfs        = bool<br/>    auto_repair        = bool<br/>    auto_upgrade       = bool<br/>    preemptible        = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Id of GCP project for cluster to be deployed in | `string` | n/a | yes |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | Secondary ranges that will be used in some of the subnets | `map(list(object({ range_name = string, ip_cidr_range = string })))` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnets that will be created in vpc | `list(map(string))` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Subnetwork to host cluster in | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of VPC that will be created | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | Zones of GKE cluster. It's assumed that cluster in this module is zonal | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_certificate"></a> [ca\_certificate](#output\_ca\_certificate) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Id of GKE cluster |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Endpoint of GKE cluster |
| <a name="output_identity_namespace"></a> [identity\_namespace](#output\_identity\_namespace) | Workload Identity pool |
| <a name="output_name"></a> [name](#output\_name) | Name of GKE cluster |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | n/a |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | n/a |
| <a name="output_node_pools_names"></a> [node\_pools\_names](#output\_node\_pools\_names) | List of GKE cluster node pools |
| <a name="output_subnets_ips"></a> [subnets\_ips](#output\_subnets\_ips) | n/a |
| <a name="output_subnets_name"></a> [subnets\_name](#output\_subnets\_name) | n/a |
| <a name="output_type"></a> [type](#output\_type) | Type of GKE cluster (regional/zonal) |
<!-- END_TF_DOCS -->
