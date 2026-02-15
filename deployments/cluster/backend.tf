terraform {
  required_version = ">= 1.14.5"

  backend "gcs" {
    bucket = "sandbox-pblkt-tf-state"
    prefix = "rag/cluster/piblokto-sandbox-gke-deployment.tfstate"
  }
}
