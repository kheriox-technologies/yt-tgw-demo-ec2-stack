# -----------------------------------------------------------------------------------
# Key Pairs
# -----------------------------------------------------------------------------------
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "key_pair" {
  key_name   = "${var.app_name}-key"
  public_key = tls_private_key.private_key.public_key_openssh
}
# -----------------------------------------------------------------------------------
# Store keys in SSM Parameter Store
# -----------------------------------------------------------------------------------
resource "aws_ssm_parameter" "private_key_ssm_param" {
  name        = "/${var.app_name}/private-key"
  description = "Private Key for EC2 instance"
  type        = "SecureString"
  value       = tls_private_key.private_key.private_key_pem
}
resource "aws_ssm_parameter" "public_key_ssm_param" {
  name        = "/${var.app_name}/public-key"
  description = "Public Key for EC2 instance"
  type        = "SecureString"
  value       = tls_private_key.private_key.public_key_pem
}
resource "aws_ssm_parameter" "public_key_openssh_ssm_param" {
  name        = "/${var.app_name}/public-key-openssh"
  description = "Public Key for EC2 instance in openssh format"
  type        = "SecureString"
  value       = tls_private_key.private_key.public_key_openssh
}
# -----------------------------------------------------------------------------------
# EC2 Instance
# -----------------------------------------------------------------------------------
resource "aws_instance" "demo_instance" {
  ami                    = var.source_ami
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = var.instance_size
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = var.private_subnets[0].id
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = data.template_file.user_data.rendered
  root_block_device {
    delete_on_termination = "true"
    encrypted             = "true"
    volume_size           = var.root_block_device.size
    volume_type           = var.root_block_device.type
  }

  tags = {
    Name = "${var.ec2_name_prefix}01"
  }
  volume_tags = {
    Name = "${var.ec2_name_prefix}01"
  }
}
