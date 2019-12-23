provider "google" {
credentials = file("service-account.json")
  project = var.my_gcp_project
  region = var.region
  zone = var.zone
}


// Adding SSH Public Key in Project Meta Data
resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = var.public_key
}

resource "google_compute_instance" "terra" {
  count = length(var.vm)
  name = var.vm[count.index]
  machine_type = "f1-micro"
   #  metadata_startup_script = "apt-get update && apt-get install -y nginx"

  can_ip_forward = true

 # metadata {
 #   sshKeys = "${var.ssh_user}:${var.ssh_key} \n${var.ssh_user1}:${var.ssh_key1}" }

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

