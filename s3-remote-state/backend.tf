# terraform {
#   backend "s3" {
#     bucket         = "tf-state-fahridd-2023"
#     key            = "sse_key_rule/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "tf-backend"
#   }
# }