# secrets module

Used by the dev environment through an explicit module call. See [architecture and migration](../../../docs/architecture.md) for dependencies and state-migration guidance.

Inputs: `name_prefix`, `environment`, `project_name`, `db_username`, `db_password`, `database_name`, `database_host`, `database_port`.

Outputs: `arn`.

Database credentials are sensitive inputs. Terraform state must also be protected.
