variable "project_id" {
  type = string
}

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
  default = "e2-standard-4" # 4 vCPU / 16GB
}

variable "boot_disk_gb" {
  type    = number
  default = 100
}

variable "ssh_user" {
  type    = string
  default = "ubuntu"
}

variable "allow_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
