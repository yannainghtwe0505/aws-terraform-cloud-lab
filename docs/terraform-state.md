# Terraform Remote State

## Backend

The development Terraform environment uses an Amazon S3 backend.

Terraform state is stored remotely instead of on the developer's local machine.

## State Location

S3:

dev/terraform.tfstate

## Locking

S3-native locking is enabled using:

use_lockfile = true

This prevents multiple Terraform operations from modifying the same state simultaneously.

## Security

The S3 bucket is private and public access is blocked.

S3 versioning is enabled to provide historical versions of the Terraform state.

Terraform state must never be committed to Git.
