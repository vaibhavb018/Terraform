provider "aws" {
region = "ap-southeast-1"
}
resource "aws_instance" "my_instance" { 
ami = "ami-0fa377108253bf620"
instance_type = "t2.micro"
key_name = "key"
vpc_security_group_ids = ["sg-00cd547f6b9a7b9dd"]
}
