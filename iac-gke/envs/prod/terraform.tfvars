project_id     = "my-prod-project"
region         = "us-central1"
zones          = ["us-central1-a"]
cluster_name   = "prod-gke-cluster"
node_count     = 2
min_node_count = 1
max_node_count = 4
master_version = "1.33.0-gke.2248000"
network_name = "prod-vpc-network"
subnetwork_name = "prod-vpc-subnetwork"
ip_cidr_range = "10.20.0.0/16"
cluster_machine_type = "n1-standard-2"
cluster_disk_size_gb = 50
node_pool_machine_type = "n1-standard-2"
node_pool_disk_size_gb = 50

