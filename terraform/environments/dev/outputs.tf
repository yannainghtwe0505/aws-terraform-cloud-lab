output "bucket-name" {
  description = "Name of the lab S3 bucket"
  value       = aws_s3_bucket.lab.bucket
}
