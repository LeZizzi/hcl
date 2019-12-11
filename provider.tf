provider "google" {
credentials = file("service-account.json")
  project     = "${var.project-name}"
  region      = "${var.region}"
}