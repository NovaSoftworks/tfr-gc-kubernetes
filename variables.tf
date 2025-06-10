variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "location" {
  description = "The location where the GKE cluster will be created. Can be a region or a zone."
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
}

variable "node_type" {
  description = "The machine type for the node pool."
  type        = string
}

variable "node_disks_size_gb" {
  description = "The size of the node disks in GB."
  type        = number
  default     = 10
}

variable "node_count" {
  description = "The number of nodes in the node pool."
  type        = number
  default     = 1
}

variable "node_tags" {
  description = "A list of tags to apply to the nodes."
  type        = list(string)
  default     = []
}

variable "network_id" {
  description = "The VPC network ID."
  type        = string
}

variable "subnet_id" {
  description = "The subnetwork ID."
  type        = string
}

variable "pods_range_name" {
  description = "The name of the secondary range for pods."
  type        = string
}

variable "services_range_name" {
  description = "The name of the secondary range for services."
  type        = string
}