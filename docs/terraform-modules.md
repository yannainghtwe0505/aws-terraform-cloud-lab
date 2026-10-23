# Terraform modules

Reusable module implementations live in `terraform/modules`; environment roots pass their inputs and consume outputs. See the [module architecture and migration guide](architecture.md) for the full module inventory, dependency flow, and migration procedure.

Dev now declares infrastructure exclusively through child modules. Its `module.vpc` label references the renamed `networking` directory to preserve existing networking state addresses. All other extracted resources have explicit `moved` blocks, and the root output contract is retained.

Staging retains `application_config` and adds the shared `environment-stack` module for its AWS profile. Production uses the same shared stack with its own inputs and backend key. Terraform labs remain isolated learning roots rather than deployment environments. See [deployment prerequisites](deployment.md) before enabling the new stacks.
