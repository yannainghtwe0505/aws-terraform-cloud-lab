terraform {
  required_version = ">= 1.5.0"
}

resource "terraform_data" "backend_application" {
  input = {
    name        = "cloud-engineer-lab"
    environment = "dev"
    version     = "1.0"
  }
}

resource "terraform_data" "database_config" {
  input = {
    engine = "postgres"
    port   = 5432
  }
}