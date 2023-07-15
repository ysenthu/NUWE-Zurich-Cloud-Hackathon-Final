output "instance_profile" {
  description = "The instance profile name"
  value       = aws_iam_instance_profile.instance_profile.name

}
