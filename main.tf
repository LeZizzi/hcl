provider "google" {
credentials = file("service-account.json")
  project = "terrabuild"
  region = "europe-west2-a"
  zone = "europe-west1-b"

}

resource "google_compute_instance" "terra" {
  machine_type = "f1-micro"
  name = "terra"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {network = google_compute_network.vpc_network.self_link
    access_config {}
  }
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
} }
}

