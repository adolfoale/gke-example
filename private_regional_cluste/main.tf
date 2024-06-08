# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

resource "google_compute_network" "default" {
  name                     = "vpc-01"
  project                  = "optical-caldron-421816"
  auto_create_subnetworks  = false
  enable_ula_internal_ipv6 = true
}

resource "google_compute_subnetwork" "default" {
  name    = "us-central1-01"
  project = "optical-caldron-421816"

  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"

  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "INTERNAL" # Change to "EXTERNAL" if creating an external loadbalancer

  network = google_compute_network.default.id
  secondary_ip_range {
    range_name    = "us-central1-01-gke-01-pods"
    ip_cidr_range = "192.168.0.0/24"
  }

  secondary_ip_range {
    range_name    = "us-central1-01-gke-01-services"
    ip_cidr_range = "192.168.1.0/24"
  }
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = "optical-caldron-421816"
  name                       = "gke-private-cluster"
  region                     = "us-central1"
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network                    = "vpc-01"
  subnetwork                 = "us-central1-01"
  ip_range_pods              = "us-central1-01-gke-01-pods"
  ip_range_services          = "us-central1-01-gke-01-services"
  create_service_account     = false
  service_account            = "791582853027-compute@developer.gserviceaccount.com"
  enable_private_endpoint    = true
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.16.0.0/28"
  default_max_pods_per_node  = 20
  remove_default_node_pool   = true
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = true
  gce_pd_csi_driver          = true
  deletion_protection        = false

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-standard-2"
      node_locations     = "us-central1-a,us-central1-b,us-central1-c"
      min_count          = 1
      max_count          = 1
      local_ssd_count    = 0
      spot               = false
      disk_size_gb       = 20
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      logging_variant    = "DEFAULT"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "791582853027-compute@developer.gserviceaccount.com"
      preemptible        = true
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }

  master_authorized_networks = [
    {
      cidr_block   = "10.0.0.0/16"
      display_name = "VPC"
    },
  ]
}