# Terraform Workspaces

## What a Workspace Is

A Terraform workspace is a named state instance for one Terraform configuration. The `default` workspace exists automatically; additional workspaces can be selected or created with Terraform CLI commands.

## Separate State

Each workspace has its own state, so Terraform tracks resources independently in each one while using the same configuration directory. Workspaces separate state, not configuration or access permissions, and should not be treated as a security boundary.

## `terraform.workspace`

`terraform.workspace` evaluates to the name of the currently selected workspace. Configuration can use it to select environment-specific values, for example:

```hcl
locals {
  environment = terraform.workspace
}
```

## AWS Credentials

Selecting a workspace only selects its Terraform state. It does not change AWS credentials. AWS authentication still comes from the provider configuration and the configured credential sources, such as the AWS CLI profile, environment variables, or an assumed role. A workspace name is not an AWS identity.

## Production Environments

Separate directories can be preferable for production because they allow environments to have independently managed configuration, variables, provider settings, and backend settings. This makes the separation more explicit and reduces the risk of applying the wrong configuration. Workspaces are useful for lightweight state separation, but do not provide that full environment boundary.

## S3 Backend State

With an S3 backend, the default workspace stores state at the configured `key`. Named workspaces use the `workspace_key_prefix` followed by the workspace name and the configured key. The default prefix is `env:`.

This project configures the key as `dev/terraform.tfstate`, so the default workspace uses that S3 object key and a workspace named `staging` uses:

```text
env:/staging/dev/terraform.tfstate
```

Each object contains the state for its corresponding workspace. The prefix can be changed with the backend's `workspace_key_prefix` setting.
