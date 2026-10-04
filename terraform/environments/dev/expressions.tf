locals {
  # ---------------------------------------------------------
  # 1. lookup()
  # ---------------------------------------------------------

  instance_sizes = {
    dev     = "t3.micro"
    staging = "t3.small"
    prod    = "t3.medium"
  }

  dev_instance_size = lookup(
    local.instance_sizes,
    "dev",
    "t3.micro"
  )

  # ---------------------------------------------------------
  # 2. Conditional expression
  # ---------------------------------------------------------

  recommended_instance_size = var.environment == "prod" ? "t3.medium" : "t3.micro"

  # ---------------------------------------------------------
  # 3. try()
  # ---------------------------------------------------------

  application_config = {
    name = "my-app"
  }

  application_port = try(
    local.application_config.port,
    8080
  )

  # ---------------------------------------------------------
  # 4. coalesce()
  # ---------------------------------------------------------

  final_app_name = coalesce(
    var.optional_app_name,
    "default-app"
  )

  # ---------------------------------------------------------
  # 5. contains()
  # ---------------------------------------------------------

  supported_environments = [
    "dev",
    "staging",
    "prod"
  ]

  is_supported_environment = contains(
    local.supported_environments,
    var.environment
  )

  # ---------------------------------------------------------
  # 6. Conditional + contains()
  # ---------------------------------------------------------

  environment_status = contains(
    local.supported_environments,
    var.environment
  ) ? "supported" : "unsupported"

  # ---------------------------------------------------------
  # 7. lookup() + environment
  # ---------------------------------------------------------

  environment_instance_sizes = {
    dev     = "t3.micro"
    staging = "t3.small"
    prod    = "t3.medium"
  }

  selected_instance_size = lookup(
    local.environment_instance_sizes,
    var.environment,
    "t3.micro"
  )
}