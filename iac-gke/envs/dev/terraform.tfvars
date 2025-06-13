project_id     = "my-dev-project"
region         = "us-central1"
zones          = ["us-central1-a"]
cluster_name   = "dev-gke-cluster"
node_count     = 2
min_node_count = 1
max_node_count = 4
master_version = "1.33.0-gke.2248000"
network_name = "dev-vpc-network"
subnetwork_name = "dev-vpc-subnetwork"
ip_cidr_range = "10.10.0.0/16"
cluster_machine_type = "e2-medium"
cluster_disk_size_gb = 50
node_pool_machine_type = "e2-medium"
node_pool_disk_size_gb = 50

