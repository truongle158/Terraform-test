terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.23.0"
    }
  }
}

provider "google" {
  credentials = file("credential.json")

  project = "sturdy-dogfish-299715"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-b"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = "asia-southeast1-b"
  image = "projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2204-jammy-v20220603"
  labels = {
    environment = "test-disk"
  }
  physical_block_size_bytes = 4096
}

# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-small"
  tags         = ["ssh"]

  metadata = {
    enable-oslogin = "TRUE"
  }
  boot_disk {
    source = google_compute_disk.default.name
  }

  # Update image 
  metadata_startup_script = "sudo apt-get update"

  network_interface {
    network = "default"

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}
