# devops_final_all_tasks

This repo contains my Terraform code for the final DevOps tasks. I kept the code simple and separated the tasks into different folders.

Original task document:

[Download Devops_AllTasks.docx](docs/Devops_AllTasks.docx)

## Folder Structure

```text
devops_final_all_tasks/
├── task1-terraform-multi-env/
├── task2-s3-iam-foreach/
├── task3-simple-vpc/
└── docs/
```

## Task 1

Multi-environment Terraform project using modules.

- VPC module
- ALB module with Launch Template and Auto Scaling Group
- RDS module
- S3 bucket with versioning
- dev, staging, and prod variable files
- dev creates 1 instance
- prod uses Auto Scaling min 2 max 5
- DB deletion protection is enabled

Run example:

```bash
cd task1-terraform-multi-env
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

## Task 2

Terraform using these concepts:

- `for_each` for one S3 bucket per environment
- S3 versioning only when enabled
- IAM users combined from all environments with duplicates removed
- environment-specific IAM policies using `jsonencode`
- lifecycle rules using `dynamic`
- remote backend example using S3 and DynamoDB

Run example:

```bash
cd task2-s3-iam-foreach
terraform init
terraform plan
terraform apply
```

## Task 3

Simple Terraform code for:

- VPC
- public and private subnets
- Internet Gateway
- NAT Gateway
- route tables

Run example:

```bash
cd task3-simple-vpc
terraform init
terraform plan
terraform apply
```

## Cleanup

To avoid AWS charges, destroy resources after testing:

```bash
terraform destroy
```
