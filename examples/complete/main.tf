data "alicloud_regions" "default" {
  current = true
}

data "alicloud_account" "default" {
}

module "ram" {
  source = "../.."

  #alicloud_ram_role
  create_actiontrail_default_role = true

  ram_role_default_name = "tf-testacc-role-2022"
  role_document         = var.role_document
  ram_role_description  = var.ram_role_description
  ram_role_force        = var.ram_role_force

  #alicloud_ram_policy
  ram_policy_default_name = "tf-testacc-policy-2022"
  policy_document         = var.policy_document
  ram_policy_description  = "tf-testacc-policy-description"
  ram_policy_force        = var.ram_policy_force

  #alicloud_oss_bucket
  create_oss_bucket = false

  #alicloud_log_project
  create_log_project = false

  #alicloud_actiontrail_trail
  create_actiontrail_trail = false

}

module "oss" {
  source = "../.."

  #alicloud_ram_role
  create_actiontrail_default_role = false

  #alicloud_oss_bucket
  create_oss_bucket = true

  oss_bucket_name = "tf-testacc-oss-2022"
  force_destroy   = var.force_destroy

  #alicloud_log_project
  create_log_project = false

  #alicloud_actiontrail_trail
  create_actiontrail_trail = false

}

module "log_project" {
  source = "../.."

  #alicloud_ram_role
  create_actiontrail_default_role = false

  #alicloud_oss_bucket
  create_oss_bucket = false

  #alicloud_log_project
  create_log_project = true

  log_project_name        = "tf-testacc-log-project"
  log_project_description = var.log_project_description

  #alicloud_actiontrail_trail
  create_actiontrail_trail = false

}

module "actiontrail_trail" {

  source = "../.."

  #alicloud_ram_role
  create_actiontrail_default_role = false

  #alicloud_oss_bucket
  create_oss_bucket = false

  #alicloud_log_project
  create_log_project = false

  #alicloud_actiontrail_trail
  create_actiontrail_trail = true

  this_module_name = "tf-testacc-actiontrail-trail"
  event_rw         = var.event_rw
  oss_bucket_name  = module.oss.this_oss_bucket_name
  oss_key_prefix   = module.oss.this_oss_bucket_name
  log_project_arn = join(
    "/",
    [
      join(
        ":",
        [
          "acs:log",
          data.alicloud_regions.default.regions[0].id,
          data.alicloud_account.default.id,
          "project",
        ],
      ),
      join("", [module.log_project.this_log_project_name]),
    ],
  )
  sls_write_role_arn = module.ram.this_ram_role_arn

}