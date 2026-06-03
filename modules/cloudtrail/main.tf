resource "aws_cloudtrail" "this" {
  name                          = var.name
  s3_bucket_name                = var.s3_bucket_name
  include_global_service_events = true
  is_multi_region_trail         = var.is_multi_region_trail
  enable_log_file_validation    = true
  kms_key_id                    = var.kms_key_id
  tags                          = var.tags
}
