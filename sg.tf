## 답변: Amazon Cloudfront 글로벌 IP 공간에는 현재 60개가 넘는 고유 서브넷이 포함되어 있습니다. 
## 따라서 보안 그룹별로 인바운드 규칙과 아웃바운드 규칙을 각각 60개씩 지정할 수 있습니다(총 120개 규칙). 
## AWS Lambda 함수는 첫 60개 인바운드 규칙을 첫 번째 글로벌 보안 그룹에, 나머지 규칙을 두 번째 글로벌 보안 그룹에 추가합니다.
## CloudFront 의 경우 Global 과 Regional 서비스가 있으므로 각각 설정
resource "aws_security_group" "CloudfrontA_SG" {
  name        = "CloudfrontA_SG"
  description = "Cloudfront Access Security Group"
  vpc_id      = "<VPC ID 입력>"   #"${aws_vpc.main.id}" #단독 실행 VPC ID 지정 필요 
  tags = {
    Name = "CloudfrontA_SG"
    AutoUpdate = "true"
    Protocol = "http"
    Rule = "cloudfront_g"
  }
  ## 해당 CloudFront를 위한 보안그룹 생성은 람다를 통해 자동 입력하므로 생략
  # ingress {
  #   protocol  = -1
  #   self      = true
  #   from_port = 0
  #   to_port   = 0
  # }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
}


resource "aws_security_group" "CloudfrontB_SG" {
  name        = "CloudfrontB_SG"
  description = "Cloudfront Access Security Group"
  vpc_id      = "<VPC ID 입력>"   #"${aws_vpc.main.id}" #단독 실행 VPC ID 지정 필요 
  tags = {
    Name = "CloudfrontB_SG"
    AutoUpdate = "true"
    Protocol = "http"
    Rule = "cloudfront_g"
  }
  ## 해당 CloudFront를 위한 보안그룹 생성은 람다를 통해 자동 입력하므로 생략
  # ingress {
  #   protocol  = -1
  #   self      = true
  #   from_port = 0
  #   to_port   = 0
  # }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
}

## CloudFront 의 경우 Global 과 Regional 서비스가 있으므로 각각 설정
resource "aws_security_group" "CloudfrontR_SG" {
  name        = "CloudfrontR_SG"
  description = "Cloudfront Access Security Group"
  vpc_id      = "<VPC ID 입력>"   #"${aws_vpc.main.id}" #단독 실행 VPC ID 지정 필요 
  tags = {
    Name = "CloudfrontR_SG"
    AutoUpdate = "true"
    Protocol = "http"
    Rule = "cloudfront_r"
  }
}