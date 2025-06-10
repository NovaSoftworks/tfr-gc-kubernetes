# Terraform registry - Google Cloud Kubernetes (tfr-gc-kubernetes)

This Terraform module creates a Google Kubernetes Engine (GKE) cluster along with a node pool. It supports VPC-native (IP alias) networking and allows customization of node type, count, and network tags.

## Usage

```hcl
module "kubernetes" {
  source = "github.com/NovaSoftworks/tfr-gc-kubernetes?ref=v1.0.0"

  project_id            = "your-project-id"
  region                = "europe-west1"
  cluster_name          = "my-cluster"
  node_type             = "e2-medium"
  node_count            = 3
  node_tags             = ["allow-iap-ssh-ingress"]
  network_id            = "vpc-id"
  subnet_id             = "subnet-id"
  pods_range_name       = "pod-range"
  services_range_name   = "services-range"
}
```

## Variables

| Name                  | Description                                                                    | Type           | Required           |
| --------------------- | ------------------------------------------------------------------------------ | -------------- | ------------------ |
| project_id            | The Google Cloud Project ID where the GKE cluster will be created.             | `string`       | Yes                |
| location              | The location where the GKE cluster will be created. Can be a region or a zone. | `string`       | Yes                |
| cluster_name          | The name of the GKE cluster.                                                   | `string`       | Yes                |
| node_type             | The machine type for the node pool.                                            | `string`       | Yes                |
| node_disks_size_gb    | The size of the node disks in GB.                                              | `nu,ber`       | No (default: 10)   |
| node_count            | The number of nodes in the node pool.                                          | `number`       | No (default: 1)    |
| node_tags             | A list of network tags to apply to the node VMs (e.g. for firewall rules).     | `list(string)` | No (default: `[]`) |
| network_id            | The ID of the VPC network to attach the cluster to.                            | `string`       | Yes                |
| subnet_id             | The ID of the subnetwork to use for the GKE cluster.                           | `string`       | Yes                |
| pods_range_name       | The name of the secondary IP range for GKE pods.                               | `string`       | Yes                |
| services_range_name   | The name of the secondary IP range for GKE services.                           | `string`       | Yes                |

## Outputs

| Name                   | Description                                                                                          |
|------------------------|------------------------------------------------------------------------------------------------------|
| cluster_name           | The name of the GKE cluster.                                                                         |
| cluster_endpoint       | The IP address of the Kubernetes master endpoint.                                                    |
| cluster_ca_certificate | The base64-encoded public CA certificate used by clients to authenticate to the cluster (sensitive). |
