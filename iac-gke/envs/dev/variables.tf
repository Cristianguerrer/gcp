variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
}

variable "zones" {
  description = "The zones to deploy the cluster in"
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "node_count" {
  description = "The number of nodes for the default node pool"
  type        = number
}

variable "min_node_count" {
  description = "Minimum number of nodes in the node pool"
  type        = number
}

variable "max_node_count" {
  description = "Maximum number of nodes in the node pool"
  type        = number
}

variable "master_version" {
  description = "Version cluster gke"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnetwork_name" {
  description = "Name of the VPC subnetwork"
  type        = string
}

variable "ip_cidr_range" {
  description = "CIDR range for the VPC subnetwork"
  type        = string
}

variable "cluster_machine_type" {
  description = "Machine type for the cluster's default node pool"
  type        = string
}

variable "cluster_disk_size_gb" {
  description = "Disk size in GB for nodes created with the cluster"
  type        = number
}

variable "node_pool_machine_type" {
  description = "Machine type for the managed node pool"
  type        = string
}

variable "node_pool_disk_size_gb" {
  description = "Disk size in GB for the managed node pool"
  type        = number
}
