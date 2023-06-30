data "aws_iam_policy_document" "s3-kms-key" {
  statement {
    sid = "enable IAM user permissions"

    actions = [
      "kms:*",
    ]

    resources = [
      "*",
    ]

    principals {
        type = "AWS"
        identifiers = ["arn:aws:iam::750487810911:root"]
    }
    }
}