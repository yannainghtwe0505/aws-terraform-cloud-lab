module "application_config" {
  source = "../../modules/application_config"

  application = {
    name          = "aws-terraform-cloud-lab"
    port          = 8080
    instance_type = "t3.micro"

    tags = {
      Component = "Application"
      Team      = "Cloud"
    }
  }
}
