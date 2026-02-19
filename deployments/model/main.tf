resource "helm_release" "model" {
  name             = local.model.release_name
  namespace        = local.model.namespace
  repository       = local.model.repository != "" ? local.model.repository : null
  chart            = local.model.chart
  version          = local.model.chart_version != "" ? local.model.chart_version : null
  create_namespace = true

  set = local.model.values

}
