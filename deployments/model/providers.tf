data "google_client_config" "current" {}

data "terraform_remote_state" "cluster" {
  backend = "gcs"

  config = {
    bucket = "sandbox-pblkt-tf-state"
    prefix = "rag/cluster/piblokto-sandbox-gke-deployment.tfstate"
  }
}

provider "google" {
  project = "piblokto"
  region  = "us-central1"
}

provider "helm" {
  kubernetes = {
    cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.ca_certificate)
    token                  = data.google_client_config.current.access_token
    host                   = "https://${data.terraform_remote_state.cluster.outputs.endpoint}"
  }
}
