provider "google" {
credentials = file("service-account.json")
  project = "terrabuild"
  region = "europe-west2-a"
  zone = "europe-west1-b"
}

resource "google_compute_instance" "terra" {
  name = "terra"
  machine_type = "f1-micro"

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
  name = "terranet"
  auto_create_subnetworks = "true"
}


