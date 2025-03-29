# VPC
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

# Subnets
module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  public_subnet_cidrs   = var.public_subnets
  private_subnet_cidrs  = var.private_subnets
}
#  IAM
module "iam" {
  source      = "./modules/iam"
  secret_arn  = module.secrets_manager.secret_arn
}

#  Security Groups
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

# Netzwerk: Route Tables + VPC Endpoints
module "network" {
  source                  = "./modules/network"
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = module.vpc.igw_id
  public_subnets          = module.subnets.public_subnet_ids
  private_subnets         = module.subnets.private_subnet_ids
  ec2_sg_id               = module.security_groups.ec2_sg_id
  ssm_sg_id               = module.security_groups.ssm_sg_id
  aws_region              = var.aws_region
  private_route_table_ids = [module.network.private_route_table_id]
  security_group_id       = module.security_groups.vpc_endpoint_sg_id
  vpc_endpoint_sg_id      = module.security_groups.vpc_endpoint_sg_id
  private_subnet_ids      = module.subnets.private_subnet_ids
}

#  RDS
module "rds" {
  source       = "./modules/rds"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.subnets.private_subnet_ids
  rds_sg_id    = module.security_groups.rds_sg_id
  db_username  = var.db_username
  db_password  = var.db_password
}

# EC2 mit Launch Template & ASG
module "ec2" {
  source               = "./modules/ec2"
  vpc_id               = module.vpc.vpc_id
  ec2_sg_id            = module.security_groups.ec2_sg_id
  private_subnets      = module.subnets.private_subnet_ids
  ssm_sg_id            = module.security_groups.ssm_sg_id
  ec2_instance_profile = module.iam.ec2_instance_profile
}

# Load Balancer
module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  alb_sg_id       = module.security_groups.alb_sg_id
  public_subnets  = module.subnets.public_subnet_ids
  ec2_asg_name    = module.ec2.ec2_asg_name
}

# S3
module "s3" {
  source              = "./modules/s3"
  s3_bucket_name      = "spring-bucket-maciej123"
  oai_iam_arn         = module.cloudfront.oai_iam_arn
  s3_vpc_endpoint_id  = module.network.s3_vpc_endpoint_id
}

# CloudFront
module "cloudfront" {
  source                = "./modules/cloudfront"
  s3_bucket_domain_name = module.s3.s3_bucket_domain_name
}

# Secrets Manager
module "secrets_manager" {
  source      = "./modules/secrets_manager"
  db_password = var.db_password
}