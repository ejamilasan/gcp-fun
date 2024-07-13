variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "image" {
  type    = string
  default = "ubuntu-2204-jammy-v20240701"
}

variable "project_id" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "ssh_network_tag" {
  type = string
}