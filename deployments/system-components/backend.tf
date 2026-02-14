terraform {
  required_version = ">= 1.14.5"

  backend "gcs" {
    bucket = "sandbox-pblkt-tf-state"
    prefix = "rag/cert-manager/piblokto-sandbox-gke-deployment.tfstate"
  }
}
