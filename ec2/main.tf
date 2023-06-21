resource "aws_instance" "webserver" {
  ami                    = "ami-090e0fc566929d98b"
  instance_type          = "t2.micro"
  key_name               = "lenovo"
  vpc_security_group_ids = [aws_security_group.ssh_port.id]
  tags = {
    Name = "webserver"
  }
}

resource "aws_security_group" "ssh_port" {
  name        = "webserver-securitygroup"
  description = "Allow ssh connection"
  vpc_id      = "vpc-043b5aa5a78cd8fec"

  ingress {
    description      = "Allows port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["98.227.136.153/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
