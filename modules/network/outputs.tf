# Outputs

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnets_ids" {
  description = "The IDs of the created public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  description = "The IDs of the created private subnets"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "The ID of the created Internet Gateway"
  value       = aws_internet_gateway.main.id
}

