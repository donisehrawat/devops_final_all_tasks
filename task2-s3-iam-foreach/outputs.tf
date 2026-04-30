output "bucket_names" {
  value = {
    for env_name, bucket in aws_s3_bucket.environment_bucket : env_name => bucket.id
  }
}

output "iam_users" {
  value = keys(aws_iam_user.users)
}
