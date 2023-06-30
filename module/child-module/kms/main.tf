resource "aws_kms_key" "kms-key" {
  description = var.description
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled = var.enabled
  policy = data.aws_iam_policy_document.s3-kms-key.json
  enable_key_rotation = var.enable_key_rotation
  tags = local.common_tags
}

resource "aws_kms_alias" "kms-key-name" {
    depends_on = [ aws_kms_key.kms-key ]
    name = "alias/kms-key-${random_id.alias-key-name.hex}"
    target_key_id = aws_kms_key.kms-key.id
}

resource "random_id" "alias-key-name" {
    byte_length = 7
}

resource "random_string" "kms-key-name" {
    keepers = {
      name = local.appname
    }
    special = false
    upper = "true"
    length = 8
}

# resource "aws_kms_key_policy" "s3-key-policy" {
#   key_id = aws_kms_key.kms-key.id
#   policy = file("${path.module}/policy/kms.json")
  
# }
