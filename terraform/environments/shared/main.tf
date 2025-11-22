terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # This backend uses the S3 bucket we just created!
  backend "s3" {
    bucket         = "meal-prep-terraform-state-343218184411"
    key            = "shared/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "meal-prep-terraform-locks"
    encrypt        = true
    profile        = "terraform-meal-prep"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform-meal-prep"

  default_tags {
    tags = {
      Project     = "meal-prep-calculator"
      ManagedBy   = "terraform"
      Environment = "shared"
    }
  }
}

# Example resource - just to demonstrate the backend works
resource "aws_s3_bucket" "example" {
  bucket = "meal-prep-example-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "Example Bucket"
    Description = "Example bucket to demonstrate Terraform remote state"
  }
}

data "aws_caller_identity" "current" {}

output "example_bucket_name" {
  value       = aws_s3_bucket.example.id
  description = "Name of the example S3 bucket"
}
