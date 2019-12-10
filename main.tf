provider "google" {
credentials = file("service-account.json")
  project = "terrabuild"
  region = "europe-west2-a"
  zone = "europe-west1-b"

}

