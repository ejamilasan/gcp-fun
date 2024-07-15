provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "google_storage_bucket" "bucket" {
  name          = "${var.bucket_name}-${random_id.bucket_id.hex}"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      days_since_noncurrent_time = 3
      no_age = true
    }
  }
}