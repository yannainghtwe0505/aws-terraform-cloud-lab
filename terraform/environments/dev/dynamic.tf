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