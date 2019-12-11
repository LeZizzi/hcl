variable "vm" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["terra", "trinity", "morpheus"]
}

variable "fw" {
  description = "firewall rules for https"
  type = list(string)
  default = ["22","443"]
  
}

variable "project" {
  description = "project name"
  type = string
  default = "terra"
}


variable "region" {
  description = "region name"
  type = string
  default = "europe-west2-a"

}

variable "zone" {
  description = "zone name"
  type = string
  default ="europe-west1-b"
}