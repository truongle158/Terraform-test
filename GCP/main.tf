terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.23.0"
    }
  }
}

#All the variables in in variables.tf 
provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
  zone        ="${var.zone}"
  credentials = "${var.service_account_key}"
}





# Create a single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-small" #Please consider the right machine type . If you don't know which one to choose , please visit GCP console and check in Compute Engine
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
