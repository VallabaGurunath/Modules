data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "role-policy" {
  statement {
    actions = ["sts:AssumeRole",
                "s3:*",
                "s3-object-lambda:*"
              ]
    effect = "Allow"
    resources = ["*"]         
  }
}
resource "aws_iam_policy" "policy" {
  name        = "CustomerManaged-Full-Access-S3"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.role-policy.json
}  

resource "aws_iam_role_policy_attachment" "role-policy-attach" {
  role = "CustomerManagedBasic-test-role"
  policy_arn = aws_iam_policy.policy.arn
}