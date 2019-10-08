provider "alicloud" {
  region = "cn-shanghai"
}

##################################################
# OSS bucket which is used as an argument in actiontrail
##################################################
module "bucket" {
  source      = "terraform-alicloud-modules/oss-bucket/alicloud"
  bucket_name = "complete-actiontrail-demo"
}

################################################
# ActionTrail with complete set of arguments
################################################

module "actiontrail" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source           = "./.."
  this_module_name = "main-actiontrail"
  oss_bucket_name  = module.bucket.this_oss_bucket_id
}

