
provider "aws" {
  region = "ap-south-1"
   access_key = "my-access-key"
  secret_key = "my-secret-key"
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Allow HTTP and SSH traffic"

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instances
resource "aws_instance" "web_server" {
  ami           = "ami-04b0b8ee9ce90920a"
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  key_name = "vj-key"

  count = 2

  user_data = <<-EOF
    #!/bin/bash
    yum install nginx -y
    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = {
    Name = "Web-Server-${count.index + 1}"
  }
}
