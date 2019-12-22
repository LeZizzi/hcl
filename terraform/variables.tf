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