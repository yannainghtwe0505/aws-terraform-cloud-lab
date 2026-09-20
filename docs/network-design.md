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
