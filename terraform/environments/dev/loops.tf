locals {
  environments = [
    "dev",
    "staging",
    "prod"
  ]

  environment_upper = [
    for env in local.environments : upper(env)
  ]

  environment_map = {
    dev     = "development"
    staging = "staging"
    prod    = "production"
  }

  environment_descriptions = {
    for key, value in local.environment_map :
    key => upper(value)
  }

  ports = [80, 443, 8080, 22]

  application_ports = [
    for port in local.ports : port
    if port > 100
  ]
}