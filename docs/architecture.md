# Day 29 module organization

The full architecture diagram is planned for Day 30. This document records code organization and migration.

| Module | Responsibility |
| --- | --- |
| `networking` | Existing VPC implementation renamed from `vpc`: subnets, Internet Gateway, routes and route tables |
| `security-groups` | ALB, application, database and endpoint rules |
| `ec2` | Existing standalone dev instance and AMI lookup |
| `autoscaling` | Private multi-subnet Auto Scaling, launch template, rolling refresh and CPU target tracking |
| `alb` | Load balancer, optional HTTPS/redirect and optional standalone target attachment |
| `rds` | Database, subnet group, availability, backup, encryption and monitoring options |
| `iam` | Instance profile, secret/log permissions and optional RDS monitoring role |
| `nat` | Existing single NAT Gateway and private outbound route |
| `vpc-endpoints` | Private SSM interface endpoints |
| `secrets` | Database secret and credential version |
| `storage` | Existing dev lab bucket |
| `environment-info` | Region, account and Availability Zone data |
| `practice` | Earlier expression, function and lifecycle exercises |
| `application_config` | Existing typed application configuration |
| `monitoring` | Tiered CloudWatch alarms and application log groups |
| `environment-stack` | Reuses infrastructure modules for staging/prod |
| `deployment-access` | Exact GitHub environment OIDC trust, separate plan/apply roles and required policy boundaries |

## Environment profiles

| Setting | Dev | Staging | Prod |
| --- | --- | --- | --- |
| VPC | Existing `10.0.0.0/16` | `10.20.0.0/16` | `10.30.0.0/16` |
| Compute | Existing small standalone instance | `t3.small`, Auto Scaling 1-2 | `t3.medium`, Auto Scaling 2-4 |
| RDS | Existing Single-AZ settings | Encrypted, optional Multi-AZ, 7-day backups | Encrypted Multi-AZ, 14-day backups, deletion protection |
| HTTPS | Optional, recommended | Required | Required |
| Monitoring | Basic CPU alarm | Detailed metrics, 4 alarms, application logs | Detailed metrics, 8 alarms, application logs |
| Deployment | Controlled manual trigger, automated checks/apply | Required reviewer, no self-review | Reviewer, no self-review/admin bypass, explicit prod confirmation |
| State key | `dev/terraform.tfstate` | `staging/terraform.tfstate` | `prod/terraform.tfstate` |

Staging retains its existing configuration module and adds `module.platform`. Prod uses the same shared stack. The isolated `terraform/bootstrap/deployment-access` root requires administrator-reviewed policies and boundaries. Configured profiles are not deployed environments; see [required setup](deployment.md).

## Migration and limits

Dev retains `module.vpc` while sourcing networking, so its networking addresses and CIDRs are preserved. Its other 39 previous root resources have explicit `moved` blocks; historical VPC and database-ingress moves remain chained. The ALB module also moves its standalone attachment to index `[0]` so scaled stacks can omit it. Root output names are retained.

Basic monitoring adds a dev alarm and RDS snapshot tag copying is enabled. The refactor and profile additions are not an address-only plan. Review every proposed create, replace or destroy operation. State migrations take effect only during apply, and none was run.

Production still inherits one NAT Gateway. Auto Scaling and Multi-AZ RDS do not make all dependencies highly available. Sizes, alarm thresholds, backup restores, DNS/certificates and application health need workload-specific verification before customer use. The profiles do not resolve every existing Checkov finding.
