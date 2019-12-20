variable "vm" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["terra", "trinity", "morpheus"]
}

variable "fw" {
  description = "firewall rules for https"
  type = list(string)
  default = [
    "22",
    "443"]

}