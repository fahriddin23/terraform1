output "kms-key-id" {
    value = aws_kms_key.kms-key.id
    description = "value of kms-key-id"
}

output "kms-key-alias" {
    value = aws_kms_alias.kms-key-name.name
    description = "kms key id output"
}
