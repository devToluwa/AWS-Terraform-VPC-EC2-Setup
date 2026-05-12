output "vpc_id" {
  description = "ID of vpc"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "ec2_public_id" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip 
}