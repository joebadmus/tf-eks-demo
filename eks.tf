data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks"
  cluster_version = "1.17"
  subnets         = [aws_subnet.subnet-a.id, aws_subnet.subnet-c.id, aws_subnet.subnet-d.id]
  vpc_id          = aws_vpc.main_vpc.id

  node_groups = {
    public = {
      subnets          = [aws_subnet.subnet-a.id]
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "t2.small"
      k8s_labels = {
        Environment = "pblic"
      }
      additional_tags = {
        ExtraTag = "public"
      }
    }

    private = {
      subnets          = [aws_subnet.subnet-c.id, aws_subnet.subnet-d.id]
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "t2.small"
      k8s_labels = {
        Environment = "private"
      }
      additional_tags = {
        ExtraTag = "private"
      }
    }
  }
}


