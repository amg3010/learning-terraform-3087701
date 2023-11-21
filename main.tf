data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

<<<<<<< HEAD
data "aws_vpc" "default" {
  default = true
}

==resource "aws_instance" "web" {
=======
resource "aws_instance" "blog" {
>>>>>>> c9186fc4fb580e9bed6fc2fb806d55cca6e64c71
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.blog.id]
  tags = {
    Name = "HelloWorlds"
  }
}

resource "aws_security_group" {
    name = "blog"
    description = "Allow http and https in. Allow everything out"

    vpc_id=data.aws_vpc.default.id
}

resource "aws_security_group_rule" "blog_hhtp_in"{
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.blog.id
}

resource "aws_security_group_rule" "blog_hhtps_in"{
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.blog.id
}

resource "aws_security_group_rule" "blog_eveything_out"{
  type        = "engress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.blog.id
}