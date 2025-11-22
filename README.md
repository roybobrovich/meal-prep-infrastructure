# 🏗️ Meal Prep Calculator - Infrastructure as Code

Infrastructure as Code (IaC) for the Meal Prep Calculator project using Terraform.

## 📁 Structure
```
terraform/
├── backend/                    # Backend infrastructure (S3 + DynamoDB)
│   ├── main.tf                # S3 bucket and DynamoDB table for state
│   └── README.md              # Backend documentation
├── environments/
│   └── shared/                # Shared resources
│       └── main.tf            # Example infrastructure using remote backend
└── modules/                   # Reusable Terraform modules (future)
```

## 🎯 What's Deployed

### Backend Infrastructure (us-east-1)
- **S3 Bucket**: `meal-prep-terraform-state-343218184411`
  - Stores Terraform state files
  - Versioning enabled (disaster recovery)
  - Encryption enabled (AES256)
  - Public access blocked
  
- **DynamoDB Table**: `meal-prep-terraform-locks`
  - Prevents concurrent Terraform operations
  - Pay-per-request billing

### Cost
**~$0.01/month** (<1 cent):
- S3: ~$0.002/month for state storage
- DynamoDB: ~$0.0001/month for state locking

## 🚀 Usage

### Prerequisites
- Terraform >= 1.0
- AWS CLI configured with `terraform-meal-prep` profile
- Appropriate IAM permissions

### Initial Backend Setup (Done Once)
```bash
cd terraform/backend
terraform init
terraform apply
```

### Using Remote Backend
```bash
cd terraform/environments/shared
terraform init  # Configures remote backend
terraform plan
terraform apply
```

## 🔐 Security

- **Least-Privilege IAM**: Dedicated `terraform-meal-prep` user with minimal permissions
- **State Encryption**: All state files encrypted at rest (AES256)
- **State Locking**: DynamoDB prevents concurrent modifications
- **Public Access**: Completely blocked on all buckets
- **Versioning**: State file versioning enabled for rollback capability

## 🎓 Best Practices Implemented

✅ **Remote State**: State stored in S3 (not local files)  
✅ **State Locking**: DynamoDB prevents concurrent operations  
✅ **Encryption**: All data encrypted at rest  
✅ **Versioning**: Can recover from mistakes  
✅ **Tags**: All resources properly tagged  
✅ **Separation**: Backend infrastructure separate from application infrastructure  
✅ **Documentation**: Comprehensive README files  

## 🔗 Related Repositories

- **[meal-prep-app](https://github.com/roybobrovich/meal-prep-app)** - Application code, Helm charts, CI/CD
- **[meal-prep-gitops](https://github.com/roybobrovich/meal-prep-gitops)** - ArgoCD Application definitions
- **[meal-prep-infrastructure](https://github.com/roybobrovich/meal-prep-infrastructure)** - Terraform IaC (this repo)

## 📚 Learn More

- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS S3 Backend](https://www.terraform.io/docs/language/settings/backends/s3.html)
- [State Locking](https://www.terraform.io/docs/language/state/locking.html)# meal-prep-infrastructure
Terraform Infrastructure
