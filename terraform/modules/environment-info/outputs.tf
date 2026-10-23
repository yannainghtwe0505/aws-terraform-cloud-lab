output "aws_region" {
  description = "Aws region"
  value       = data.aws_region.current.region
}

output "aws_account_id" {
  description = "Aws account id"
  value       = data.aws_caller_identity.current.account_id
}

output "available_azs" {
  description = "Available azs"
  value       = data.aws_availability_zones.available.names
}

output "availability_zones" {
  description = "Availability zones"
  value       = local.availability_zones
}
