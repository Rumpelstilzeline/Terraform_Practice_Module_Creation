# stellt sicher, dass es eine random-ID am Ende des Bucket-Names gibt
resource "random_id" "bucket_sufix" {
  byte_length = 6
}

resource "aws_s3_bucket" "example-bucket" {
  bucket = "example-bucket-${random_id.bucket_sufix.hex}"
}

output "bucket_name" {
  value = aws_s3_bucket.example-bucket.bucket
}