provider "aws" {
    region = "ap-southeast-1"
}
resource "aws_iam_user" "lb" {
name = "v-user"
tags = {
    tag-key = "v-user"
}
}
