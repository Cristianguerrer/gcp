module "gke" {
  source = "../../modules/gke"

  project_id     = var.project_id
  region         = var.region
  zones          = var.zones
  cluster_name   = var.cluster_name
  node_count     = var.node_count
  min_node_count = var.min_node_count
  max_node_count = var.max_node_count
  master_version = var.master_version
  network_name        = var.network_name
  subnetwork_name     = var.subnetwork_name
  ip_cidr_range       = var.ip_cidr_range
  cluster_machine_type = var.cluster_machine_type
  cluster_disk_size_gb = var.cluster_disk_size_gb
  node_pool_machine_type = var.node_pool_machine_type
  node_pool_disk_size_gb = var.node_pool_disk_size_gb
}
