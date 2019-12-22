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

// Adding VPC Networks to Project  MANAGEMENT
# Copyright 2016 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#Two Tier Terraform Sample Deployment
# Version: 1.2
# Date: 02/28/2018

//
// Adding SSH Public Key in Project Meta Data

// Adding VPC Networks to Project  MANAGEMENT
resource "google_compute_subnetwork" "management-sub" {
  name          = "management-subnet"
  ip_cidr_range = "10.5.0.0/24"
  network       = google_compute_network.management.self_link
  region        = var.region
}

resource "google_compute_network" "management" {
  name                    = var.interface_0_name
  auto_create_subnetworks = "false"
}

// Adding VPC Networks to Project  UNTRUST
resource "google_compute_subnetwork" "untrust-sub" {
  name          = "untrust-subnet"
  ip_cidr_range = "10.5.1.0/24"
  network       = google_compute_network.untrust.self_link
  region        = var.region
}

resource "google_compute_network" "untrust" {
  name                    = var.interface_1_name
  auto_create_subnetworks = "false"
}

// Adding VPC Networks to Project  WEB_TRUST
resource "google_compute_subnetwork" "web-trust-sub" {
  name          = "web-subnet"
  ip_cidr_range = "10.5.2.0/24"
  network       = google_compute_network.web.self_link
  region        = var.region
}

resource "google_compute_network" "web" {
  name                    = var.interface_2_name
  auto_create_subnetworks = "false"
}

// Adding VPC Networks to Project  DB_TRUST
resource "google_compute_subnetwork" "db-trust-sub" {
  name          = "db-subnet"
  ip_cidr_range = "10.5.3.0/24"
  network       = google_compute_network.db.self_link
  region        = var.region
}

resource "google_compute_network" "db" {
  name                    = var.interface_3_name
  auto_create_subnetworks = "false"
}

// Adding GCP ROUTE to WEB Interface
resource "google_compute_route" "web-route" {
  name                   = "web-route"
  dest_range             = "0.0.0.0/0"
  network                = google_compute_network.web.self_link
  next_hop_instance      = element(google_compute_instance.*.name,count.index)
  next_hop_instance_zone = var.zone
  priority               = 100

  depends_on = [google_compute_instance,
    google_compute_network.web,
    google_compute_network.db,
    google_compute_network.untrust,
    google_compute_network.management,
  ]
}

// Adding GCP Firewall Rules for MANGEMENT
resource "google_compute_firewall" "allow-mgmt" {
  name    = "allow-mgmt"
  network = google_compute_network.management.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

// Adding GCP Firewall Rules for INBOUND
resource "google_compute_firewall" "allow-inbound" {
  name    = "allow-inbound"
  network = google_compute_network.untrust.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "221", "222"]
  }

  source_ranges = ["0.0.0.0/0"]
}

// Adding GCP Firewall Rules for OUTBOUND
resource "google_compute_firewall" "web-allow-outbound" {
  name    = "web-allow-outbound"
  network = google_compute_network.web.self_link

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}

// Adding GCP Firewall Rules for OUTBOUND
resource "google_compute_firewall" "db-allow-outbound" {
  name    = "db-allow-outbound"
  network = google_compute_network.db.self_link

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}

// Create a new DBSERVER instance
resource "google_compute_instance" "dbserver" {
  name                      = var.db_server_name
  machine_type              = var.machine_type_db
  zone                      = var.zone
  can_ip_forward            = true
  allow_stopping_for_update = true
  count                     = 1

  // Adding METADATA Key Value pairs to DB-SERVER
  metadata {
    startup-script-url = var.db_startup_script_bucket
    serial-port-enable = true

    # sshKeys                              = "${var.public_key}"
  }

  service_account {
    scopes = var.scopes_db
  }

  network_interface {
    subnetwork = google_compute_subnetwork.db-trust-sub.self_link
    address    = var.ip_db
  }

  boot_disk {
    initialize_params {
      image = var.image_db
    }
  }

  depends_on = ["google_compute_instance.firewall",
    "google_compute_network.web",
    "google_compute_network.db",
    "google_compute_network.untrust",
    "google_compute_network.management",
  ]
}
