locals {
    cert_manager = {
        release_name         = "cert-manager"
        namespace            = "cert-manager"
        repository           = "https://charts.jetstack.io"
        chart                = "cert-manager"
        chart_version        = "1.19.3"
        values               = [
            {
                name  = "installCRDs"
                value = true
            }
        ]
    }

    keda = {
        release_name         = "keda"
        namespace            = "keda"
        repository           = "https://kedacore.github.io/charts"
        chart                = "keda"
        chart_version        = "2.19.0"
        values               = [
            {
                name  = "crds.install"
                value = true
            }
        ]
    }

    kserve = {
        release_name         = "kserve"
        namespace            = "kserve"
        repository           = "oci://ghcr.io/kserve/charts"
        chart                = "kserve"
        chart_version        = "v0.16.0"
        values = [
            {
                name  = "kserve.controller.deploymentMode"
                value = "Standard"
            },
            {
                name  = "kserve.storage.resources.requests.cpu"
                value = "100m"
            },
            {
                name  = "kserve.storage.resources.requests.memory"
                value = "2Gi"
            },
            {
                name  = "kserve.storage.resources.limits.cpu"
                value = "1"
            },
            {
                name  = "kserve.storage.resources.limits.memory"
                value = "8Gi"
            }
        ]

    }

    ai_gateway = {
        release_name         = "ai-gateway"
        namespace            = "envoy-ai-gateway-system"
        repository           = "oci://docker.io/envoyproxy"
        chart                = "ai-gateway-helm"
        chart_version        = "v0.0.0-latest"
        values = []
    }

    qdrant = {

        values = [
            {
                name  = "replicaCount"
                value = "3"
            },
            {
              name  = "resources.requests.cpu"
              value = "2"
            },
            {
              name  = "resources.requests.memory"
              value = "12Gi"
            },
            {
              name  = "resources.limits.cpu"
              value = "4"
            },
            {
              name  = "resources.limits.memory"
              value = "24Gi"
            },
            {
              name  = "persistence.enabled"
              value = "true"
            },
            {
              name  = "persistence.size"
              value = "30Gi"
            },
            {
              name  = "podDisruptionBudget.enabled"
              value = "true"
            },
            {
              name  = "podDisruptionBudget.maxUnavailable"
              value = "1"
            },
            {
              name  = "affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight"
              value = "100"
            },
            {
              name  = "affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey"
              value = "kubernetes.io/hostname"
            },
            {
              name  = "affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels.app\\.kubernetes\\.io/name"
              value = "qdrant"
            },
            {
              name  = "config.cluster.enabled"
              value = "true"
            }
]
    }
}
