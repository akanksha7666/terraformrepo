provider "aws" {
  region     = "ap-south-1"
 progile     = "akanksha"
}
#create user:
    resource "aws_iam_user" "user" {
  name = "doremon"
    }

     resource "aws_iam_user" "user1" {
  name = "nobita"
    }
    
    
# create group:

resource "aws_iam_group" "group" {
  name = "batch21"
}

#group member add:
resource "aws_iam_user_group_membership" "example1" {
    user = aws_iam_user.user1.name
  groups = [
    aws_iam_group.group.name,
  ]
}

#create policy:


data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "ec2-policy"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  users      = [aws_iam_user.user.name]
  groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.policy.arn
}

#create bucket:
resource "aws_s3_bucket" "bucket" {
  bucket = "buket3010"
}
resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}


#create vpc:
resource "aws_vpc" "main1"{
  cidr_block = "192.0.0.0/17"
}
#subnet :
resource "aws_subnet" "main2" {
  vpc_id     = aws_vpc.main1.id
  cidr_block = "192.0.0.0/18"
}
#route table :
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.main1.id
}

#internet getway:
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main1.id
}

#create instance:

resource "aws_instance" "web" {
  ami           = "ami-0449c34f967dbf18a"
  instance_type = "t3.micro"
}
resource "aws_key_pair" "deployer" {
  key_name   = "ec2-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrvwIAB2WdFLB3Q/EeZyzlC8c8myB2XZE3CxwGRA+UqSxxiLN8PgvucLovxPMjk5PXu+P4Ie8n/Wf8m920bg6Eslmmc+xIA3lTq8s08Q42hmcuJ7lfn+SNOAIUa2WYvUlb2iVbvSVNch2L3i9x32zJQGFK8HZCDB7lCKcAj8TwCcDeLzf7ZCYPTzqW7HVkxH8g38OgSVDMVo7iyL8ep2WQJZ6cwyXwHhePliuYlBmuFsWFwTNz+rnMm2jBayuyTy1XLBPI7MQl4B5Bod4yuQS4jTaAY29iDnuFGd6EJiMpH08ul/eVGNuO5l8BP5hF66mak94cb5lgMn1e8Fppwxg6lVKf+KUl4W/e15UWpaKfuFS3aasPdyW+F6Ys8j+LilC0n19lBgUmOU+uXisX6tl8sj8lTRCzNsGAvjOHs7zqC4JHSKqvhrfZm2oFQRRcYegwA429oW8CMcQ+QhZ7qYzNhE7mZmBZunei2N6ow455QVl8w6KQ505xddMM+4hU4qE= shree@LAPTOP-5LC8MINI"
}
#igw attach to vpc
resource "aws_internet_gateway_attachment" "igwattach" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.main1.id
}
