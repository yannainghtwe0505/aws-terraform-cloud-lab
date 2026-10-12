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
