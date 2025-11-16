output "s3_bucket_name" {
  # bei terraform plan wird bucket name angezeigt
  value = aws_s3_bucket.project_bucket.bucket
  sensitive = true
}

output "sensitive_var" {
    sensitive = true
  value = var.my_sensitive_value
}