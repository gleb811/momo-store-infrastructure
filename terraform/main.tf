terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.73.0"
    }
  }
  required_version = ">= 0.75.0"
  backend "http" {
  }
}


provider "yandex" {
  zone                     = var.zone
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = "./sa_key.json"
}