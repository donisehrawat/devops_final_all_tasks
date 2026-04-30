resource "aws_s3_bucket" "environment_bucket" {
  for_each = var.environments

  bucket = "myapp-${each.key}-${var.bucket_suffix}"

  tags = {
    Name        = "myapp-${each.key}-${var.bucket_suffix}"
    Environment = each.key
  }
}

resource "aws_s3_bucket_versioning" "environment_bucket" {
  for_each = {
    for env_name, env_data in var.environments : env_name => env_data
    if env_data.versioning == true
  }

  bucket = aws_s3_bucket.environment_bucket[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "environment_bucket" {
  for_each = var.environments

  bucket = aws_s3_bucket.environment_bucket[each.key].id

  rule {
    id     = "lifecycle"
    status = "Enabled"

    filter {
      prefix = ""
    }

    dynamic "transition" {
      for_each = each.value.lifecycle_rules

      content {
        days          = transition.value.days
        storage_class = transition.value.storage_class
      }
    }
  }
}

resource "aws_iam_user" "users" {
  for_each = toset(distinct(flatten([
    for env_name, env_data in var.environments : env_data.users
  ])))

  name = each.key
}

resource "aws_iam_policy" "environment_bucket_policy" {
  for_each = var.environments

  name = "myapp-${each.key}-bucket-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:ListBucket"]
        Resource = aws_s3_bucket.environment_bucket[each.key].arn
      },
      {
        Effect = "Allow"
        Action = ["s3:GetObject", "s3:PutObject"]
        Resource = "${aws_s3_bucket.environment_bucket[each.key].arn}/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "bucket_access" {
  for_each = {
    for pair in flatten([
      for env_name, env_data in var.environments : [
        for user_name in env_data.users : {
          key       = "${env_name}-${user_name}"
          env_name  = env_name
          user_name = user_name
        }
      ]
    ]) : pair.key => pair
  }

  user       = aws_iam_user.users[each.value.user_name].name
  policy_arn = aws_iam_policy.environment_bucket_policy[each.value.env_name].arn
}
