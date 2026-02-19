resource "helm_release" "cert_manager" {
  name             = local.cert_manager.release_name
  namespace        = local.cert_manager.namespace
  repository       = local.cert_manager.repository != "" ? local.cert_manager.repository : null
  chart            = local.cert_manager.chart
  version          = local.cert_manager.chart_version != "" ? local.cert_manager.chart_version : null
  create_namespace = true

  set = local.cert_manager.values
}

resource "helm_release" "external_dns" {
  name             = local.external_dns.release_name
  namespace        = local.external_dns.namespace
  repository       = local.external_dns.repository != "" ? local.external_dns.repository : null
  chart            = local.external_dns.chart
  version          = local.external_dns.chart_version != "" ? local.external_dns.chart_version : null
  create_namespace = true

  set    = local.external_dns.values
  values = [file(local.external_dns.values_file)]

  depends_on = [helm_release.gateway_infra]
}

resource "helm_release" "kserve_crds" {
  name       = "kserve-crd"
  chart      = "kserve-crd"
  repository = "oci://ghcr.io/kserve/charts"
  version    = "v0.16.0"
}

resource "helm_release" "traefik" {
  name             = local.traefik.release_name
  namespace        = local.traefik.namespace
  repository       = local.traefik.repository != "" ? local.traefik.repository : null
  chart            = local.traefik.chart
  version          = local.traefik.chart_version != "" ? local.traefik.chart_version : null
  create_namespace = true

  set = local.traefik.values
}

resource "helm_release" "keda" {
  name             = local.keda.release_name
  namespace        = local.keda.namespace
  repository       = local.keda.repository != "" ? local.keda.repository : null
  chart            = local.keda.chart
  version          = local.keda.chart_version != "" ? local.keda.chart_version : null
  create_namespace = true

  set = local.keda.values
}

resource "helm_release" "kserve" {
  name             = local.kserve.release_name
  namespace        = local.kserve.namespace
  repository       = local.kserve.repository != "" ? local.kserve.repository : null
  chart            = local.kserve.chart
  version          = local.kserve.chart_version != "" ? local.kserve.chart_version : null
  create_namespace = true

  set = local.kserve.values
  values = [
    file(local.kserve.values_file)
  ]

  depends_on = [helm_release.kserve_crds, helm_release.keda, helm_release.cert_manager]
}

resource "helm_release" "gateway_infra" {
  name             = local.gateway_infra.release_name
  namespace        = local.gateway_infra.namespace
  repository       = local.gateway_infra.repository != "" ? local.gateway_infra.repository : null
  chart            = local.gateway_infra.chart
  version          = local.gateway_infra.chart_version != "" ? local.gateway_infra.chart_version : null
  create_namespace = true

  set = local.gateway_infra.values

  depends_on = [helm_release.kserve]
}

resource "helm_release" "qdrant" {
  name             = local.qdrant.release_name
  namespace        = local.qdrant.namespace
  repository       = local.qdrant.repository != "" ? local.qdrant.repository : null
  chart            = local.qdrant.chart
  version          = local.qdrant.chart_version != "" ? local.qdrant.chart_version : null
  create_namespace = true

  set    = local.qdrant.values
  values = [file(local.qdrant.values_file)]
}
