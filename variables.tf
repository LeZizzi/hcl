variable "vm" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["terra", "trinity", "morpheus"]
}