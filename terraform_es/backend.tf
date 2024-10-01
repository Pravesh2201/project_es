terraform {
  backend "s3" {
    bucket         = "elasticsearch-tool"      # Your S3 bucket name
    key            = "terraform/statefile.tfstate"  # Path to store state file in S3
    region         = "us-east-1"               # AWS region
    encrypt        = true                      # Enable encryption
    dynamodb_table = "terraform-lock-table"    # DynamoDB table for state locking
  }
}
