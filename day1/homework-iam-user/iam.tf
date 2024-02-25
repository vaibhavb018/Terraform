provider  "aws" {
    region = "ap-southeast-1"
}

resource "aws_iam_user" "new_user" {
    Name = "new_user"
}