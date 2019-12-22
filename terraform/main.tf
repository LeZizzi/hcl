provider "google" {
credentials = file("service-account.json")
  project = "tera-83100"
  region = "europe-west2-a"
  zone = "europe-west1-b"
}



 resource "google_compute_project_metadata_item" "citizenx" {
   key = "ssh-keys"
   value = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5/tokirgrB62PuL05VrmGtDZ8jNI7d2eDzNtXJZIbhLsvKI8ILRuYrG77TbZm7UqcjootIFLBEj97yMrThb3V8ut3zsk31GQ8yhAepnijJA6QVx/tc0lmswzBNgVJLAAiia+dTvdHoAGV61oMAw5HlnppbiWQPio4XJkmPtgmskQwWlFh+cPCdvAMFDgIVwxZNbKKQvmfUE1L+NaUpqo2ln4DJxbsrAhwsUNsbkG+LyErfklF9yIPUzughTjKATz0umWAYUkIq9duW/9ks6geavd+9lu8CrLgoeAFjxb2P8IFkUPNK96xGkOBQt+PDSzraeHfsjuKJIunzBwa1Q3d citizenx"
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

