output "name" { value = aws_autoscaling_group.application.name }
output "desired_capacity" { value = var.desired_capacity }
output "instance_type" { value = var.instance_type }
