#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Common config to all resources. Sync with remote backend.
# https://terragrunt.gruntwork.io/docs/features/keep-your-remote-state-configuration-dry/
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

locals {
  project = get_env("PROJECT")
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

remote_state {
  backend = "gcs"
  config = {
    project = "${local.project}"
    location  = "${local.region}"
    bucket  = "${local.project}-tf-state"
    prefix  = "${path_relative_to_include()}/terraform/state"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

# Inputs are passed to the terraform modules
inputs = {
  project = local.project
  region  = local.region
  zone    = local.zone
}
