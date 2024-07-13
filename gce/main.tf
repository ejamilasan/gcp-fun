provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "google_compute_firewall" "allow-ssh" {
  project     = var.project_id
  name        = "${var.ssh_network_tag}-rule"
  network     = "default"
  description = "Allows ssh for a specified IP"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.ip_address]

  target_tags = [var.ssh_network_tag]
}

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = [var.ssh_network_tag]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}