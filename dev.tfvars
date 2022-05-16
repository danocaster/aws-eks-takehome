aws_region   = "us-east-1"
aws_vpc_cidr = "10.0.0.0/16"
availability_zones = {
  us-east-1a = { "private" : "10.0.0.0/24", "public" : "10.0.2.0/24" }
  us-east-1b = { "private" : "10.0.1.0/24", "public" : "10.0.4.0/24" }
}

eks_name = "ekscluster"

node_scaling = {
  desired_size = 1
  max_size     = 1
  min_size     = 1
}