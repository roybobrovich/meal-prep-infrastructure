# Terraform Backend Infrastructure

This directory contains Terraform code to create the remote backend infrastructure for storing Terraform state.

## Resources Created

- **S3 Bucket**: Stores Terraform state files
  - Versioning enabled (recover from mistakes)
  - Encryption enabled (AES256)
  - Public access blocked
  
- **DynamoDB Table**: Prevents concurrent Terraform operations
  - Pay-per-request billing (minimal cost)
  - Stores state locks

## Cost

Approximately **$0.01/month** (<1 cent):
- S3: ~$0.002/month for 100MB
- DynamoDB: ~$0.0001/month for occasional locks

## Usage

### Initial Setup (Run Once)
```bash
# Initialize Terraform
terraform init

# Plan the changes
terraform plan

# Apply (create resources)
terraform apply
```

### After Setup

The output will show your bucket name and table name. Use these in your main Terraform configurations.

## Note

This backend configuration uses **local state** initially because you can't store state in S3 before S3 exists! After creating these resources, other Terraform projects will use this S3 bucket as their backend.
