resource "aws_instance" "app" {
  ami = data.aws_ssm_parameter.amazon_linux_ami.value

  instance_type = var.instance_type

  subnet_id = aws_subnet.private[0].id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  associate_public_ip_address = false

  # Day 10: simple HTTP demo on :8080 for ALB health checks.
  # Private EC2 reaches the internet via Day 9 NAT Gateway for dnf.
  user_data = <<-EOF
              #!/bin/bash

              dnf install -y python3

              mkdir -p /opt/app

              cat > /opt/app/server.py <<'PYEOF'
              from http.server import BaseHTTPRequestHandler, HTTPServer

              class Handler(BaseHTTPRequestHandler):
                  def do_GET(self):
                      self.send_response(200)
                      self.send_header("Content-type", "text/plain")
                      self.end_headers()
                      self.wfile.write(b"Hello from private EC2 behind ALB")

                  def log_message(self, format, *args):
                      pass

              server = HTTPServer(("0.0.0.0", 8080), Handler)
              server.serve_forever()
              PYEOF

              nohup python3 /opt/app/server.py > /opt/app/server.log 2>&1 &
              EOF

  tags = {
    Name        = "${local.name_prefix}-app"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Tier        = "application"
  }
}
