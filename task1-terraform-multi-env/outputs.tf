output "alb_dns_name" {
  value = module.ec2.alb_dns_name
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.id
}
