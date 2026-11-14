provider "aws" {
  region     = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}


resource "aws" "aws_instance" {
  # Arguments define the configuration of the infrastructure object
  ami = "ami-04b0b8ee9ce90920a"
  instance_type = "t3.micro"
  vpc_security_group = ["sg-029e4dd7fba4f23d9"]
  key_name = "vj-key"
  
}
