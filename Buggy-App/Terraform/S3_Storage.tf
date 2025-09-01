data "aws_s3_bucket" "existing_bucket" {
  bucket = "jai-terra-bucket-1011"
}

resource "aws_s3_bucket_object" "Statefiles" {
  bucket  = data.aws_s3_bucket.existing_bucket.id
  key     = "example.txt"
  content = "Hello from application repo , to store my STATEFILES "
}
