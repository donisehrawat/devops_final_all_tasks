# Task 2 - S3 and IAM with for_each

This task creates:

- one S3 bucket per environment
- versioning only when `versioning = true`
- IAM users from all environment user lists
- duplicate users removed using `distinct`
- one IAM policy per environment bucket
- policy attachment for users in each environment
- lifecycle rules using a `dynamic` block
- remote backend example using S3 and DynamoDB

Before running, create the backend bucket and DynamoDB table or edit `provider.tf`.
