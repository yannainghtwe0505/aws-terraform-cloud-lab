locals {
  web_rule = {
    port        = 80
    protocol    = "tcp"
    description = "HTTP"
  }

  security_rules = [
    {
      port        = 80
      protocol    = "tcp"
      description = "HTTP"
    },
    {
      port        = 443
      protocol    = "tcp"
      description = "HTTPS"
    },
    {
      port        = 8080
      protocol    = "tcp"
      description = "Application"
    }
  ]

  application_rules = [
    {
      name        = "http"
      port        = 80
      description = "HTTP traffic"
    },
    {
      name        = "https"
      port        = 443
      description = "HTTPS traffic"
    },
    {
      name        = "app"
      port        = 8080
      description = "Application traffic"
    }
  ]

  application_rule_names = [
    for rule in local.application_rules : rule.name
  ]

  application_rule_map = {
    for rule in local.application_rules :
    rule.name => rule.port
  }
}

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

locals {
  # toset() removes duplicate application names.
  application_names = [
    "web",
    "api",
    "worker",
    "api"
  ]

  unique_applications = toset(local.application_names)

  # tolist() converts a set to a list; set order is not guaranteed.
  application_set = toset([
    "web",
    "api",
    "worker"
  ])

  application_list = tolist(local.application_set)

  application_map = tomap({
    web    = 80
    api    = 8080
    worker = 9000
  })

  # merge() combines maps; later maps override matching keys.
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  application_tags = {
    Component = "Application"
    Team      = "Cloud"
  }

  final_tags = merge(
    local.common_tags,
    local.application_tags
  )

  public_ports = [
    80,
    443
  ]

  # application_ports is already defined by the loops exercise.
  additional_application_ports = [
    8080,
    8443
  ]

  all_ports = concat(
    local.public_ports,
    local.additional_application_ports
  )

  subnet_groups = [
    [
      "public-a",
      "public-b"
    ],
    [
      "private-a",
      "private-b"
    ]
  ]

  all_subnets = flatten(local.subnet_groups)

  ports_with_duplicates = [
    80,
    443,
    80,
    8080,
    443
  ]

  unique_ports = distinct(
    local.ports_with_duplicates
  )

  unsorted_ports = [
    8080,
    443,
    80,
    22
  ]

  # sort() converts these numbers to strings and sorts lexicographically:
  # ["22", "443", "80", "8080"].
  sorted_ports = sort(
    local.unsorted_ports
  )

  service_ports = {
    web    = 80
    api    = 8080
    worker = 9000
  }

  service_names = keys(
    local.service_ports
  )

  service_port_values = values(
    local.service_ports
  )

  services = {
    web = {
      port = 80
    }

    api = {
      port = 8080
    }

    worker = {
      port = 9000
    }
  }

  service_names_upper = [
    for name in keys(local.services) :
    upper(name)
  ]

  application_service_ports = {
    for name, port in local.service_ports :
    name => port
    if port >= 8080
  }
}


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

resource "terraform_data" "application_config" {
  input = {
    application = "aws-terraform-cloud-lab"
    environment = var.environment
  }
}

resource "terraform_data" "application_deployment" {
  input = {
    application = "aws-terraform-cloud-lab"
    environment = var.environment
  }

  depends_on = [
    terraform_data.application_config
  ]
}

resource "terraform_data" "replaceable" {
  input = {
    version = "v1"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "terraform_data" "protected_resource" {
  input = {
    name = "important-resource"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "terraform_data" "managed_resource" {
  input = {
    application = "cloud-lab"
    owner       = "terraform"
  }

  lifecycle {
    ignore_changes = [
      input
    ]
  }
}
