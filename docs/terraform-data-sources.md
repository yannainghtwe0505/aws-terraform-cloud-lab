# Terraform Data Sources

## Resource vs Data

A Terraform resource is used to create and manage infrastructure.

A Terraform data source is used to read information from existing infrastructure or AWS APIs.

## Examples

### AWS Account

data.aws_caller_identity.current.account_id

### AWS Region

data.aws_region.current.name

### Availability Zones

data.aws_availability_zones.available.names

## Flow

AWS
↓
Data Source
↓
Terraform
↓
Local Value
↓
Resource / Module

## Important

Data sources read information. They do not automatically mean Terraform manages the underlying resource.