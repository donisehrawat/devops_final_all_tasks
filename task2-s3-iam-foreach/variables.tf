variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "bucket_suffix" {
  type    = string
  default = "12345"
}

variable "environments" {
  type = map(object({
    versioning = bool
    users      = list(string)
    lifecycle_rules = list(object({
      days          = number
      storage_class = string
    }))
  }))

  default = {
    dev = {
      versioning = true
      users      = ["dev-user", "common-user"]
      lifecycle_rules = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        }
      ]
    }

    staging = {
      versioning = true
      users      = ["staging-user", "common-user"]
      lifecycle_rules = [
        {
          days          = 60
          storage_class = "STANDARD_IA"
        }
      ]
    }

    prod = {
      versioning = true
      users      = ["prod-user", "common-user"]
      lifecycle_rules = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
    }
  }
}
