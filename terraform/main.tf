provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "rag_instance" {
  name         = "rag-service-instance"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    instance_role = "rag-service"
  }

  labels = {
    environment = "production"
  }

  tags = ["rag", "deployment"]
}
