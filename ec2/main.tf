resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.amazon_linux2.id
  instance_type          = var.instance_type
  key_name               = "lenovo"
  user_data              = file("${path.module}/user_data.sh")
  vpc_security_group_ids = [aws_security_group.ssh_port.id]
  tags = merge(
    local.common_tags,
    {
      Name = "webserver-${var.env}"
    }
  )
}

resource "aws_security_group" "ssh_port" {
  name        = "webserver-securitygroup"
  description = "Allow ssh connection"
  vpc_id      = "vpc-043b5aa5a78cd8fec"

  ingress {
    description = "Allows port 22"
    from_port   = var.ssh_from_port
    to_port     = var.ssh_to_port
    protocol    = var.protocol
    cidr_blocks = ["98.227.136.153/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
