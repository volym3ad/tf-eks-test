variable "region" {
  description = "AWS region to deploy to."
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of EKS cluster to create."
  default     = "tf-eks-test"
}