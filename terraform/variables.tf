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

variable "public_key_path" {
  description = "Path to the public SSH key you want to bake into the instance."
  default     = "~/.ssh/id_dsa.pub"
}

variable "private_key_path" {
  description = "Path to the private SSH key, used to access the instance."
  default     = "~/.ssh/id_dsa"
}

variable "project_name" {
  description = "Name of your GCP project.  Example: ansible-terraform-218216"
  default     = "tera-83100"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "citizenx@localhost.localdomain"
}