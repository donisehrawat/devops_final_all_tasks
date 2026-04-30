locals {
  name = "${var.project_name}-${var.environment}"
}

module "vpc" {
  source = "./modules/vpc"

  name = local.name
}

module "ec2" {
  source = "./modules/ec2"

  name               = local.name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type      = var.instance_type

  min_size         = var.environment == "prod" ? 2 : 1
  desired_capacity = var.environment == "prod" ? 2 : 1
  max_size         = var.environment == "prod" ? 5 : 1
}

module "rds" {
  source = "./modules/rds"

  name                  = local.name
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  ec2_security_group_id = module.ec2.ec2_security_group_id
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "${local.name}-${var.bucket_suffix}"

  tags = {
    Name        = "${local.name}-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
