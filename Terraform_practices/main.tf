terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 1.0.4"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

variable "img_name" {
  type = string
  default = "ami-01123b84e2a4fba05"
}

resource "aws_instance" "web" {
#  ami = "ami-01123b84e2a4fba05"
  ami = var.img_name
  instance_type = "t2.micro"
  key_name = "VM_First_Key"
  root_block_device {
    volume_size = 20    # 20G size
  }

  tags = {
    Name = "MyInstance"
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-northeast-2c"
  size = 5

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.web.id
}
