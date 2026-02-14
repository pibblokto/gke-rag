resource "helm_release" "cert_manager" {
  name             = local.cert_manager.release_name
  namespace        = local.cert_manager.namespace
  repository       = local.cert_manager.repository != "" ? local.cert_manager.repository : null
  chart            = local.cert_manager.chart
  version          = local.cert_manager.chart_version != "" ? local.cert_manager.chart_version : null
  create_namespace = true

  set    = local.cert_manager.values
}

resource "helm_release" "kserve_crds" {
  name             = "kserve-crd"
  chart            = "kserve-crd"
  repository       = "oci://ghcr.io/kserve/charts"
  version          = "v0.16.0"
}

resource "helm_release" "ai_gateway_crds" {
    name             = "ai-gateway-crd"
    chart            = "ai-gateway-crds-helm"
    namespace        = "envoy-ai-gateway-system"
    create_namespace = true
    repository       = "oci://docker.io/envoyproxy"
    version          = "v0.0.0-latest"
}

resource "helm_release" "ai_gateway" {
    name             = local.ai_gateway.release_name
    namespace        = local.ai_gateway.namespace
    repository       = local.ai_gateway.repository != "" ? local.ai_gateway.repository : null
    chart            = local.ai_gateway.chart
    version          = local.ai_gateway.chart_version != "" ? local.ai_gateway.chart_version : null
    create_namespace = true

    set    = local.ai_gateway.values

    depends_on = [ helm_release.ai_gateway_crds ]
}

resource "helm_release" "keda" {
    name             = local.keda.release_name
    namespace        = local.keda.namespace
    repository       = local.keda.repository != "" ? local.keda.repository : null
    chart            = local.keda.chart
    version          = local.keda.chart_version != "" ? local.keda.chart_version : null
    create_namespace = true

    set    = local.keda.values
}

resource "helm_release" "kserve" {
    name             = local.kserve.release_name
    namespace        = local.kserve.namespace
    repository       = local.kserve.repository != "" ? local.kserve.repository : null
    chart            = local.kserve.chart
    version          = local.kserve.chart_version != "" ? local.kserve.chart_version : null
    create_namespace = true

    set    = local.kserve.values
    
    depends_on = [ helm_release.kserve_crds, helm_release.keda, helm_release.ai_gateway ]
}

resource "helm_release" "qdrant" {
    
    name             = local.kserve.release_name
    namespace        = local.kserve.namespace
    repository       = local.kserve.repository != "" ? local.kserve.repository : null
    chart            = local.kserve.chart
    version          = local.kserve.chart_version != "" ? local.kserve.chart_version : null
    create_namespace = true
    
    set    = local.kserve.values

  values = [
    yamlencode({

      replicaCount = 3

      resources = {
        requests = {
          cpu    = "2"
          memory = "12Gi"
        }
        limits = {
          cpu    = "4"
          memory = "24Gi"
        }
      }

      persistence = {
        enabled = true
        size    = "30Gi"
      }

      podDisruptionBudget = {
        enabled        = true
        maxUnavailable = 1
      }

      affinity = {
        podAntiAffinity = {
          preferredDuringSchedulingIgnoredDuringExecution = [{
            weight = 100
            podAffinityTerm = {
              topologyKey = "kubernetes.io/hostname"
              labelSelector = {
                matchLabels = { "app.kubernetes.io/name" = "qdrant" }
              }
            }
          }]
        }
      }

      config = {
        cluster = {
          enabled = true
        }
      }
    })
  ]
}
