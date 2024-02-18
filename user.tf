
# create resources
  resource "aws_iam_user" "user1" {
   name = var.aws_iam_user-user1-name
}

  resource "aws_iam_user" "user2" {
   name = var.aws_iam_user-user2-num
}

  resource "aws_iam_user" "user3" {
   name = var.aws_iam_user-user3-list[2]
}

  resource "aws_iam_user" "user4" {
   name = var.aws_iam_user-user4-map.a1
}

  resource "aws_iam_user" "user5" {
   name = var.aws_iam_user-user5-any.a2
}