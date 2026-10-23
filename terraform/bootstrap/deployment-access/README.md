# Deployment-role bootstrap

Isolated administrative root; not part of an application environment apply. Supply `aws_region`, `project_name`, `github_repository`, `oidc_provider_arn`, and reviewed per-environment policies/boundaries in the `environments` input. No administrative policy is supplied by default.

Manage bootstrap state separately and have an AWS administrator review policies before applying. See [deployment setup](../../../docs/deployment.md). No roles were deployed by this exercise.
