resource "aws_instance" "app" {
  ami = data.aws_ssm_parameter.amazon_linux_ami.value

  instance_type = var.instance_type

  subnet_id = aws_subnet.private[0].id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  associate_public_ip_address = false

  # Simplified user data: no dnf install yet (private subnet has no NAT).
  user_data = <<-EOF
              #!/bin/bash

              mkdir -p /opt/app

              echo "Cloud Engineer Lab - EC2 is working" > /opt/app/status.txt
              EOF

  tags = {
    Name        = "${local.name_prefix}-app"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Tier        = "application"
  }
}
