# Define an AWS S3 bucket with versioning and server-side encryption
resource "aws_s3_bucket" "bucket" {
  bucket = local.name_prefix
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cmk" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.cmk.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.bucket_versioning
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id = "move-to-standard-ia-and-glacier"

    # First transition: After 30 days, move objects to the STANDARD_IA storage class
    transition {
      days          = var.file_ia_days
      storage_class = "STANDARD_IA"
    }

    # Second transition: After 60 days (30 days after the first transition),
    # move objects to the GLACIER_IR storage class
    transition {
      days          = var.file_glacier_days
      storage_class = "GLACIER_IR"
    }
    status = "Enabled"
  }
}


# Define an AWS KMS key for server-side encryption in S3
resource "aws_kms_key" "cmk" {
  description         = "KMS Key for S3 Encryption"
  enable_key_rotation = true

  policy = <<-POLICY
{
    "Version": "2012-10-17",
    "Id": "kms-default",
    "Statement": [
        {
            "Sid": "Allow use of the key",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
                ]
            },
            "Action": [
                "kms:*"
            ],
            "Resource": "*"
        }
    ]
}
  POLICY
}
