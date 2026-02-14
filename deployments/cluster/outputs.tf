output "ca_certificate" {
  value     = module.cluster.ca_certificate
  sensitive = true
}

output "endpoint" {
  value     = module.cluster.endpoint
  sensitive = true
}
