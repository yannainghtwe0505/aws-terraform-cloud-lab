terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for security group examples"
}

variable "application_security_group_id" {
  type        = string
  description = "Security group ID of the application servers"
}

resource "aws_security_group" "database" {
  name        = "database-sg"
  description = "Database access restricted to application servers"
  vpc_id      = var.vpc_id

  tags = {
    Name = "database-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "postgres" {
  description                  = "PostgreSQL access from application servers"
  security_group_id            = aws_security_group.database.id
  referenced_security_group_id = var.application_security_group_id

  ip_protocol = "tcp"
  from_port   = 5432
  to_port     = 5432
}
