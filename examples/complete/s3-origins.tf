locals {
  default_s3_origin_configuration = {
    domain_name      = null
    origin_id        = null
    origin_path      = null
    s3_origin_config = {
      origin_access_identity = ""
    }
  }
  s3_origins = var.additional_s3_origins_enabled ? [
    merge(local.default_s3_origin_configuration, {
      domain_name    = module.additional_s3_origin.bucket_regional_domain_name
      origin_id      = module.additional_s3_origin.bucket_id
    }),
    merge(local.default_s3_origin_configuration, {
      domain_name    = module.additional_s3_failover_origin.bucket_regional_domain_name
      origin_id      = module.additional_s3_failover_origin.bucket_id
    })
  ] : []
  s3_origin_groups = var.additional_s3_origins_enabled ? [{
    primary_origin_id  = local.s3_origins[0].origin_id
    failover_origin_id = local.s3_origins[1].origin_id
    failover_criteria  = var.origin_group_failover_criteria_status_codes
  }] : []
}

module "additional_s3_origin" {
  source  = "cloudposse/s3-bucket/aws"
  version = "0.36.0"
  enabled = var.additional_s3_origins_enabled

  acl                = "private"
  force_destroy      = true
  user_enabled       = false
  versioning_enabled = false
  attributes         = ["s3"]

  context = module.this.context
}

module "additional_s3_failover_origin" {
  source  = "cloudposse/s3-bucket/aws"
  version = "0.36.0"
  enabled = var.additional_s3_origins_enabled

  acl                = "private"
  force_destroy      = true
  user_enabled       = false
  versioning_enabled = false
  attributes         = ["s3", "fo"]

  context = module.this.context
}
