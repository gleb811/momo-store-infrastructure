variable "cloud_id" {
  type        = string
  description = "ID of the cloud"
}

variable "folder_id" {
  type        = string
  description = "ID of the folder"
}

variable "zone" {
  type        = string
  description = "ID of the availability zone"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster"
  default = "diploma"
}

variable "subnets" {
  type        = list(string)
  description = "IPv4 CIDR blocks for nodes"
  default     = ["10.0.0.0/16"]
}

variable "autoscale" {
  type = object({
    initial = number
    min     = number
    max     = number
  })
  default = {
    initial = 1
    min     = 1
    max     = 3
  }
}

variable "instance" {
  type = object({
    platform_id = string
    cores       = number
    memory      = number
    disk_type   = string
    disk_size   = number
  })
  default = {
    platform_id = "standard-v2"
    cores       = 2
    memory      = 2
    disk_type   = "network-hdd"
    disk_size   = 64
  }
}