variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
  default     = "AQUI TU ID"
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
  default     = "us-central1"
}

variable "zones" {
  description = "The zones to deploy the cluster in"
  type        = list(string)
  default     = ["us-central1-a"]
}
# default     = ["us-central1-a", "us-central1-b"]

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "my-gke-cluster"
}

variable "node_count" {
  description = "The number of nodes for the default node pool"
  type        = number
  default     = 2
}

variable "min_node_count" {
  description = "Minimum number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes in the node pool"
  type        = number
  default     = 4
}

variable "master_version" {
  description = "Version cluster gke"
  type        = string
  default     = "1.33.0-gke.2248000"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "vpc-network"
}

variable "subnetwork_name" {
  description = "Name of the VPC subnetwork"
  type        = string
  default     = "vpc-subnetwork"
}

variable "ip_cidr_range" {
  description = "CIDR range for the VPC subnetwork"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_machine_type" {
  description = "Machine type for the cluster's default node pool"
  type        = string
  default     = "n1-standard-2"
}

variable "cluster_disk_size_gb" {
  description = "Disk size in GB for nodes created with the cluster"
  type        = number
  default     = 50
}

variable "node_pool_machine_type" {
  description = "Machine type for the managed node pool"
  type        = string
  default     = "n1-standard-2"
}

variable "node_pool_disk_size_gb" {
  description = "Disk size in GB for the managed node pool"
  type        = number
  default     = 50
}
