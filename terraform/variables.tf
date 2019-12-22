### Init stuff needed apparently ..boring

// PROJECT Variables
variable "my_gcp_project" {
  default = "tera-83100"
}

variable "region" {
  default = "europe-west2-a"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "public_key" {
  default = "Your_Public_Key_in_RSA_Format"
}

// FIREWALL Variables
variable "firewall_name" {
  default = "vm-series"
}

variable "image_fw" {
 # default = "Your_VM_Series_Image"

  # /Cloud Launcher API Calls to images/
  # default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-byol-810"
  # default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-bundle2-810"
  # default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-bundle1-810"

}

variable "machine_type_fw" {
  default = "n1-standard-4"
}

variable "machine_cpu_fw" {
  default = "Intel Skylake"
}

variable "bootstrap_bucket_fw" {
  default = "Your_Bootstrap_Bucket"
}

variable "interface_0_name" {
  default = "management"
}

variable "interface_1_name" {
  default = "untrust"
}

variable "scopes_fw" {
  default = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
  ]
}

// DB-SERVER Variables
variable "db_server_name" {
  default = "db-vm"
}

variable "machine_type_db" {
  default = "f1-micro"
}

variable "interface_3_name" {
  default = "db"
}

variable "image_db" {
  default = "debian-8"
}

variable "db_startup_script_bucket" {
  default = "Your_Startup_Bucket "

  // Example of string for startup bucket "gs://startup-2-tier/dbserver-startup.sh"
}

variable "scopes_db" {
  default = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/compute.readonly",
  ]
}

variable "ip_db" {
  default = "10.5.3.5"
}

// WEB-SERVER Vaiables
variable "web_server_name" {
  default = "webserver"
}

variable "machine_type_web" {
  default = "f1-micro"
}

variable "interface_2_name" {
  default = "web"
}

variable "image_web" {
  default = "debian-8"
}

variable "web_startup_script_bucket" {
  default = "Your_Startup_Bucket"

  //  Example of string for startup bucket  "gs://startup-2-tier/webserver-startup.sh"
}

variable "scopes_web" {
  default = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/compute.readonly",
  ]
}

variable "ip_web" {
  default = "10.5.2.5"
}


variable "vm" {
  description = "Create IAM users with these names"
  type        = list(string)
  # default     = ["terra", "trinity", "morpheus"]
  default = ["terra"]
}

variable "fw" {
  description = "firewall rules for https"
  type = list(string)
  default = ["22","443"]
  
}

variable "ssh_keys" {
  user = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5/tokirgrB62PuL05VrmGtDZ8jNI7d2eDzNtXJZIbhLsvKI8ILRuYrG77TbZm7UqcjootIFLBEj97yMrThb3V8ut3zsk31GQ8yhAepnijJA6QVx/tc0lmswzBNgVJLAAiia+dTvdHoAGV61oMAw5HlnppbiWQPio4XJkmPtgmskQwWlFh+cPCdvAMFDgIVwxZNbKKQvmfUE1L+NaUpqo2ln4DJxbsrAhwsUNsbkG+LyErfklF9yIPUzughTjKATz0umWAYUkIq9duW/9ks6geavd+9lu8CrLgoeAFjxb2P8IFkUPNK96xGkOBQt+PDSzraeHfsjuKJIunzBwa1Q3d citizenx""
  key= file("keypub")
}

variable "gce_ssh_user" {
  description = "ssh user"
  ssh = var.ssh_keys

}

variable "keypub" {
  description = "public key file"

}