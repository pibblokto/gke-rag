# deployments/cluster

Environment stack that provisions the base GCP network and GKE cluster by calling `../../modules/gke`.

## Purpose

This is the first stack to apply. It creates the Kubernetes control-plane and networking primitives that all other stacks depend on.

## Important Notes

- Values are currently defined in `locals.tf` (project, region, CIDRs, node pools).
- Produces `endpoint` and `ca_certificate` outputs consumed by downstream stacks through remote state.
- Uses a dedicated GCS state prefix (`rag/cluster/...`).

## Terraform Reference

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.5 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ../../modules/gke | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_certificate"></a> [ca\_certificate](#output\_ca\_certificate) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
<!-- END_TF_DOCS -->
