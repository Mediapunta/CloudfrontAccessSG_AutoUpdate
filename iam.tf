data "aws_iam_policy_document" "sg_autoupdate_lambda_policy_doc" {
  statement {
    sid = "1"

    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }

  statement {
    actions = [
        "ec2:DescribeSecurityGroups",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:RevokeSecurityGroupIngress"
    ]

    resources = [
      "*",
    ]
    }
  }

resource "aws_iam_policy" "sg_autoupdate_lambda_policy" {
  name   = "sg_autoupdate_lambda_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.sg_autoupdate_lambda_policy_doc.json
}

resource "aws_iam_role" "sgautoupdate_lambda_role" {
  name               = "SGAutoUpdate_Lambda_Role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_sgautoupdate_lambda_role" {
 role        = aws_iam_role.sgautoupdate_lambda_role.name
 policy_arn  = aws_iam_policy.sg_autoupdate_lambda_policy.arn
}
