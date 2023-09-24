resource "aws_s3_bucket" "s3backend" {
  bucket = "bootcamp32-${lower(var.env)}-${random_integer.backend.result}" # make sure the bucket name is all lowercase. the lower() function
 # from terraform can help out - google terraform function for more info
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.s3backend.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "random_integer" "backend" {
  min = 1
  max = 500
  keepers = {
    #Generate a new number anytime the environment value change. I could also use another variable to track if I want
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3backend.id
  versioning_configuration {
    status = var.versioning
  }
}

