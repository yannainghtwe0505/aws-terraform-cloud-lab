run "valid_application_configuration" {
  command = plan

  variables {
    application = {
      name          = "cloud-lab"
      port          = 8080
      instance_type = "t3.micro"

      tags = {
        Environment = "dev"
      }
    }
  }

  assert {
    condition     = output.name == "cloud-lab"
    error_message = "Application name does not match."
  }

  assert {
    condition     = output.port == 8080
    error_message = "Application port must be 8080."
  }

  assert {
    condition     = output.instance_type == "t3.micro"
    error_message = "Incorrect instance type."
  }

  assert {
    condition = (
      output.tags["Environment"] == "dev"
    )

    error_message = "Environment tag is missing."
  }
}

run "default_tags_are_added" {
  command = plan

  variables {
    application = {
      name          = "backend-api"
      port          = 8080
      instance_type = "t3.small"
    }
  }

  assert {
    condition     = output.tags["ManagedBy"] == "Terraform"
    error_message = "Default ManagedBy tag is missing."
  }

  assert {
    condition     = output.name == "backend-api"
    error_message = "Application name is incorrect."
  }
}

run "reject_invalid_port" {
  command = plan

  variables {
    application = {
      name          = "invalid-app"
      port          = 70000
      instance_type = "t3.micro"
    }
  }

  expect_failures = [
    var.application
  ]
}

run "reject_empty_name" {
  command = plan

  variables {
    application = {
      name          = "   "
      port          = 8080
      instance_type = "t3.micro"
    }
  }

  expect_failures = [
    var.application
  ]
}