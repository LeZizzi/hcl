resource "google_compute_instance" "terra" {
  count = length(var.vm)
  name = var.vm[count.index]
  machine_type = "f1-micro"
  metadata_startup_script = "apt-get update && apt-get install -y nginx"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
  # common nic
    network = google_compute_network.terra_network.self_link
    access_config {}
  }
}

resource "google_compute_network" "terra_network" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
}

