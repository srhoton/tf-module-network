resource "aws_security_group" "default_bastion_inbound" {
  name = "default_bastion_inbound"
  vpc_id = aws_vpc.default_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0 
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "default_bastion_inbound"
  }
}

resource "aws_instance" "default_bastion_instance" {
  ami = "ami-0735c191cf914754d"
  instance_type = "t3.micro"
  associate_public_ip_address = true

  subnet_id = aws_subnet.default_subnets["public-1"].id
  vpc_security_group_ids = [aws_security_group.default_bastion_inbound.id]
  key_name = var.key_name

  tags = {
    Name = "default_bastion_instance"
  }
}
