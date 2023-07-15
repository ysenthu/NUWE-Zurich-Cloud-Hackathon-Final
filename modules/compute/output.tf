output "asg_name" {
  description = "The ID of the created VPC"
  value       = aws_autoscaling_group.asg.name

}
