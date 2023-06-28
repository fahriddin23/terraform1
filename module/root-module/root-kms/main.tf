module "s3-kms-key" {
  source                  = "../../child-module/kms"
  description             = "kms key for s3 bucket"
  deletion_window_in_days = 7
  enabled                 = true
  enable_key_rotation     = true
}
