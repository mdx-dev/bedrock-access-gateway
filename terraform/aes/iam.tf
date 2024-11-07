
resource "aws_iam_role_policy_attachment" "prod" {
  role       = "${module.api-80.aws_iam_role.task_role.name}"
  policy_arn = "${aws_iam_policy.app.arn}"
}

resource "aws_iam_policy" "app" {
  name        = "ZDIBedrockAccessGatewayBedrockPermissions"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
          "bedrock:*"
        ],
        "Resource": [
          "*"
        ]
    }
  ]
}
EOF
}
