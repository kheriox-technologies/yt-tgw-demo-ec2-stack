data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "template_file" "user_data" {
  template = file("scripts/bootstrap.sh")
  vars = {
    hostname = "${var.ec2_name_prefix}01"
  }
}
