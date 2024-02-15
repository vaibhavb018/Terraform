provider "aws" {
    region = "ap-southeast-1"
}
resource "aws_security_group" "my_sg" {
    name = "my-sec-group"
    description = "allow-ssh and http"
    vpc_id = var.vpc_id
    ingress {
        protocol = "TCP"
        from_port = 22
        to_port  = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        protocol = "TCP"
        from_port = "80"
        to_port  = "80"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        protocol = "-1"  
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}


# Launch AWS Instance
resource "aws_instance" "my_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "key"
    vpc_security_group_ids = ["sg-00cd547f6b9a7b9dd", aws_security_group.my_sg.id]
    tags = {
        Name = "my-instance"
        env = "dev"
    }
}

resource "aws_instance" "another_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "key"
    vpc_security_group_ids = ["sg-00cd547f6b9a7b9dd"]
    tags = {
        Name = "another-instance"
        env = "dev"
    }
}


# Variables

variable "image_id" {
    default = "ami-0fa377108253bf620"
}

variable "machine_type" {
    default = "t2.micro"
}

variable "vpc_id" {
    default = "vpc-0f4ab1037cf8ad135"
}
