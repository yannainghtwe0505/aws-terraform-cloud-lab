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
