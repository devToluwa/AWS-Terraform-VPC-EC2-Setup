# SOP - AWS Terraform VPC + EC2 Setup

## Objective

Provision a complete AWS networking stack and EC2 instance using Terraform as Infrastructure as Code.

---

## Prerequisites

- Windows machine
- AWS account
- VS Code installed
- Git installed

---

## Steps

### 1. Install Terraform

1. Go to terraform.io and download the Windows AMD64 binary
2. Move terraform.exe to C:\Windows\System32 using admin PowerShell:
```powershell
Copy-Item "C:\path\to\terraform.exe" "C:\Windows\System32\terraform.exe"
```
3. Verify installation:
```powershell
terraform --version
```

### 2. Install and Configure AWS CLI

1. Download and install AWS CLI from aws.amazon.com/cli
2. Verify installation:
```powershell
aws --version
```
3. In the AWS console, create a dedicated IAM user for Terraform:
   - Go to IAM -> Users -> Create user
   - Username: terraform-user
   - Attach policy: AdministratorAccess
   - Go to Security credentials tab -> Create access key -> CLI
   - Copy the Access Key ID and Secret Access Key

4. Configure AWS CLI with the IAM user credentials:
```powershell
aws configure
```
Enter when prompted:
- AWS Access Key ID: your key id
- AWS Secret Access Key: your secret key
- Default region: us-east-1
- Output format: json

5. Verify credentials are working:
```powershell
aws sts get-caller-identity
```

Note: AWS CLI saves credentials to C:\Users\username\.aws\credentials. Terraform automatically reads from this file. Never commit the .aws folder to GitHub.

### 3. Generate SSH Key Pair

1. Generate an SSH key pair on your local machine:
```powershell
ssh-keygen -t rsa -b 4096
```
2. Press Enter through all prompts to use default location (~/.ssh/id_rsa)
3. Verify the keys were created:
```powershell
ls ~/.ssh
```
You should see id_rsa and id_rsa.pub

### 4. Set Up Project

1. Create a new GitHub repo and clone it locally
2. Create the following files in the project folder:
   - main.tf - all infrastructure resources
   - variables.tf - region, vpc cidr, project name
   - outputs.tf - vpc id, subnet id, ec2 public ip
   - .gitignore - excludes .terraform/, state files, tfvars

### 5. Initialize Terraform

Run in the project folder:
```powershell
terraform init
```
This downloads the AWS provider plugin. A .terraform/ folder will be created.

### 6. Preview Infrastructure

```powershell
terraform plan
```
This shows exactly what Terraform will create in AWS without actually building anything. Review the output before proceeding.

### 7. Apply Infrastructure

```powershell
terraform apply
```
Type yes to confirm. Terraform will create all 7 resources:
- VPC
- Internet Gateway
- Public Subnet
- Route Table
- Route Table Association
- Security Group
- EC2 Instance

Note the outputs printed at the end, especially the EC2 public IP.

### 8. SSH into EC2

```powershell
ssh -i ~/.ssh/id_rsa ec2-user@<ec2_public_ip>
```
Type yes when prompted about the fingerprint.

### 9. Destroy Infrastructure

When done, tear down all resources:
```powershell
terraform destroy
```
Type yes to confirm. All 7 resources will be deleted.

---

## Issues Encountered

| Issue | Cause | Fix |
|-------|-------|-----|
| Terraform not found in terminal | exe not on PATH | Copied terraform.exe to C:\Windows\System32 |
| AWS CLI not found in terminal | AWSCLIV2 folder not on PATH | Added C:\Program Files\Amazon\AWSCLIV2 to system PATH and restarted |
| Invalid AWS credentials error | Was using root account keys | Created IAM user (terraform-user) and used those keys instead |
| EC2 created without SSH key | key_name missing from aws_instance resource and key pair resource name mismatch | Fixed resource name from "name" to "main" and added key_name to EC2 resource |
| SSH permission denied | EC2 was created before key pair was properly attached | Ran terraform destroy then terraform apply again from scratch |