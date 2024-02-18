variable "aws_iam_user-user1-name" {
  type = string
  default = "tom"
}

variable "aws_iam_user-user2-num" {
  type = number
  default = "123"
}


variable "aws_iam_user-user3-list" {
  type = list
  default = ["akanksha","sonali","pranali"]
}

variable "aws_iam_user-user4-map" {
  type = map
  default = {
    a1 = "abhi"
    a2 = "sona"
  }
}


variable "aws_iam_user-user5-any" {
  type = any
  default = {
    a1 = "kalyani"
    a2 = "gauri"
    a3 = "rutuja"
  }
}

