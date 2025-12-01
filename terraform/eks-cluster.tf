module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  
  cluster_name    = "myapp-eks-cluster"
  cluster_version = "1.31"  # Use a supported version (1.28, 1.29, 1.30, or 1.31)
  
  cluster_endpoint_public_access = true
  
  # Required for module v20.x
  enable_cluster_creator_admin_permissions = true
  
  vpc_id     = module.myapp-vpc.vpc_id
  subnet_ids = module.myapp-vpc.private_subnets
  
  # Control plane subnet IDs (required in v20.x)
  control_plane_subnet_ids = concat(
    module.myapp-vpc.private_subnets,
    module.myapp-vpc.public_subnets
  )
  
  tags = {
    environment = "development"
    application = "myapp"
  }
  
  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
      
      instance_types = ["t2.small"]
      
      # Additional recommended settings
      capacity_type = "ON_DEMAND"
      
      labels = {
        Environment = "development"
        NodeGroup   = "dev"
      }
    }
  }
}