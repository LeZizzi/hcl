provider "google" {
credentials = file("service-account.json")
  project = "terrabuild"
  region = "europe-west2-a"
  zone = "europe-west1-b"
}

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

resource "google_compute_firewall" "ssh" {
  name    = "${var.fw}-firewall-ssh"
  network = google_compute_network.terra_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.fw}-firewall-ssh"]
  source_ranges = ["0.0.0.0/0"]
}