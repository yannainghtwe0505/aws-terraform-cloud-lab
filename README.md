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

Network design notes: [`docs/network-design.md`](docs/network-design.md)

Architecture diagrams (Mermaid + SVG):

| Topic | Doc |
| --- | --- |
| Full overview | [`docs/architecture/overview.md`](docs/architecture/overview.md) |
| VPC routing | [`docs/vpc/vpc-routing.md`](docs/vpc/vpc-routing.md) |
| NAT Gateway | [`docs/networking/nat-gateway.md`](docs/networking/nat-gateway.md) |
| Security Groups | [`docs/security/security-groups.md`](docs/security/security-groups.md) |

Planned flow:

```
Internet
    |
    v
   ALB
    |
    v
Private EC2
    |
    v
Private RDS
```

- VPC CIDR: `10.0.0.0/16`
- Two Availability Zones
- Public subnets (ALB / NAT) and private subnets (EC2, future RDS)
- Private outbound via NAT Gateway; admin access via SSM Session Manager

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
```
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
```
### Day 3 — Outputs and data sources

- Added outputs for bucket name, environment, and AWS region
- Used data sources:
  - `aws_caller_identity` to read the AWS account ID
  - `aws_availability_zones` to list AZs (needed soon for VPC/subnets)
- Documented Terraform concepts and the `dev` environment in this README
```
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
```

### Day 4 And 5 — Network design and VPC foundation

- Created `docs/network-design.md`
- Documented VPC `10.0.0.0/16` in `ap-northeast-1` (Tokyo)
- Planned two AZs with public and private subnets
- Defined routing (IGW for public, optional NAT for private)
- Defined security path: Internet → ALB → EC2 → RDS
- Implemented VPC, Internet Gateway, public/private subnets, and route tables in Terraform

```
docs/
└── network-design.md

10.0.0.0/16
│
├── 10.0.1.0/24  Public A
├── 10.0.2.0/24  Public B
│
├── 10.0.11.0/24 Private A
└── 10.0.12.0/24 Private B
```

### Day 6 — Security groups

- Created `terraform/environments/dev/security-groups.tf`
- ALB SG: allow HTTP 80 and HTTPS 443 from the internet
- EC2 SG: allow TCP 8080 only from the ALB security group
- RDS SG: allow PostgreSQL 5432 only from the EC2 security group

```
Internet
   │
   ├── TCP 80 / 443
   ▼
 ALB-SG
   │
   └── TCP 8080
   ▼
 EC2-SG
   │
   └── TCP 5432
   ▼
 RDS-SG
```

### Day 7 — Private EC2 and IAM

- Created `iam.tf` with an EC2 IAM role (trust policy for `ec2.amazonaws.com`) and instance profile
- Created `ec2.tf` with a private Amazon Linux 2023 instance (`t3.micro`, no public IP)
- AMI looked up dynamically via SSM Parameter Store
- User Data only writes `/opt/app/status.txt` (no `dnf` yet — no NAT Gateway)

### Day 8 — SSM access via VPC endpoints

- Attached `AmazonSSMManagedInstanceCore` to the EC2 IAM role
- Created `vpc-endpoints.tf` with a VPC endpoint security group (HTTPS from EC2-SG only)
- Added Interface VPC endpoints for `ssm`, `ssmmessages`, and `ec2messages` in Private Subnet A

### Day 9 — NAT Gateway for private outbound access

- Created `nat.tf` with an Elastic IP and NAT Gateway in Public Subnet A
- Added private route `0.0.0.0/0 → NAT Gateway` (existing private subnet associations reused)

### Day 10 — Application Load Balancer

- Created `alb.tf` with a public ALB across both public subnets
- Target group on port 8080 with HTTP health checks; EC2 registered as a target
- HTTP listener on port 80 forwards to the target group
- Updated EC2 User Data to install `python3` (via NAT) and run a demo HTTP server on `:8080`

### Day 11 — Private PostgreSQL RDS

- Created `rds.tf` with RDS security group (PostgreSQL 5432 from EC2-SG only), DB subnet group, and `db.t4g.micro` PostgreSQL 17
- `publicly_accessible = false`; password via gitignored `secrets.auto.tfvars` (see `secrets.auto.tfvars.example`)
- Outputs: `rds_endpoint`, `rds_port`, `rds_database_name` (password is not outputted)
