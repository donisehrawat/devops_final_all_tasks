# Task 1 - Multi Environment Infrastructure

This task is written in a simple beginner style using three modules:

- `modules/vpc` creates VPC, public subnets, private subnets, Internet Gateway, NAT Gateway, and route tables.
- `modules/alb` creates public ALB, launch template, Auto Scaling Group, security groups, and installs Nginx.
- `modules/rds` creates private MySQL RDS accessible only from EC2.

The root folder also creates an S3 bucket with versioning enabled.

## Environments

- `dev.tfvars`: 1 EC2 instance
- `staging.tfvars`: 1 EC2 instance
- `prod.tfvars`: Auto Scaling with min 2 and max 5

## Run

```bash
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

For prod:

```bash
terraform plan -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars
```
