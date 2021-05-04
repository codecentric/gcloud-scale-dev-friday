#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPLOY A GOOGLE CLOUD BIGTABE INSTANCE
# https://cloud.google.com/bigtable
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  required_version = ">= 0.14.2"
}

resource "google_bigtable_instance" "scale_bigtable" {
  # Arguments
  project = var.project  # TODO: Move project central to provider
  name = "scale-bigtable"
  deletion_protection = false

  # Blocks
  cluster {
    cluster_id   = "scale-bigtable"
    num_nodes    = 1
    storage_type = "HDD"
    zone = var.zone
  }

}

resource "google_bigtable_table" "scale_traffic" {
  # Arguments
  project       = var.project
  name          = "scale-traffic"
  instance_name = google_bigtable_instance.scale_bigtable.name

  # Blocks
  column_family {
      family = "cf1"
  }
}