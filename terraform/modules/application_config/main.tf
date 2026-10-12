locals {
  default_tags = {
    ManagedBy = "Terraform"
  }

  final_tags = merge(
    local.default_tags,
    var.application.tags
  )

  application_summary = {
    name          = var.application.name
    port          = var.application.port
    instance_type = var.application.instance_type
    tags          = local.final_tags
  }
}
