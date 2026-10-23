# nat module

Used by the dev environment through an explicit module call. See [architecture and migration](../../../docs/architecture.md) for dependencies and state-migration guidance.

Inputs: `name_prefix`, `environment`, `project_name`, `subnet_id`, `private_route_table_id`.

Outputs: `gateway_id`, `public_ip`.
