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
        release_name  = "kserve"
        namespace     = "kserve"
        repository    = "oci://ghcr.io/kserve/charts"
        chart         = "kserve"
        chart_version = "v0.16.0"
        
        values      = []
        values_file = "values/kserve.yaml"
    }

    external_dns = {
        release_name  = "external-dns"
        namespace     = "ai-gateway"
        repository    = "https://kubernetes-sigs.github.io/external-dns/"
        chart         = "external-dns"
        chart_version = "1.20.0"
        
        values      = []
        values_file = "values/external-dns.yaml"
    }

    envoy_proxy = {
        release_name         = "envoy-proxy"
        namespace            = "envoy-gateway-system"
        repository           = "oci://docker.io/envoyproxy"
        chart                = "gateway-helm"
        chart_version        = "v0.0.0-latest"
        values = [
            {
                name  = "extensionApis.enableBackend"
                value = true
            },
            {
                name  = "extensionApis.enableEnvoyPatchPolicy"
                value = true
            },
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

    gateway_infra = {
        release_name         = "gateway-infra"
        namespace            = "ai-gateway"
        repository           = "charts/"
        chart                = "gateway-infra"
        chart_version        = "0.0.1"
        values = [
            {
                name  = "cloudflare.apiToken"
                value = var.cloudflare_token
            },
        ]
    }

    qdrant = {
        release_name         = "qdrant"
        namespace            = "qdrant"
        repository           = "https://qdrant.github.io/qdrant-helm"
        chart                = "qdrant"
        chart_version        = "1.16.3"

        values      = []
        values_file = "values/qdrant.yaml"
    }
}
