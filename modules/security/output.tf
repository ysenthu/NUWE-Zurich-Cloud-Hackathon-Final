# Outputs

output "id" {
  description = "The ID of the created VPC"
  value       = aws_security_group.sg.id
}
