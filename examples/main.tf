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
  source          = ".."
  name            = "main-actiontrail"
  oss_bucket_name = "${module.bucket.this_oss_bucket_id}"
}
