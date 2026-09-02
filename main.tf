provider "aws" {
    region = var.region
}


# s3 bucket
terraform {
  backend "s3" {
    bucket = "kaizen-aliana"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}

# ec-2
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}


variable "region"{}
variable "instance_name"{}
variable "instance_type"{}