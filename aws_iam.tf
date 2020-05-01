resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.app_name}-role"
  path = "/"
  role = aws_iam_role.ec2_role.name
}
resource "aws_iam_role" "ec2_role" {
  name               = "${var.app_name}-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}
resource "aws_iam_role_policy_attachment" "managed_policies" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.managed_policies[count.index]
  count      = length(var.managed_policies)
}