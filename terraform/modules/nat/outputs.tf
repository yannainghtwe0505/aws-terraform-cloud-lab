output "gateway_id" {
  description = "Gateway id"
  value       = aws_nat_gateway.main.id
}

output "public_ip" {
  description = "Public ip"
  value       = aws_eip.nat.public_ip
}
