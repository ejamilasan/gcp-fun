provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "google_secret_manager_secret" "secret" {
  secret_id = var.secret_name
  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "us-east1"
      }
    }
  }
}

resource "google_secret_manager_secret_version" "secret_version" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.secret_value
}