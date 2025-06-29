resource "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.location
  project  = var.project_id

  network  = var.network_id
  subnetwork = var.subnet_id

  release_channel {
    channel = "STABLE"
  }

  private_cluster_config {
    enable_private_nodes = true
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  deletion_protection = false # TODO: remove after POC
}

resource "google_container_node_pool" "cluster_tools_node_pool" {
  name       = "${var.cluster_name}-ct-pool"
  cluster    = google_container_cluster.gke.name
  location   = var.location
  project    = var.project_id

  node_config {
    machine_type = var.cluster_tools_node_type
    tags = var.cluster_tools_node_tags
    disk_size_gb = var.cluster_tools_node_disks_size_gb

    labels = {
      purpose = "cluster-tools"
    }

    taint {
      key    = "purpose"
      value  = "cluster-tools"
      effect = "NO_SCHEDULE"
    }
  }

  initial_node_count = var.cluster_tools_node_count
}

resource "google_container_node_pool" "node_pool" {
  name       = "${var.cluster_name}-pool"
  cluster    = google_container_cluster.gke.name
  location   = var.location
  project    = var.project_id

  node_config {
    machine_type = var.node_type
    tags = var.node_tags
    disk_size_gb = var.node_disks_size_gb
  }

  initial_node_count = var.node_count
}