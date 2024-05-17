# use data source to retrieve an amazon 2 AMI

data "aws_ami" "amazon_linux-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# launch ec2 instance and install you website
resource "aws_instance" "ec2_instance" {
    ami           = data.aws_ami.amazon_linux-ami.id
    subnet_id     = aws_subnet.public_subnet_az1.id
    instance_type = "t2.micro"
    key_name      = "web-kp"
    vpc_security_group_ids = [aws_security_group.web_server_sg.id]
    user_data     = file("command.sh")

  tags = {
    Name = "WebServer"
  }
}
