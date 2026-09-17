# AWS Terraform Cloud Lab

Infrastructure-focused AWS project using Terraform.

## Goal

Build and manage AWS infrastructure using Infrastructure as Code.

## Technologies

- AWS
- Terraform
- AWS CLI
- Git
- GitHub
- Spring Boot

## Region

ap-northeast-1 (Tokyo)

## Architecture

To be added.

## Terraform

To be added.

## Application

To be added.

## Terraform Concepts Learned

- Provider
- Resource
- Variable
- Local value
- Output
- Data source
- Terraform state
- Terraform plan
- Terraform apply
- Terraform destroy

## Environment

The project currently uses a `dev` environment.

Terraform variables are used to configure:

- AWS region
- Environment name
- Project name

## Progress

### Day 1 — First Terraform resource

- Created the project layout (`terraform/`, `app/`, `scripts/`)
- Configured the AWS provider for `ap-northeast-1`
- Ran `terraform init`, `terraform plan`, `terraform apply`, and `terraform destroy`
- Created a first S3 bucket and learned that bucket names are globally unique
- Added `.gitignore` so `.terraform/` and state files are not committed

Workflow:

```
terraform init
       ↓
terraform plan
       ↓
terraform apply
       ↓
     AWS
       ↓
terraform destroy
```

### Day 2 — Environments and variables

- Moved Terraform into `terraform/environments/dev/`
- Split configuration into `providers.tf`, `variables.tf`, `terraform.tfvars`, `main.tf`, and `outputs.tf`
- Introduced variables for AWS region, environment name, and project name
- Added a `name_prefix` local value (`project_name` + `environment`)
- Tagged the S3 bucket with Environment, Project, Name, and ManagedBy
- Bucket name is now derived: `aws-terraform-cloud-lab-dev-ynhtwe-2026`
Reorganize files
      ↓
terraform init
      ↓
terraform validate
      ↓
terraform plan
      ↓
terraform apply
      ↓
Change a tag
      ↓
terraform plan
      ↓
terraform apply
      ↓
terraform destroy

### Day 3 — Outputs and data sources

- Added outputs for bucket name, environment, and AWS region
- Used data sources:
  - `aws_caller_identity` to read the AWS account ID
  - `aws_availability_zones` to list AZs (needed soon for VPC/subnets)
- Documented Terraform concepts and the `dev` environment in this README
VARIABLE
   ↓
INPUT

LOCAL
   ↓
CALCULATED / REUSABLE VALUE

RESOURCE
   ↓
CREATE / MANAGE AWS

DATA
   ↓
READ AWS

OUTPUT
   ↓
SHOW USEFUL INFORMATION