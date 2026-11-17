provider "aws" {
  region     = "ap-south-1"
  profile    = "configs"
}



# EC2 Instances
resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.itype

  vpc_security_group_ids = [
    var.sg
  ]

  key_name = var.keyname

  count = 2
  disable_api_termination = var.api
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
