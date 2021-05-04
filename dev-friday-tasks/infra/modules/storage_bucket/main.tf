#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPLOY A GOOGLE CLOUD STORAGE BUCKET
# https://cloud.google.com/storage
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.14.2"
}

resource "google_storage_bucket" "scale" {
  project                     = var.project
  name                        = "${var.project}-scale"
  location                    = "EU"
  uniform_bucket_level_access = true
}