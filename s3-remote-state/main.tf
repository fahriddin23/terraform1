resource "aws_s3_bucket" "remote-state" {
    bucket = var.bucket_name
    tags = local.tags
    
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.remote-state.id
  versioning_configuration {
    status = "Enabled"
    
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_key_rule" {
  bucket = aws_s3_bucket.remote-state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_instance" "ubuntu" {
  ami                    = data.aws_ami.amazon_ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  #user_data              = file("${path.module}/user_data.sh")
  vpc_security_group_ids = [aws_security_group.ssh_port.id]
  tags = merge(
    local.tags,
    {
      Name = "webserver-${var.env}"
    }
  )
}

resource "aws_security_group" "ssh_port" {
  name        = "ubuntu-securitygroup"
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