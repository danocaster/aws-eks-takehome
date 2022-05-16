module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  cidr            = var.aws_vpc_cidr
  azs             = [for k, v in var.availability_zones : k]
  private_subnets = [for k, v in var.availability_zones : v.private]
  public_subnets  = [for k, v in var.availability_zones : v.public]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  enable_dns_hostnames   = true

  enable_flow_log                      = true
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true

  tags = {
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
    "kubernetes.io/role/elb"                = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
    "kubernetes.io/role/internal-elb"       = 1
  }
}