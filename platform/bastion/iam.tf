resource "aws_iam_role" "bastion_role" {
  name = "${var.bastion_name}-Role"
  assume_role_policy = "${file("${path.module}/policies/assume-role-policy.json")}"
}

resource "aws_iam_role_policy" "bastion_policy" {
  name = "${var.bastion_name}-Policy"
  role = "${aws_iam_role.bastion_role.id}"
  policy = "${file("${path.module}/policies/role-policy.json")}"
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.bastion_name}-Profile"
  role = "${aws_iam_role.bastion_role.name}"
}
