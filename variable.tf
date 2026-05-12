variable "region" {
  description = "AWS region"
  default     = "us-east-1" 
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Name prefix for all resources"
  default     = "tf-vpc-ec2"
}