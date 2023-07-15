provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Name        = "zurch-cloud-hackathon"
      Environment = "local"
      ManagedBy   = "Terraform"
    }
  }

}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6.2"
    }
  }
}
