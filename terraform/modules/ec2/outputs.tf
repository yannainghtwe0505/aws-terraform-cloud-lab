output "instance_id" {
  description = "Instance id"
  value       = aws_instance.app.id
}

output "private_ip" {
  description = "Private ip"
  value       = aws_instance.app.private_ip
}

output "private_dns" {
  description = "Private dns"
  value       = aws_instance.app.private_dns
}
