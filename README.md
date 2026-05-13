# AWS Terraform VPC + EC2 Setup

Provisioning a complete AWS networking stack and EC2 instance using Terraform. Infrastructure is defined as code, version controlled, and repeatable.

## Architecture

- VPC (10.0.0.0/16)
- Public Subnet (10.0.1.0/24)
- Internet Gateway
- Public Route Table
- Security Group (SSH + HTTP)
- EC2 Instance (Amazon Linux 2, t2.micro)
- SSH Key Pair

## Screenshots

**Terraform applying all 8 resources:**
![Terraform Apply](screenshots/terraform-apply.png)

**VPC, subnet and internet gateway in AWS:**
![VPC Dashboard](screenshots/vpc-console.png)

**EC2 instance running:**
![EC2 Running](screenshots/ec2-console.png)

**SSH session into the EC2:**
![SSH Session](screenshots/ssh-session.png)

## Prerequisites

- Terraform installed
- AWS CLI installed and configured
- AWS IAM user with AdministratorAccess
- SSH key pair generated (~/.ssh/id_rsa)

## Usage

```bash
terraform init
terraform plan
terraform apply
```

To SSH into the EC2 instance:
```bash
ssh -i ~/.ssh/id_rsa ec2-user@<ec2_public_ip>
```

To destroy all resources:
```bash
terraform destroy
```

## Outputs

- VPC ID
- Public Subnet ID
- EC2 Public IP

## Tech Stack

Terraform - AWS VPC - EC2 - Security Groups