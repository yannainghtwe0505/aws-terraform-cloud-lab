# Disaster recovery notes

Follow the [deployment recovery guide](terraform-deployment-recovery.md) for failed applies and state restoration. State recovers Terraform tracking; databases and application data require separate backups and tested restore procedures.

Staging configures seven-day RDS backups, encryption, final snapshots and optional Multi-AZ. Prod configures fourteen-day backups, encryption, final snapshots, Multi-AZ, and ALB/RDS deletion protection. These are code settings until reviewed and applied. Disable deletion protection only for an approved teardown; handle an existing final snapshot with the same name before repeating database deletion.

Pause all writers, preserve the current state and use the matching environment key during recovery. Review a fresh plan against actual infrastructure before apply. Recovery objectives, restore drills and application-data backups remain workload-specific decisions. The production stack still uses one NAT Gateway. The full architecture diagram is planned for Day 30.
