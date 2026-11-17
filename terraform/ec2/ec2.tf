provider "aws" {
  region     = "ap-south-1"
  profile    = "configs"
}



# EC2 Instances
resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.itype

  vpc_security_group_ids = [
     data.aws_security_group.sgdatablock.id
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



data "aws_security_group" "sgdatablock" {
   
   name = "SG for the jenkins"

}

output "inip" {
  value = aws_instance.web_server[*].public_ip

}



output "pubip" {
  value = aws_instance.web_server[*].public_dns


}