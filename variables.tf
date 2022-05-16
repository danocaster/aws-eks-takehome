variable "aws_region" {
  description = "The AWS Region to use as primary"
  type        = string
}

variable "eks_name" {
  description = "The name of the EKS instance"
  type        = string
}

variable "aws_vpc_cidr" {
  description = "The CIDR address space for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "The availability zones to deploy EKS nodes to"
  type        = any
}

variable "node_scaling" {
  description = "Sets the minimum, maximum and desired number of nodes to use with this cluster."
  type = object({
    max_size     = number
    min_size     = number
    desired_size = number
  })
}

variable "node_instance_types" {
  description = "The instance types to use with the cluster."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_disk_size" {
  description = "Disk size (GB) to use in the cluster's nodes."
  type        = number
  default     = 20
}

variable "node_ami_type" {
  description = "The type of Amazon Machine Image to use with this cluster."
  type        = string
  default     = "AL2_x86_64"
}

variable "ngninx_replicas" {
  description = "The number of nginx replicas to define in EKS"
  type        = number
  default     = 2
}