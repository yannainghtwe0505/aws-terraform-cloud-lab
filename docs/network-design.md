# AWS Network Design

## Region

`ap-northeast-1` (Tokyo) — the AWS region assigned to this Free AWS account.

## VPC

CIDR:

10.0.0.0/16

## Availability Zones

Use two Availability Zones.

## Subnets

### Public Subnets

- Public Subnet A
- Public Subnet B

Used for public-facing infrastructure such as the Application Load Balancer.

### Private Subnets

- Private Subnet A
- Private Subnet B

Used for application servers and database resources.

## Routing

Public subnets:

0.0.0.0/0 → Internet Gateway

Private subnets:

No direct route to the Internet Gateway.

NAT Gateway may be used for outbound internet access from private resources.

## Security

Internet
→ ALB

ALB
→ EC2

EC2
→ RDS

RDS is not directly accessible from the internet.

## Planned Architecture

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

## Terraform Resources

The network is managed by Terraform.

### VPC

10.0.0.0/16

### Public Subnets

- 10.0.1.0/24
- 10.0.2.0/24

### Private Subnets

- 10.0.11.0/24
- 10.0.12.0/24

### Internet Gateway

The Internet Gateway is attached to the VPC.

### Public Routing

Public subnets use a route table containing:

0.0.0.0/0 → Internet Gateway

### Private Routing

Private subnets currently have no direct route to the Internet Gateway.

NAT Gateway will be added later when required.
