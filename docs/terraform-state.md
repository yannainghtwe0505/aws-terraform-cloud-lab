# Terraform Remote State

Dev, staging, and prod are configured to use the existing S3 bucket `yan-naing-htwe-tf-state-20260930-8472` in `ap-northeast-1` (Tokyo). No additional state bucket is needed.

## Separate state keys

| Environment | S3 object key | Configuration |
| --- | --- | --- |
| Development | `dev/terraform.tfstate` | `terraform/environments/dev/backend.tf` |
| Staging | `staging/terraform.tfstate` | `terraform/environments/staging/backend.tf` |
| Production | `prod/terraform.tfstate` | `terraform/environments/prod/backend.tf` |

Each root uses its own key even though the bucket is shared. Never initialize staging or prod with the dev key or copy state between environments. A configured backend does not mean its state object already exists: saving state during an apply creates or updates that environment's object.

After credentials and backend permissions are ready, run `terraform init` from the intended environment directory. Editing these files does not require remote initialization, migration, or infrastructure apply. For offline validation, use `terraform init -backend=false`; use a fresh temporary `TF_DATA_DIR` if an existing backend cache attempts credential refresh.

## Encryption and locking

All three backends set `encrypt = true` and `use_lockfile = true`. Locking prevents concurrent writers to the same state; each environment has its own state and lock object.

## Access and recovery

Scope environment deployment roles to their own state key and corresponding `.tflock` object. State-object reads/writes and lock-object reads/writes/deletes require separate permissions. Restrict bucket-list access by prefix. A dev deployment role must not access production state.

These backend settings do not configure bucket versioning or public-access protection. Verify the existing bucket's settings separately and enable versioning for state recovery. Do not commit state to Git. See the [deployment and recovery guide](terraform-deployment-recovery.md).
