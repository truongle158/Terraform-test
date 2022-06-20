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