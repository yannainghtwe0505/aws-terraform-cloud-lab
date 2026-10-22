# Terraform deployment and recovery

Practice in `terraform/labs/deployment-recovery`, which uses `terraform_data` and creates no AWS infrastructure. Its state is local; the dev and staging environments use separate S3 state keys. Run these PowerShell commands from the repository root:

```powershell
cd terraform/labs/deployment-recovery
terraform init
terraform fmt -check
terraform validate
```

## Generate and review a saved plan

```powershell
terraform plan '-var=application_version=2.0' '-out=deployment.tfplan'
terraform show deployment.tfplan
```

Check the working directory, active workspace (`terraform workspace show`), input values, resource addresses, and create/update/replace/destroy actions. This lab accepts versions `1.0` and `2.0`. Changing its input updates the existing resource in place. Confirm the planned version and environment before proceeding.

Saved plans can contain sensitive values. Keep them out of Git and store them securely. See HashiCorp's [plan tutorial](https://developer.hashicorp.com/terraform/tutorials/cli/plan).

## Apply the reviewed plan

```powershell
terraform apply deployment.tfplan
terraform output
terraform state list
```

Applying a saved plan executes it without an additional approval prompt. Use the exact reviewed file. If configuration, inputs, or state change, generate and review a fresh plan. A saved plan can become stale; it is not a reusable deployment script.

## Revert a configuration change

Restore the desired values in configuration or revert the specific configuration commit with `git revert <commit-sha>`. Review the resulting diff and preserve unrelated work. Git changes files, not deployed resources.

For this lab, return to version `1.0` with a new plan:

```powershell
terraform plan '-var=application_version=1.0' '-out=rollback.tfplan'
terraform show rollback.tfplan
terraform apply rollback.tfplan
terraform output
```

Persist the intended version in configuration or your normal input source for future runs. Reverting configuration is a new deployment, and may cause replacements or data loss for real resources. Review it as carefully as a forward deployment. Restoring an old state file does not roll back infrastructure.

## State is not an infrastructure backup

State records Terraform's resource identities, attributes, and outputs. It does not back up database contents, application files, or a running service. Recover those through service-specific backups, snapshots, and recovery procedures. State recovery repairs Terraform's tracking of infrastructure; it does not recreate a previous point in time for the infrastructure itself.

## Recover state using S3 versioning

S3 bucket versioning retains earlier versions of a state object and can help recover from accidental deletion or corruption. Encryption and locking do not enable versioning. Verify that versioning is enabled on the existing backend bucket; this exercise does not change bucket settings.

Use the correct object key: `dev/terraform.tfstate` or `staging/terraform.tfstate`. The local deployment-recovery lab is not stored in that bucket.

1. Pause CI and other Terraform writers for the affected state.
2. Preserve the current state and inspect the S3 object's version history, timestamps, and candidate contents securely.
3. Determine which snapshot matches the actual resources. An older snapshot may omit resources created after it was saved.
4. Restore the selected S3 object version through an authorized recovery procedure, preserving the current version for recovery if needed. Do not delete the bucket or blindly force-push an older state.
5. Inspect `terraform state list` and review a fresh plan against actual infrastructure before any apply. Reconcile missing resource bindings through supported import/state operations when needed.

HashiCorp recommends bucket versioning for state recovery in its [S3 backend documentation](https://developer.hashicorp.com/terraform/language/backend/s3). See also [state recovery guidance](https://docs.hashicorp.com/terraform/cli/state/recover).

## Respond to a failed deployment

1. Stop concurrent runs and preserve the error output, reviewed plan, configuration revision, and any recovery state file. Treat these as potentially sensitive.
2. Identify whether the failure occurred during validation, provider operations, or state persistence. An apply can partially succeed; Terraform does not automatically undo completed operations.
3. If state was saved normally, inspect it and the actual resources, fix the cause, then generate and review a fresh plan. Do not blindly reapply the old saved plan.
4. If Terraform reports a failure to save state and writes `errored.tfstate`, preserve that file and follow the recovery instructions before another apply. Resolve backend access and reconcile state first to avoid losing track of created resources.
5. Choose whether to continue toward the desired configuration or revert it. Review replacements, destructive actions, and any required application-data recovery before applying the new plan.
6. Verify outputs, resource state, service health, and a follow-up plan. Remove a stale lock only after confirming its owning process has stopped; do not bypass locking to work around an active run.

For a safe validation-failure exercise in this lab, plan with an unsupported version:

```powershell
terraform plan '-var=application_version=3.0'
```

This should fail input validation before applying changes. It does not simulate a partially completed provider operation. See HashiCorp's [apply and error recovery tutorial](https://developer.hashicorp.com/terraform/tutorials/cli/apply).
