variable "aws_region" {
  default = "ap-southeast-2"
}

variable "app_name" {
  default = "tgw-demo"
}

variable "vpc_cidr" {}

variable "vpc_id" {
  default = "vpc-xxxxxxxxxxxxxxxxxxxx"
}

variable "private_subnets" {
  default = [
    { id = "subnet-xxxxxxxxxxxxxxxxxxxx", cidr = "xxx.xxx.xxx.xxx/xx" },
    { id = "subnet-xxxxxxxxxxxxxxxxxxxx", cidr = "xxx.xxx.xxx.xxx/xx" },
    { id = "subnet-xxxxxxxxxxxxxxxxxxxx", cidr = "xxx.xxx.xxx.xxx/xx" }
  ]
}

variable "managed_policies" {
  default = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
}

variable "instance_size" {
  default = "t3.micro"
}

variable "root_block_device" {
  default = {
    type = "gp2",
    size = "20"
  }
}

variable "source_ami" {
  default = "ami-08fdde86b93accf1c"
}

variable "ec2_name_prefix" {
  default = "TGWDEMO"
}

