# Terraform Modules

## Purpose

Terraform modules allow infrastructure configurations to be reused across environments.

## Current Structure

```
terraform/
├── modules/
│   └── vpc/
│
└── environments/
    └── dev/
```

## VPC Module

The VPC module is responsible for the network foundation.

It receives configuration through variables and exposes important resource information through outputs.

### Inputs

- vpc_cidr
- name_prefix
- environment

### Outputs

- vpc_id
- vpc_cidr

## Module Flow

```
Environment
→ Module Input
→ VPC Module
→ AWS Resources
→ Module Output
```
