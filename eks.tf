resource "aws_security_group" "worker_ssh_access" {
  name_prefix = "worker_ssh_access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "12.2.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.17"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  worker_groups = [
    {
      name                          = "demand-us-east-1"
      instance_type                 = "t3.small"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_ssh_access.id]
    }
  ]

  tags = {
    Terraform = "true"
  }
}
