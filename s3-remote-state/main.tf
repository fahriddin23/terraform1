module "aws_s3_bucket" {
  source                  = "../module/child-module/kms"
  description             = "kms key for s3 bucket"
  deletion_window_in_days = 7
  enabled                 = true
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "remote-state" {
  bucket = var.bucket_name
  tags   = local.tags

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
      kms_master_key_id = module.aws_s3_bucket.kms-key-id
      sse_algorithm     = "aws:kms"
      # sse_algorithm = "AES256"
    }
  }
}

# resource "aws_s3_bucket_policy" "state_policy" {
#   bucket = aws_s3_bucket.remote-state.id
#   policy = data.aws_iam_policy_document.state_policy_document.json
# }

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.remote-state.id

  policy = data.aws_iam_policy_document.state_policy_document.json
}
data "aws_iam_policy_document" "state_policy_document" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/terraform"
      ]
    }
    sid = "RemoteStatePolicy"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.remote-state.arn,
      "${aws_s3_bucket.remote-state.arn}/*",
    ]
  }
}
#   statement {
#     actions = [
#       "s3:ListBucket",
#     ]

#     resources = [
#       "aws_s3_bucket.remote-state.arn",
#     ]

#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/tf-user"]
#     }
#   }
# }

# resource "aws_instance" "ubuntu" {
#   ami           = data.aws_ami.amazon_ubuntu.id
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   #user_data              = file("${path.module}/user_data.sh")
#   vpc_security_group_ids = [aws_security_group.ssh_port.id]
#   tags = merge(
#     local.tags,
#     {
#       Name = "webserver-${var.env}"
#     }
#   )
# }

# resource "aws_security_group" "ssh_port" {
#   name        = "ubuntu-securitygroup"
#   description = "Allow ssh connection"
#   vpc_id      = "vpc-043b5aa5a78cd8fec"

#   ingress {
#     description = "Allows port 22"
#     from_port   = var.ssh_from_port
#     to_port     = var.ssh_to_port
#     protocol    = var.protocol
#     cidr_blocks = ["98.227.136.153/32"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# }