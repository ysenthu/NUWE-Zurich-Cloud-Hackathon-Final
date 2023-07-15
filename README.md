# NUWE-Zurich-Cloud-Hackathon-Final
This project provides a modularized infrastructure setup for deploying a scalable web application using AWS, Terraform and Jenkins. The infrastructure includes EC2 instances, an Auto Scaling Group (ASG), an Internet-facing Network Load Balancer (NLB) and an S3 bucket for storing build artifacts and store images uploaded by agents. Each environment specific configuration is stored separately to ensure easy management and control over the setup for different stages (like development, testing, production, etc.).

## Project Structure

- `modules/`: This directory contains the modularized Terraform code for each individual piece of infrastructure. This allows for reuse of code and easier management of the infrastructure components.
- `environments/`: This directory contains the environment specific configurations. Each environment has its own directory within this, which contains its specific setup details.
- `Jenkinsfile`: This file contains the script for Jenkins pipeline that loops through all environments and applies the infrastructure changes. It uses Terraform to manage the infrastructure.

## Assumptions

1. We're using two EC2 instances with different keys. The EC2 instances in this project is recognized as two A Auto Scaling Group
2. Scaling is handled via an Auto Scaling Group (ASG). In case of increased traffic, the ASG can be configured to spin up additional instances as needed.
3. The instances are deployed in a private subnet, and all external traffic is routed via an Internet-facing NLB.
4. During each `terraform apply`, the EC2 instances will be refreshed, and application deployment is carried out by fetching the build artifact from an S3 bucket during the user data execution stage.
5. The application will run as a service on a Linux system.

## Setup

Before running any `terraform` commands, make sure you have configured your AWS credentials either in the environment variables or through AWS CLI.

1. Initialize your Terraform workspace:

    ```bash
    terraform init environments/<environment-name>
    ```

2. Validate your changes:

    ```bash
    terraform validate environments/<environment-name>
    ```

3. Plan and apply your changes:

    ```bash
    terraform plan environments/<environment-name>
    terraform apply environments/<environment-name>
    ```

Replace `<environment-name>` with the name of your environment folder.

## Jenkins Pipeline

The Jenkins pipeline is configured to automatically loop through all the environments and apply changes as needed.

# Report

Report regards to the project can be found at docs/report.pdf

