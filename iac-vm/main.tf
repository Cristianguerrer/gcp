terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.30.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

data "google_compute_network" "default" {
  name = "default"
}

resource "random_id" "suffix" {
  byte_length = 3
}

# Firewall con nombre único
resource "google_compute_firewall" "minikube_allow" {
  name    = "minikube-allow-ssh-and-demo-${random_id.suffix.hex}"
  network = data.google_compute_network.default.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "8006", "3389", "5900"]
  }

  source_ranges = var.allow_cidrs
  target_tags   = ["minikube-host"]
}

# Instancia VM con nested virtualization habilitada
resource "google_compute_instance" "minikube" {
  name         = "minikube-kvm-host"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["minikube-host"]

  advanced_machine_features {
    enable_nested_virtualization = true
  }

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      size  = var.boot_disk_gb
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = data.google_compute_network.default.id
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/usr/bin/env bash
    
    # set -euxo pipefail
    # export DEBIAN_FRONTEND=noninteractive
    # SSH_USER="${var.ssh_user}"

    apt-get update
    # apt-get install -y \
    #   qemu-kvm libvirt-daemon-system virtinst bridge-utils cpu-checker \
    #   curl wget git ca-certificates apt-transport-https gnupg lsb-release \
    #   conntrack socat ebtables ethtool iptables arptables \
    #   docker.io

    # systemctl enable --now docker

    # /dev/kvm (debería existir con nested virtualization)
    # lsmod | grep kvm || true
    # if [ ! -e /dev/kvm ]; then
    #   echo "ADVERTENCIA: /dev/kvm no está presente; revisa nested virtualization."
    # fi

    # kubectl oficial
    # install -m 0755 -d /etc/apt/keyrings
    # curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    # chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    # echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' > /etc/apt/sources.list.d/kubernetes.list
    # apt-get update
    # apt-get install -y kubectl

    # Minikube
    # curl -Lo /usr/local/bin/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    # chmod +x /usr/local/bin/minikube

    # Usuario a grupos docker/kvm
    # usermod -aG docker,kvm "$SSH_USER" || true

    # kubeconfig root
    # mkdir -p /root/.kube /root/.minikube
    # touch /root/.kube/config
    # chmod -R 700 /root/.kube

    # Arranque Minikube (--driver=none)
    # minikube start --driver=none --container-runtime=docker --force --kubernetes-version=stable

    # Addons
    # minikube addons enable metrics-server || true
    # minikube addons enable ingress || true

    # kubeconfig para el usuario
    # mkdir -p /home/$SSH_USER/.kube
    # cp -f /root/.kube/config /home/$SSH_USER/.kube/config
    # chown -R $SSH_USER:$SSH_USER /home/$SSH_USER/.kube

    # Storage hostPath para tus pods
    # mkdir -p /var/lib/dockur-storage
    # chmod 777 /var/lib/dockur-storage
  EOF

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  labels = {
    role = "minikube"
  }
}

# Salidas
output "external_ip" {
  value = google_compute_instance.minikube.network_interface[0].access_config[0].nat_ip
}

output "ssh_command" {
  value = "ssh -o StrictHostKeyChecking=no ${var.ssh_user}@${google_compute_instance.minikube.network_interface[0].access_config[0].nat_ip}"
}
