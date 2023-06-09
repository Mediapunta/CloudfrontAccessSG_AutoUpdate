# Automatically update Security Group
data "archive_file" "sgautoupdate_py" {
    type        = "zip"
    source_file = "${path.module}/sgautoupdate.py"
    output_path = "${path.module}/sgautoupdate.zip"
}

resource "aws_lambda_function" "SGAutoUpdate_lambda" {
    filename      = "sgautoupdate.zip"
    function_name = "SGAutoUpdate_lambda"
    description = "CloudFront IP 리스트를 보안그룹에 자동으로 업데이트 해주는 람다"
    role          = "${aws_iam_role.sgautoupdate_lambda_role.arn}"
    handler       = "SGAutoUpdate_lambda.lambda_handler"
    runtime = "python3.7"
    timeout = "300" #초 단위
    depends_on = [aws_iam_role_policy_attachment.attach_sgautoupdate_lambda_role]
    tags = {
      Name = "SGAutoUpdate_lambda"
  }
}

## SNS 트리거를 위한 설정 
resource "aws_lambda_permission" "cf_sns" {
    statement_id = "AllowExecutionFromSNS"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.SGAutoUpdate_lambda.arn}"
    principal = "sns.amazonaws.com"
    source_arn = "arn:aws:sns:us-east-1:806199016981:AmazonIpSpaceChanged"
}