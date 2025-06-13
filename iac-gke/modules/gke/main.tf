provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name = var.network_name
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = var.subnetwork_name
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.vpc_network.name
  region        = var.region
}

resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = var.node_count
  node_locations     = var.zones

  node_config {
    machine_type = var.cluster_machine_type
    disk_size_gb = var.cluster_disk_size_gb
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }

  remove_default_node_pool = true
  min_master_version       = var.master_version
}

resource "google_container_node_pool" "primary_nodes" {
  cluster        = google_container_cluster.primary.name
  location       = var.region
  node_count     = var.node_count
  node_locations = var.zones

  node_config {
    preemptible  = true
    machine_type = var.node_pool_machine_type
    disk_size_gb = var.node_pool_disk_size_gb
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.51.0, < 5.0"
    }
  }

  required_version = ">= 0.13"
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
}

output "kubernetes_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "kubernetes_cluster_master_version" {
  value = google_container_cluster.primary.master_version
}
