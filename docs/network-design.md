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

## Security Groups

### ALB Security Group

Inbound:

- TCP 80 from 0.0.0.0/0
- TCP 443 from 0.0.0.0/0

### EC2 Security Group

Inbound:

- TCP 8080 from ALB Security Group

### RDS Security Group

Inbound:

- TCP 5432 from EC2 Security Group

## Security Flow

Internet
→ ALB

ALB
→ EC2

EC2
→ RDS

Direct internet access to EC2 and RDS is not allowed by these rules.

## Compute

An EC2 application server is deployed into a private subnet.

The EC2 instance:

- Does not have a public IP address.
- Uses the EC2 Security Group.
- Uses an IAM Role through an Instance Profile.
- Is intended to host the Spring Boot application later.

## IAM

The EC2 instance uses an IAM Role rather than static AWS access keys.

The project follows the principle of least privilege.

## Private EC2 Management

The application EC2 instance does not have a public IP address.

AWS Systems Manager Session Manager is used for administrative access.

VPC Interface Endpoints provide private connectivity from the EC2 instance to Systems Manager services.

Required endpoints:

- SSM
- SSMMessages
- EC2Messages

The EC2 instance uses the AmazonSSMManagedInstanceCore IAM policy.
