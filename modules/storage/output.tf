output "s3_bucket_arn" {
  description = "The ID of the created VPC"
  value       = aws_s3_bucket.bucket.arn

}
output "bucket_name" {
  description = "bucket name"
  value = aws_s3_bucket.bucket.bucket
}
output "cmk_arn"{
  description = "kms key arn"
  value = aws_kms_key.cmk.arn
}